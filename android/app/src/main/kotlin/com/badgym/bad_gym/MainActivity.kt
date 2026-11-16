package com.badgym.bad_gym

import android.app.PendingIntent
import android.content.Intent
import android.content.pm.PackageInstaller
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileInputStream
import java.net.HttpURLConnection
import java.net.URL
import java.security.MessageDigest
import java.util.concurrent.Executors

class MainActivity : FlutterActivity() {
    private val channelName = "com.badgym/update_center"
    private val executor = Executors.newSingleThreadExecutor()

    @Suppress("DEPRECATION")
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName).setMethodCallHandler { call, result ->
            when (call.method) {
                "getAppVersion" -> {
                    val info = packageManager.getPackageInfo(packageName, 0)
                    result.success(mapOf(
                        "versionName" to (info.versionName ?: "0.0.0"),
                        "versionCode" to if (Build.VERSION.SDK_INT >= 28) info.longVersionCode else info.versionCode.toLong()
                    ))
                }
                "installVerifiedApk" -> {
                    val url = call.argument<String>("url")
                    val expectedSha = call.argument<String>("sha256")?.lowercase()
                    if (url.isNullOrBlank() || expectedSha.isNullOrBlank() || !expectedSha.matches(Regex("^[a-f0-9]{64}$"))) {
                        result.error("INVALID_UPDATE", "Update URL or SHA-256 is invalid.", null)
                        return@setMethodCallHandler
                    }
                    executor.execute {
                        try {
                            val apk = downloadAndVerify(url, expectedSha)
                            val params = PackageInstaller.SessionParams(PackageInstaller.SessionParams.MODE_FULL_INSTALL)
                            params.setAppPackageName(packageName)
                            val installer = packageManager.packageInstaller
                            val sessionId = installer.createSession(params)
                            installer.openSession(sessionId).use { session ->
                                FileInputStream(apk).use { input ->
                                    session.openWrite("base.apk", 0, apk.length()).use { output ->
                                        input.copyTo(output)
                                        session.fsync(output)
                                    }
                                }
                                val intent = Intent(this, UpdateInstallReceiver::class.java).setAction(UpdateInstallReceiver.ACTION_INSTALL_STATUS)
                                val flags = PendingIntent.FLAG_UPDATE_CURRENT or if (Build.VERSION.SDK_INT >= 31) PendingIntent.FLAG_MUTABLE else 0
                                val pending = PendingIntent.getBroadcast(this, sessionId, intent, flags)
                                session.commit(pending.intentSender)
                            }
                            runOnUiThread { result.success(mapOf("status" to "installer_started")) }
                        } catch (error: Exception) {
                            runOnUiThread { result.error("UPDATE_FAILED", error.message ?: "Update could not be staged.", null) }
                        }
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun downloadAndVerify(rawUrl: String, expectedSha: String): File {
        val initial = URL(rawUrl)
        require(initial.protocol == "https") { "Only HTTPS update URLs are allowed." }
        require(initial.host == "github.com" || initial.host == "api.github.com") { "Update URL host is not allowed." }
        val connection = (initial.openConnection() as HttpURLConnection).apply {
            connectTimeout = 15000
            readTimeout = 60000
            instanceFollowRedirects = true
            setRequestProperty("Accept", "application/octet-stream")
            setRequestProperty("User-Agent", "BAD-GYM-UpdateCenter")
        }
        try {
            connection.connect()
            require(connection.responseCode in 200..299) { "APK download returned HTTP ${connection.responseCode}." }
            require(connection.url.protocol == "https") { "Redirected update URL is not HTTPS." }
            require(connection.url.host.endsWith("githubusercontent.com") || connection.url.host == "github.com") { "Redirected update host is not allowed." }
            val apk = File(cacheDir, "bad-gym-update.apk")
            connection.inputStream.use { input -> apk.outputStream().use { output -> input.copyTo(output) } }
            val digest = MessageDigest.getInstance("SHA-256")
            FileInputStream(apk).use { input ->
                val buffer = ByteArray(8192)
                while (true) {
                    val count = input.read(buffer)
                    if (count < 0) break
                    digest.update(buffer, 0, count)
                }
            }
            val actual = digest.digest().joinToString("") { "%02x".format(it) }
            require(actual == expectedSha) { "Downloaded APK SHA-256 does not match release manifest." }
            return apk
        } finally {
            connection.disconnect()
        }
    }

    override fun onDestroy() {
        executor.shutdown()
        super.onDestroy()
    }
}
