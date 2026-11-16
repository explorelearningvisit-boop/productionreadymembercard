plugins {
    id("com.android.application")
    id("dev.flutter.flutter-gradle-plugin")
}

val releaseStorePath = System.getenv("BADGYM_RELEASE_STORE_FILE")

android {
    namespace = "com.badgym.bad_gym"
    compileSdk = flutter.compileSdkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // Deliberately separate from production so both APKs can coexist.
        applicationId = "com.badgym.designlab"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        getByName("debug") {
            storeFile = file("debug.keystore")
            storePassword = "android"
            keyAlias = "androiddebugkey"
            keyPassword = "android"
        }
        if (!releaseStorePath.isNullOrBlank()) {
            create("protectedRelease") {
                storeFile = file(releaseStorePath)
                storePassword = System.getenv("BADGYM_RELEASE_STORE_PASSWORD") ?: ""
                keyAlias = System.getenv("BADGYM_RELEASE_KEY_ALIAS") ?: ""
                keyPassword = System.getenv("BADGYM_RELEASE_KEY_PASSWORD") ?: ""
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (!releaseStorePath.isNullOrBlank()) signingConfigs.getByName("protectedRelease") else signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
