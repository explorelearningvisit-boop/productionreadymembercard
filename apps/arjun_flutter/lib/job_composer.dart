import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class JobDraft {
  const JobDraft({required this.title, required this.description, required this.category, required this.location, required this.rate, required this.unit, required this.people, required this.urgent, required this.photoUrls, required this.localPhotoPaths});
  final String title, description, category, location, unit;
  final int rate, people;
  final bool urgent;
  final List<String> photoUrls, localPhotoPaths;
}

class JobComposerScreen extends StatefulWidget {
  const JobComposerScreen({super.key});
  @override State<JobComposerScreen> createState() => _JobComposerScreenState();
}
class _JobComposerScreenState extends State<JobComposerScreen> {
  final form = GlobalKey<FormState>();
  final title = TextEditingController(), description = TextEditingController(), location = TextEditingController(), rate = TextEditingController(text: '700');
  final picker = ImagePicker();
  final photos = <XFile>[];
  String category = 'Electrician', unit = 'दिन';
  String? error;
  int people = 1;
  bool urgent = false, uploading = false;
  double progress = 0;
  static const categories = ['Mason','Electrician','Plumber','Carpenter','AC / Fridge Repair','Cooler / Fan Repair','Driver','Loader / Helper','Delivery','Agriculture','Other'];
  @override void dispose() { title.dispose(); description.dispose(); location.dispose(); rate.dispose(); super.dispose(); }
  Future<void> pick(ImageSource source) async {
    try {
      if (source == ImageSource.gallery) {
        final chosen = await picker.pickMultiImage(imageQuality: 72, maxWidth: 1600);
        if (mounted) setState(() { for (final p in chosen) { if (photos.length < 6) photos.add(p); } });
      } else {
        final p = await picker.pickImage(source: source, imageQuality: 72, maxWidth: 1600);
        if (p != null && mounted && photos.length < 6) setState(() => photos.add(p));
      }
    } catch (e) { if (mounted) setState(() => error = 'Photo selection failed: $e'); }
  }
  Future<List<String>> upload(String jobId) async {
    final urls = <String>[];
    for (var i = 0; i < photos.length; i++) {
      final ref = FirebaseStorage.instance.ref().child('jobs/$jobId/customer-attachments/' + DateTime.now().millisecondsSinceEpoch.toString() + '_$i.jpg');
      final task = ref.putFile(File(photos[i].path), SettableMetadata(contentType: 'image/jpeg'));
      task.snapshotEvents.listen((s) { if (mounted && s.totalBytes > 0) setState(() => progress = (i + s.bytesTransferred / s.totalBytes) / photos.length); });
      await task;
      urls.add(await ref.getDownloadURL());
    }
    return urls;
  }
  Future<void> submit() async {
    if (!form.currentState!.validate()) return;
    setState(() { uploading = true; error = null; progress = 0; });
    final id = 'draft_' + DateTime.now().millisecondsSinceEpoch.toString();
    try {
      final urls = await upload(id);
      if (!mounted) return;
      Navigator.pop(context, JobDraft(title: title.text.trim(), description: description.text.trim(), category: category, location: location.text.trim(), rate: int.parse(rate.text), unit: unit, people: people, urgent: urgent, photoUrls: urls, localPhotoPaths: urls.isEmpty ? photos.map((p) => p.path).toList() : const []));
    } catch (e) {
      if (mounted) setState(() { error = 'Upload failed. Configure Firebase app and Storage security rules first. Details: $e'; uploading = false; });
    }
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('काम की पूरी जानकारी')),
    body: Form(key: form, child: ListView(padding: const EdgeInsets.all(18), children: [
      const Text('1. काम का विवरण', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: Color(0xFF172554))),
      const SizedBox(height: 10),
      TextFormField(controller: title, decoration: const InputDecoration(labelText: 'काम का नाम'), validator: (v) => (v == null || v.trim().length < 4) ? 'कम से कम 4 अक्षर लिखें' : null),
      const SizedBox(height: 10),
      DropdownButtonFormField<String>(value: category, isExpanded: true, decoration: const InputDecoration(labelText: 'श्रेणी'), items: categories.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(), onChanged: (v) => setState(() => category = v ?? category)),
      const SizedBox(height: 10),
      TextFormField(controller: description, minLines: 3, maxLines: 5, decoration: const InputDecoration(labelText: 'काम का पूरा विवरण'), validator: (v) => (v == null || v.trim().length < 8) ? 'थोड़ा विस्तार से लिखें' : null),
      const SizedBox(height: 22),
      const Text('2. फोटो जोड़ें', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: Color(0xFF172554))),
      const Text('अधिकतम 6 फोटो • कैमरा या गैलरी', style: TextStyle(color: Colors.black54, fontSize: 12)),
      const SizedBox(height: 8),
      Row(children: [
        Expanded(child: OutlinedButton.icon(onPressed: uploading ? null : () => pick(ImageSource.camera), icon: const Icon(Icons.camera_alt_outlined), label: const Text('कैमरा'))),
        const SizedBox(width: 8),
        Expanded(child: OutlinedButton.icon(onPressed: uploading ? null : () => pick(ImageSource.gallery), icon: const Icon(Icons.photo_library_outlined), label: const Text('गैलरी'))),
      ]),
      if (photos.isNotEmpty) SizedBox(height: 104, child: ListView(scrollDirection: Axis.horizontal, children: [for (var i=0;i<photos.length;i++) Padding(padding: const EdgeInsets.only(right:8,top:8), child: Stack(children: [
        ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.file(File(photos[i].path), width:94,height:94,fit:BoxFit.cover)),
        Positioned(right:0,top:0,child: IconButton.filled(onPressed: uploading ? null : () => setState(() => photos.removeAt(i)), icon: const Icon(Icons.close,size:15))),
      ]))])),
      const SizedBox(height: 22),
      const Text('3. काम की जगह', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: Color(0xFF172554))),
      const SizedBox(height: 10),
      TextFormField(controller: location, decoration: const InputDecoration(labelText: 'पता / मोहल्ला / शहर'), validator: (v) => (v == null || v.trim().length < 3) ? 'जगह लिखें' : null),
      const SizedBox(height: 22),
      const Text('4. बजट और टीम', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: Color(0xFF172554))),
      const SizedBox(height: 10),
      Row(children: [
        Expanded(child: TextFormField(controller: rate, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'रेट (₹)'), validator: (v) => (int.tryParse(v ?? '') ?? 0) <= 0 ? 'सही रेट लिखें' : null)),
        const SizedBox(width: 8),
        Expanded(child: DropdownButtonFormField<String>(value: unit, decoration: const InputDecoration(labelText: 'इकाई'), items: ['घंटा','दिन','काम','वर्ग फुट','पीस','किमी'].map((v) => DropdownMenuItem(value:v,child:Text(v))).toList(), onChanged:(v)=>setState(()=>unit=v??unit))),
      ]),
      const SizedBox(height: 10),
      DropdownButtonFormField<int>(value: people, decoration: const InputDecoration(labelText: 'कितने workers?'), items: [1,2,3,4,5,10,20].map((v)=>DropdownMenuItem(value:v,child:Text('$v व्यक्ति'))).toList(), onChanged:(v)=>setState(()=>people=v??1)),
      SwitchListTile(contentPadding: EdgeInsets.zero, value: urgent, onChanged:(v)=>setState(()=>urgent=v), title: const Text('तत्काल काम')),
      if (uploading) LinearProgressIndicator(value: progress == 0 ? null : progress),
      if (error != null) Text(error!, style: const TextStyle(color: Colors.red, fontSize: 12)),
      FilledButton.icon(onPressed: uploading ? null : submit, icon: const Icon(Icons.send), label: Text(uploading ? 'अपलोड हो रहा है…' : 'काम सबमिट करें')),
      const Text('Cloud destination: Firebase Storage /jobs/{jobId}/customer-attachments/. Upload के बाद download URL job record में रखा जाएगा। Firebase initialization और Firestore job creation अभी अलग से configure करना बाकी है.', style: TextStyle(fontSize: 11, color: Colors.black54)),
    ])),
  );
}
