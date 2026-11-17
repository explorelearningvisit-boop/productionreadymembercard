import 'operations.dart';
import 'job_composer.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ArjunApp());

const ink = Color(0xFF172554);
const saffron = Color(0xFFF59E0B);
const teal = Color(0xFF0F766E);
const canvas = Color(0xFFF5F7FB);

class ArjunApp extends StatelessWidget {
  const ArjunApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'ARJUN',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: canvas,
      colorScheme: ColorScheme.fromSeed(seedColor: ink, primary: ink, secondary: saffron, surface: Colors.white),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(backgroundColor: canvas, foregroundColor: ink, elevation: 0, centerTitle: false),
      cardTheme: CardThemeData(color: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: const Color(0xFFF3F5F9),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      ),
    ),
    home: const AppShell(),
  );
}

enum UserRole { customer, worker, manager, supplier }
extension RoleLabel on UserRole {
  String get label => switch (this) {
    UserRole.customer => 'Customer', UserRole.worker => 'Worker',
    UserRole.manager => 'Field manager', UserRole.supplier => 'Supplier'
  };
  String get hindi => switch (this) {
    UserRole.customer => 'काम देने वाले', UserRole.worker => 'काम करने वाले',
    UserRole.manager => 'साइट मैनेजर', UserRole.supplier => 'सप्लायर'
  };
  IconData get icon => switch (this) {
    UserRole.customer => Icons.home_work_outlined, UserRole.worker => Icons.build_outlined,
    UserRole.manager => Icons.assignment_ind_outlined, UserRole.supplier => Icons.inventory_2_outlined
  };
}

class Job {
  Job(this.title, this.category, this.location, this.rate, this.unit, this.people, this.urgent);
  final String title, category, location, unit;
  final int rate, people;
  final bool urgent;
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override State<AppShell> createState() => _AppShellState();
}
class _AppShellState extends State<AppShell> {
  UserRole role = UserRole.customer;
  int tab = 0;
  bool english = false;
  final List<Job> jobs = [
    Job('घर की वायरिंग', 'Electrician', 'लंका, वाराणसी', 850, 'दिन', 1, true),
    Job('बाथरूम पाइप रिपेयर', 'Plumber', 'सिगरा, वाराणसी', 600, 'काम', 1, false),
    Job('ईंट-चिनाई के लिए मिस्त्री', 'Mason', 'शिवपुर, वाराणसी', 900, 'दिन', 2, false),
  ];
  String get greeting => english ? 'Namaste' : 'नमस्ते';
  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      DashboardPage(role: role, jobs: jobs, english: english, onPost: _postJob, onBrowse: () => setState(() => tab = 1)),
      ExplorePage(jobs: jobs, role: role, onAccept: (job) => _notice('काम के लिए आपकी रुचि दर्ज हुई: ${job.title}')),
      ActivityPage(role: role, jobs: jobs),
      ProfilePage(role: role, english: english, onLanguage: () => setState(() => english = !english), onRole: _chooseRole),
    ];
    return Scaffold(
      body: SafeArea(child: IndexedStack(index: tab, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab, onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'होम'),
          NavigationDestination(icon: Icon(Icons.search_rounded), label: 'खोजें'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'गतिविधि'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'प्रोफाइल'),
        ],
      ),
      floatingActionButton: role == UserRole.customer && tab == 0
        ? FloatingActionButton.extended(onPressed: _postJob, backgroundColor: saffron, foregroundColor: ink, icon: const Icon(Icons.add), label: const Text('काम पोस्ट करें'))
        : null,
    );
  }
  void _notice(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  void _chooseRole() => showModalBottomSheet(context: context, showDragHandle: true, builder: (ctx) => SafeArea(child: Padding(
    padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Align(alignment: Alignment.centerLeft, child: Text('अपना मोड चुनें', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      const SizedBox(height: 12),
      ...UserRole.values.map((r) => ListTile(leading: Icon(r.icon, color: ink), title: Text(r.hindi), subtitle: Text(r.label), trailing: role == r ? const Icon(Icons.check_circle, color: teal) : null,
        onTap: () { setState(() { role = r; tab = 0; }); Navigator.pop(ctx); })),
    ]),
  )));
  Future<void> _postJob() async {
    final draft = await Navigator.push<JobDraft>(context, MaterialPageRoute(builder: (_) => const JobComposerScreen()));
    if (draft == null || !mounted) return;
    setState(() {
      jobs.insert(0, Job(draft.title, draft.category, draft.location, draft.rate, draft.unit, draft.people, draft.urgent));
      tab = 0;
    });
    _notice(draft.photoUrls.isEmpty
      ? 'काम का draft इस session में जोड़ा गया। Server पर job save अभी configure होना बाकी है।'
      : 'फोटो Cloud Storage पर upload हुईं; job record save integration अभी बाकी है।');
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.role, required this.jobs, required this.english, required this.onPost, required this.onBrowse});
  final UserRole role; final List<Job> jobs; final bool english; final VoidCallback onPost, onBrowse;
  @override Widget build(BuildContext context) => CustomScrollView(slivers: [
    SliverPadding(padding: const EdgeInsets.fromLTRB(20, 14, 20, 12), sliver: SliverToBoxAdapter(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 44, height: 44, decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(14)), child: const Center(child: Text('अ', style: TextStyle(color: saffron, fontSize: 27, fontWeight: FontWeight.w900)))),
        const SizedBox(width: 10), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('ARJUN', style: TextStyle(color: ink, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.4)), Text('Rooted in Kashi. Built for the World.', style: TextStyle(fontSize: 10, color: Colors.black54))])),
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)),
      ]),
      const SizedBox(height: 22),
      Text(english ? 'Namaste 👋' : 'नमस्ते 👋', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: ink)),
      Text(role.hindi, style: const TextStyle(color: Colors.black54)),
      const SizedBox(height: 18),
      _HeroCard(role: role, onPost: onPost, onBrowse: onBrowse),
      const SizedBox(height: 20),
      const Text('आपको क्या चाहिए?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: ink)),
      const SizedBox(height: 12),
      const CategoryGrid(),
      const SizedBox(height: 22),
      Row(children: [const Expanded(child: Text('आपके आसपास के काम', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: ink))), TextButton(onPressed: onBrowse, child: const Text('सभी देखें'))]),
    ]))),
    SliverPadding(padding: const EdgeInsets.symmetric(horizontal: 20), sliver: SliverList(delegate: SliverChildBuilderDelegate((ctx, i) => JobCard(job: jobs[i]), childCount: jobs.length))),
    const SliverToBoxAdapter(child: SizedBox(height: 90)),
  ]);
}
class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.role, required this.onPost, required this.onBrowse});
  final UserRole role; final VoidCallback onPost, onBrowse;
  @override Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20), decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [ink, Color(0xFF27447D)], begin: Alignment.topLeft, end: Alignment.bottomRight),
      borderRadius: BorderRadius.circular(24)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('हर मेहनतकश में है एक अर्जुन', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
      const SizedBox(height: 6), const Text('सही काम • सही हुनर • सही मेहनताना', style: TextStyle(color: Color(0xFFDCE6FA), fontSize: 13)),
      const SizedBox(height: 18),
      Row(children: [
        Expanded(child: FilledButton.icon(style: FilledButton.styleFrom(backgroundColor: saffron, foregroundColor: ink), onPressed: role == UserRole.customer ? onPost : onBrowse, icon: Icon(role == UserRole.customer ? Icons.add : Icons.search), label: Text(role == UserRole.customer ? 'काम पोस्ट करें' : 'काम खोजें'))),
        const SizedBox(width: 8),
        IconButton.filledTonal(onPressed: onBrowse, icon: const Icon(Icons.arrow_forward_rounded)),
      ]),
    ]),
  );
}
class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});
  static const entries = [
    ('मिस्त्री', Icons.construction, Color(0xFFFFF1D6)), ('इलेक्ट्रिशियन', Icons.electrical_services, Color(0xFFE7F0FF)),
    ('प्लंबर', Icons.plumbing, Color(0xFFDFF7F1)), ('AC रिपेयर', Icons.ac_unit, Color(0xFFEDE9FE)),
    ('बढ़ई', Icons.chair_outlined, Color(0xFFFFE9E1)), ('ड्राइवर', Icons.local_shipping_outlined, Color(0xFFE8F3FF)),
    ('हेल्पर', Icons.construction, Color(0xFFF0F2F6)), ('सभी सेवाएँ', Icons.apps_rounded, Color(0xFFFFF0E2)),
  ];
  @override Widget build(BuildContext context) => GridView.builder(
    shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: entries.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 8, childAspectRatio: .86),
    itemBuilder: (ctx, i) { final e = entries[i]; return Column(children: [
      Container(height: 54, width: 58, decoration: BoxDecoration(color: e.$3, borderRadius: BorderRadius.circular(18)), child: Icon(e.$2, color: ink, size: 25)),
      const SizedBox(height: 6), Text(e.$1, textAlign: TextAlign.center, maxLines: 2, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    ]); },
  );
}
class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.job});
  final Job job;
  @override Widget build(BuildContext context) => Card(margin: const EdgeInsets.only(bottom: 10), child: Padding(padding: const EdgeInsets.all(15), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [Expanded(child: Text(job.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: ink))), if (job.urgent) const Chip(label: Text('तत्काल', style: TextStyle(fontSize: 10)), visualDensity: VisualDensity.compact, backgroundColor: Color(0xFFFFE9D6), side: BorderSide.none)]),
    Text('${job.category}  •  ${job.location}', style: const TextStyle(color: Colors.black54, fontSize: 12)),
    const SizedBox(height: 12),
    Row(children: [const Icon(Icons.currency_rupee, size: 16, color: teal), Text('${job.rate} / ${job.unit}', style: const TextStyle(fontWeight: FontWeight.w800, color: teal)), const Spacer(), Icon(Icons.people_outline, size: 16, color: Colors.grey.shade600), Text(' ${job.people} व्यक्ति', style: const TextStyle(fontSize: 12, color: Colors.black54))]),
  ])));
}
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key, required this.jobs, required this.role, required this.onAccept});
  final List<Job> jobs; final UserRole role; final ValueChanged<Job> onAccept;
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.fromLTRB(20, 20, 20, 90), children: [
    const Text('काम और सेवाएँ खोजें', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: ink)),
    const SizedBox(height: 12), const TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'काम, हुनर या जगह खोजें')),
    const SizedBox(height: 16), ...jobs.map((j) => Column(children: [JobCard(job: j), Align(alignment: Alignment.centerRight, child: TextButton.icon(onPressed: () => onAccept(j), icon: const Icon(Icons.check_circle_outline), label: Text(role == UserRole.worker ? 'काम स्वीकार करें' : 'रुचि देखें'))), const SizedBox(height: 8)])),
  ]);
}
class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key, required this.role, required this.jobs});
  final UserRole role; final List<Job> jobs;
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    const Text('आपकी गतिविधि', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: ink)),
    const SizedBox(height: 14),
    Card(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.dashboard_customize)), title: const Text('सभी Operations मॉड्यूल'), subtitle: const Text('Job lifecycle, attendance, inspection, suppliers, payments'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const OperationsHub())))),
    const SizedBox(height: 14),
    _MetricRow(label: 'कुल उपलब्ध काम', value: '${jobs.length}', icon: Icons.work_outline, color: teal),
    _MetricRow(label: 'प्रक्रिया में', value: '0', icon: Icons.timelapse, color: saffron),
    _MetricRow(label: 'पूरा हुआ', value: '0', icon: Icons.task_alt, color: Colors.green),
    const SizedBox(height: 16),
    const Text('हाल की जानकारी', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: ink)),
    const ListTile(leading: CircleAvatar(child: Icon(Icons.info_outline)), title: Text('आपका ARJUN अकाउंट तैयार है'), subtitle: Text('काम पोस्ट करें या उपलब्ध काम देखें')),
    const Text('यह अभी डेमो डेटा है। वास्तविक बुकिंग और भुगतान backend जुड़ने के बाद सक्रिय होंगे.', style: TextStyle(color: Colors.black54, fontSize: 12)),
  ]);
}
class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value, required this.icon, required this.color});
  final String label, value; final IconData icon; final Color color;
  @override Widget build(BuildContext context) => Card(child: ListTile(leading: CircleAvatar(backgroundColor: color.withValues(alpha: .12), child: Icon(icon, color: color)), title: Text(label), trailing: Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: ink))));
}
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.role, required this.english, required this.onLanguage, required this.onRole});
  final UserRole role; final bool english; final VoidCallback onLanguage, onRole;
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    const Text('प्रोफाइल और सेटिंग्स', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: ink)),
    const SizedBox(height: 18),
    Card(child: ListTile(leading: const CircleAvatar(backgroundColor: ink, child: Icon(Icons.person, color: Colors.white)), title: const Text('नया ARJUN यूज़र'), subtitle: Text(role.hindi), trailing: const Icon(Icons.chevron_right))),
    const SizedBox(height: 10),
    Card(child: Column(children: [
      ListTile(leading: const Icon(Icons.switch_account_outlined), title: const Text('भूमिका बदलें'), subtitle: Text(role.label), trailing: const Icon(Icons.chevron_right), onTap: onRole),
      const Divider(height: 1),
      ListTile(leading: const Icon(Icons.translate), title: const Text('भाषा / Language'), subtitle: Text(english ? 'English' : 'हिन्दी'), trailing: Switch(value: english, onChanged: (_) => onLanguage())),
      const Divider(height: 1),
      const ListTile(leading: Icon(Icons.verified_user_outlined), title: Text('पहचान सत्यापन (KYC)'), subtitle: Text('जल्द उपलब्ध होगा')),
      const Divider(height: 1),
      const ListTile(leading: Icon(Icons.support_agent), title: Text('मदद और सहायता')),
    ])),
    const SizedBox(height: 14),
    const Text('ARJUN • Rooted in Kashi. Built for the World.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black45, fontSize: 11)),
  ]);
}
