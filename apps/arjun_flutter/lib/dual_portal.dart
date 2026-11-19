import 'package:flutter/material.dart';
import 'design_system/app_tokens.dart';
import 'customer_home_content.dart';

enum AppRole { worker, owner, contractor, manager, company }
extension RoleInfo on AppRole {
  bool get isWorker => this == AppRole.worker;
  String get label => switch (this) {
    AppRole.worker => 'काम करने वाला', AppRole.owner => 'ग्राहक / बिज़नेस',
    AppRole.contractor => 'ठेकेदार', AppRole.manager => 'साइट मैनेजर',
    AppRole.company => 'कंपनी / बिल्डर',
  };
  Color get accent => isWorker ? AppTokens.worker : AppTokens.provider;
  Color get tint => isWorker ? AppTokens.workerSoft : AppTokens.providerSoft;
  IconData get icon => switch (this) {
    AppRole.worker => Icons.engineering_outlined, AppRole.owner => Icons.home_work_outlined,
    AppRole.contractor => Icons.handyman_outlined, AppRole.manager => Icons.assignment_outlined,
    AppRole.company => Icons.apartment_outlined,
  };
}
class RoleEntry extends StatefulWidget {
  const RoleEntry({super.key});
  @override State<RoleEntry> createState() => _RoleEntryState();
}
class _RoleEntryState extends State<RoleEntry> {
  AppRole? role;
  @override Widget build(BuildContext c) => role == null
    ? RolePicker(onPick: (r) => setState(() => role = r))
    : MarketplaceHome(role: role!, onSwitch: () => setState(() => role = null));
}
class RolePicker extends StatelessWidget {
  const RolePicker({super.key, required this.onPick});
  final ValueChanged<AppRole> onPick;
  @override Widget build(BuildContext c) => Scaffold(body: SafeArea(child: ListView(padding: const EdgeInsets.all(20), children: [
    Container(height: 175, padding: const EdgeInsets.all(22), decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [AppTokens.workerDeep, AppTokens.worker, Color(0xFF71C9A5)]),
      borderRadius: BorderRadius.circular(26)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(Icons.hub_outlined, color: Colors.white, size: 34), Spacer(),
      Text('KaamVerse', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
      Text('काम • हुनर • भरोसा', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800)),
      Text('हर काम के लिए सही व्यक्ति', style: TextStyle(color: Colors.white70)),
    ])),
    const SizedBox(height: 22), const Text('आप क्या करना चाहते हैं?', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
    const Text('अपनी भूमिका चुनें। बाद में बदल सकते हैं।'), const SizedBox(height: 14),
    ...AppRole.values.map((r) => Card(child: ListTile(
      leading: CircleAvatar(backgroundColor: r.tint, child: Icon(r.icon, color: r.accent)),
      title: Text(r.label, style: TextStyle(fontWeight: FontWeight.w900, color: r.accent)),
      subtitle: Text(r.isWorker ? 'काम खोजें • हाजिरी • कमाई' : 'काम पोस्ट करें • टीम • प्रोजेक्ट'),
      trailing: const Icon(Icons.chevron_right), onTap: () => onPick(r)))),
    const Text('Hindi-first • सरल navigation • UX preview', textAlign: TextAlign.center),
  ])));
}
class _Task {
  _Task(this.name, this.target, this.unit, this.rate, {this.done = 0, this.accepted = 0, this.delay = 'कोई देरी नहीं'});
  final String name, unit;
  String delay;
  final int target, rate;
  int done, accepted;
  int get payable => accepted * rate;
}
class MarketplaceHome extends StatefulWidget {
  const MarketplaceHome({super.key, required this.role, required this.onSwitch});
  final AppRole role; final VoidCallback onSwitch;
  @override State<MarketplaceHome> createState() => _MarketplaceHomeState();
}
class _MarketplaceHomeState extends State<MarketplaceHome> {
  int tab = 0; String category = 'सभी';
  late final tasks = <_Task>[
    _Task('Pillar casting', 16, 'खंभे', 1250, done: 7, accepted: 4, delay: 'बारिश के कारण 1.5 घंटे रुका'),
    _Task('ईंट-चिनाई', 120, 'वर्ग फुट', 35, done: 68, accepted: 60),
    _Task('साइट सफाई', 1, 'काम', 1800, done: 1),
  ];
  final jobNames = ['घर की पेंटिंग','ईंट-चिनाई','बाथरूम पाइप रिपेयर','इलेक्ट्रिकल हेल्पर','ऑफिस और घर की सफाई','फर्नीचर रिपेयर','लोडिंग और अनलोडिंग','सामान्य हेल्पर'];
  final jobTypes = ['पेंटिंग','निर्माण','प्लंबर','इलेक्ट्रिकल','सफाई','बढ़ई','लोडिंग','अन्य काम'];
  final jobPlaces = ['लंका, वाराणसी','शिवपुर, वाराणसी','सिगरा, वाराणसी','वाराणसी','महात्मा गांधी काशी विद्यापीठ, वाराणसी','दुर्गाकुंड, वाराणसी','रामनगर, वाराणसी','पांडेयपुर, वाराणसी'];
  final jobRates = ['₹700 / दिन','₹900 / दिन','₹600 / काम','₹800 / दिन','₹500 / दिन','₹750 / दिन','₹450 / दिन','₹550 / दिन'];
  bool get worker => widget.role.isWorker;
  List<String> get labels => worker ? ['होम','काम','हाजिरी','कमाई','प्रोफाइल'] : ['डैशबोर्ड','काम','टास्क','सामग्री','प्रोफाइल'];
  List<IconData> get icons => worker
    ? [Icons.home,Icons.search,Icons.fact_check,Icons.wallet,Icons.person]
    : [Icons.dashboard,Icons.work,Icons.checklist,Icons.inventory,Icons.person];
  @override Widget build(BuildContext c) {
    final pages = worker ? [workerHome(),jobsPage(),attendance(),earnings(),profile()]
      : [ownerHome(),jobsPage(),taskBoard(),materials(),profile()];
    return Scaffold(appBar: AppBar(title: const Text('KaamVerse', style: TextStyle(fontWeight: FontWeight.w900)),
      actions: [IconButton(onPressed: widget.onSwitch, icon: const Icon(Icons.swap_horiz), tooltip: 'भूमिका बदलें')]),
      body: Column(children: [
        Container(width: double.infinity, color: const Color(0xFFFFF2D6), padding: const EdgeInsets.all(7),
          child: const Text('PREVIEW MODE • सभी नाम, काम और रकम sample data हैं', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF805500)))),
        Expanded(child: IndexedStack(index: tab, children: pages)),
      ]),
      bottomNavigationBar: NavigationBar(selectedIndex: tab, onDestinationSelected: (v) => setState(() => tab = v),
        destinations: List.generate(5, (i) => NavigationDestination(icon: Icon(icons[i]), label: labels[i]))),
      floatingActionButton: !worker && tab == 1 ? FloatingActionButton.extended(onPressed: createJob,
        backgroundColor: AppTokens.provider, foregroundColor: Colors.white, icon: const Icon(Icons.add),
        label: const Text('काम पोस्ट करें')) : null);
  }
  Widget heading(String title, String subtitle) => Padding(padding: const EdgeInsets.only(bottom: 14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppTokens.ink)),
      Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTokens.muted)),
    ]));
  Widget hero(String title, String subtitle, IconData icon, VoidCallback action, String button) => Container(
    padding: const EdgeInsets.all(18), decoration: BoxDecoration(
      gradient: LinearGradient(colors: [widget.role.accent, Color.lerp(widget.role.accent, Colors.white, .25)!]),
      borderRadius: BorderRadius.circular(22)), child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
        Text(subtitle, style: const TextStyle(color: Colors.white)), const SizedBox(height: 10),
        FilledButton(onPressed: action, style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: widget.role.accent), child: Text(button)),
      ])), Icon(icon, color: Colors.white, size: 58),
    ]));
  Widget workerHome() => ListView(padding: const EdgeInsets.all(16), children: [
    heading('नमस्ते 👋', 'आज आपके हुनर के लिए सही काम खोजें'),
    hero('पास के काम देखें', 'रेट, जगह और काम का scope पहले जानें', Icons.engineering, () => setState(() => tab = 1), 'काम खोजें'),
    const SizedBox(height: 16), const Text('Quick actions', style: TextStyle(fontWeight: FontWeight.w900)),
    GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 3, children: [
      quick('हाजिरी', Icons.fact_check, () => setState(() => tab = 2)),
      quick('कमाई', Icons.wallet, () => setState(() => tab = 3)),
      quick('मदद / SOS', Icons.sos, () => info('मदद', 'यह UX preview है।')),
    ]),
    const Text('आपके आसपास के काम', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
    ...List.generate(3, jobCard), safety(),
  ]);
  Widget quick(String title, IconData icon, VoidCallback fn) => Card(child: InkWell(onTap: fn,
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: widget.role.accent, size: 27), Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11)),
    ])));
  Widget jobsPage() => ListView(padding: const EdgeInsets.all(16), children: [
    heading(worker ? 'काम खोजें' : 'काम मैनेज करें', 'काम, हुनर या जगह के अनुसार'),
    TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'जैसे पेंटर, हेल्पर, वाराणसी')),
    const SizedBox(height: 9),
    Wrap(spacing: 5, children: ['सभी','निर्माण','सफाई','प्लंबर','इलेक्ट्रिकल','बढ़ई','पेंटिंग','लोडिंग','अन्य काम'].map((v) => ChoiceChip(
      label: Text(v), selected: category == v, onSelected: (_) => setState(() => category = v))).toList()),
    ...List.generate(jobNames.length, jobCard),
    if (!worker) OutlinedButton.icon(onPressed: createJob, icon: const Icon(Icons.add), label: const Text('नया काम पोस्ट करें')),
  ]);
  Widget jobCard(int i) {
    final idx = i % jobNames.length;
    if (category != 'सभी' && category != jobTypes[idx]) return const SizedBox.shrink();
    return Card(child: ListTile(onTap: () => info(jobNames[idx], 'काम का प्रकार: ' + jobTypes[idx] + '\nस्थान: ' + jobPlaces[idx] + '\nरेट: ' + jobRates[idx] + '\nयह sample job है।'),
      leading: CircleAvatar(backgroundColor: widget.role.tint, child: Icon(Icons.handyman, color: widget.role.accent)),
      title: Text(jobNames[idx], style: const TextStyle(fontWeight: FontWeight.w900)),
      subtitle: Text(jobTypes[idx] + ' • ' + jobPlaces[idx] + '\nScope और acceptance criteria job detail में'),
      trailing: Text(jobRates[idx], style: TextStyle(color: widget.role.accent, fontWeight: FontWeight.w900))));
  }
  Widget attendance() => ListView(padding: const EdgeInsets.all(16), children: [
    heading('हाजिरी और काम', 'Attendance और verified output अलग-अलग हैं।'),
    Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(children: [
      CircleAvatar(radius: 45, backgroundColor: widget.role.tint, child: Icon(Icons.qr_code_scanner, color: widget.role.accent, size: 45)),
      const Text('साइट पर चेक-इन', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      const Text('QR / GPS / supervisor confirmation preview'),
      FilledButton(onPressed: () => info('Preview only', 'कोई असली GPS या attendance record नहीं बनेगा।'), child: const Text('चेक-इन preview')),
    ]))),
    const Text('इस सप्ताह', style: TextStyle(fontWeight: FontWeight.w900)),
    ...['सोमवार • उपस्थित','मंगलवार • उपस्थित','बुधवार • अनुपस्थित','गुरुवार • समीक्षा बाकी','शुक्रवार • उपस्थित'].map((v) => ListTile(
      leading: Icon(v.contains('अनुपस्थित') ? Icons.cancel : Icons.check_circle_outline,
        color: v.contains('अनुपस्थित') ? AppTokens.danger : AppTokens.success), title: Text(v))),
  ]);
  Widget earnings() => ListView(padding: const EdgeInsets.all(16), children: [
    heading('मेरी कमाई', 'केवल accepted काम payable होगा।'),
    Card(color: widget.role.accent, child: const Padding(padding: EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Sample ledger • वास्तविक balance नहीं', style: TextStyle(color: Colors.white70)),
      Text('₹ 5,000', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
      Text('4 accepted खंभे × ₹1,250', style: TextStyle(color: Colors.white)),
    ]))),
    const Text('Task-wise भुगतान', style: TextStyle(fontWeight: FontWeight.w900)),
    ...tasks.map((t) => ListTile(title: Text(t.name), subtitle: Text(t.accepted.toString() + ' ' + t.unit + ' accepted'),
      trailing: Text('₹' + t.payable.toString(), style: const TextStyle(fontWeight: FontWeight.w900)))),
    OutlinedButton(onPressed: () => info('Payout', 'UPI / bank payout बाद में backend से जुड़ेगा।'), child: const Text('Payout flow preview')),
  ]);
  Widget ownerHome() => CustomerHomeContent(
    onBrowse: () => setState(() => tab = 1),
    onCategorySelected: (value) => setState(() {
      category = value;
      tab = 1;
    }),
    onCreateBooking: createJob,
    onWorkerSelected: (name) => info(name,
      'Worker profile preview • KYC, availability और booking confirmation वास्तविक backend से जुड़ने के बाद verify होंगे।'),
  );
  Widget stat(String title, String value, IconData icon) => Card(child: ListTile(
    leading: Icon(icon, color: widget.role.accent), title: Text(value, style: TextStyle(color: widget.role.accent, fontWeight: FontWeight.w900)),
    subtitle: Text(title)));
  Widget taskBoard() => ListView(padding: const EdgeInsets.all(16), children: [
    heading('Task & Site Progress', 'Target → completed → accepted → payable'),
    ...tasks.map(taskCard),
    Card(child: ListTile(leading: const Icon(Icons.add_task), title: const Text('Measurable task बनाएँ'),
      subtitle: const Text('Quantity, unit, rate और target तय करें'), onTap: createTask)),
    const Text('Delay register', style: TextStyle(fontWeight: FontWeight.w900)),
    ...tasks.where((t) => t.delay != 'कोई देरी नहीं').map((t) => ListTile(
      leading: const Icon(Icons.cloud, color: AppTokens.warning), title: Text(t.delay), subtitle: Text(t.name))),
  ]);
  Widget taskCard(_Task t) => Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(t.name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('Target ' + t.target.toString() + ' ' + t.unit), Text('Done ' + t.done.toString())]),
    const SizedBox(height: 7), ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(
      value: (t.done / t.target).clamp(0, 1), minHeight: 9, color: widget.role.accent, backgroundColor: widget.role.tint)),
    Text('Accepted ' + t.accepted.toString() + ' • Payable ₹' + t.payable.toString(), style: const TextStyle(fontSize: 11)),
    TextButton(onPressed: () => review(t), child: const Text('Review / delay / quality')),
    if (t.delay != 'कोई देरी नहीं') Text(t.delay, style: const TextStyle(color: Color(0xFF956000), fontSize: 11)),
  ])));
  Widget materials() => ListView(padding: const EdgeInsets.all(16), children: [
    heading('सामग्री और सप्लायर', 'सभी भाव UX sample हैं, live market rate नहीं।'),
    ...[['सीमेंट','OPC / PPC प्रति बोरी','₹360–420'],['सरिया','TMT प्रति किलो','₹56–68'],
      ['पेंट','Interior प्रति लीटर','₹180–340'],['पाइप','PVC / CPVC','Quote चाहिए'],
      ['वायरिंग','Copper wire coil','Quote चाहिए'],['सेफ्टी','Helmet / gloves','₹120 से']].map((x) => Card(child: ListTile(
        leading: Icon(Icons.inventory_2, color: widget.role.accent), title: Text(x[0]),
        subtitle: Text(x[1]), trailing: Text(x[2]),
        onTap: () => info(x[0], 'Live supplier stock और quote अभी connected नहीं हैं।')))),
  ]);
  Widget profile() => ListView(padding: const EdgeInsets.all(16), children: [
    heading('प्रोफाइल और सहायता', 'भाषा, पहचान, सुरक्षा और support'),
    Card(child: ListTile(leading: CircleAvatar(child: Icon(widget.role.icon)), title: Text(widget.role.label),
      subtitle: const Text('Preview account • KYC नहीं हुआ'))),
    ...[['भाषा','हिन्दी • English • भोजपुरी • अवधी'],['KYC','पहचान सत्यापन'],['रेटिंग','समीक्षा और भरोसा'],
      ['सुरक्षा / SOS','आपातकालीन सहायता'],['Privacy','Location consent'],['विवाद / Support','शिकायत और समाधान']].map((x) => Card(
        child: ListTile(title: Text(x[0]), subtitle: Text(x[1]), trailing: const Icon(Icons.chevron_right),
          onTap: () => info(x[0], 'यह UX preview है; backend action अभी नहीं है।')))),
    OutlinedButton(onPressed: widget.onSwitch, child: const Text('भूमिका बदलें')),
  ]);
  Widget safety() => Container(margin: const EdgeInsets.only(top: 14), padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: widget.role.tint, borderRadius: BorderRadius.circular(14)),
    child: const Text('सुरक्षा और quality जरूरी हैं। केवल तेजी से काम करना completion नहीं है।', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)));
  void info(String title, String body) => showDialog<void>(context: context, builder: (c) => AlertDialog(
    title: Text(title), content: Text(body), actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('ठीक है'))]));
  Future<void> createJob() async {
    final result = await Navigator.push<String>(context, MaterialPageRoute(builder: (_) => const SimpleForm(title: 'नया काम पोस्ट करें')));
    if (result != null && mounted) setState(() { jobNames.insert(0, result); jobTypes.insert(0, 'अन्य'); jobPlaces.insert(0, 'वाराणसी'); jobRates.insert(0, 'रेट तय करें'); });
  }
  Future<void> createTask() async {
    final result = await Navigator.push<List<String>>(context, MaterialPageRoute(builder: (_) => const TaskForm()));
    if (result != null && mounted) setState(() => tasks.add(_Task(result[0], int.parse(result[1]), result[2], int.parse(result[3]))));
  }
  void review(_Task t) => showModalBottomSheet<void>(context: context, builder: (c) => Padding(padding: const EdgeInsets.all(20), child: Wrap(runSpacing: 12, children: [
    Text(t.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
    Text('Target ' + t.target.toString() + ' • Completed ' + t.done.toString() + ' • Accepted ' + t.accepted.toString()),
    const Text('Evidence और site inspection के बाद ही accepted quantity बदलें।'),
    FilledButton(onPressed: () => setState(() => t.accepted = t.done.clamp(0, t.target)), child: const Text('Demo: completed quantity accept करें')),
    OutlinedButton(onPressed: () => setState(() => t.delay = 'मौसम / बारिश के कारण काम रुका'), child: const Text('Weather delay दर्ज करें')),
    OutlinedButton(onPressed: () => setState(() => t.delay = 'Material shortage — site hold'), child: const Text('Material delay दर्ज करें')),
    const Text('Preview only • वास्तविक engineer approval या payment नहीं।', style: TextStyle(fontSize: 10)),
  ])));
}
class SimpleForm extends StatefulWidget {
 const SimpleForm({super.key,required this.title});final String title;
 @override State<SimpleForm> createState()=>_SimpleFormState();
}
class _SimpleFormState extends State<SimpleForm>{
 final name=TextEditingController(),scope=TextEditingController();@override void dispose(){name.dispose();scope.dispose();super.dispose();}
 @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:Text(widget.title)),body:ListView(padding:const EdgeInsets.all(18),children:[
  TextField(controller:name,decoration:const InputDecoration(labelText:'काम का नाम')),
  const SizedBox(height:10),TextField(controller:scope,maxLines:3,decoration:const InputDecoration(labelText:'काम का पूरा scope / विवरण')),
  const SizedBox(height:18),FilledButton(onPressed:()=>name.text.trim().isEmpty||scope.text.trim().isEmpty?
   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('दोनों जानकारी भरें।'))):Navigator.pop(context,name.text.trim()),
   child:const Text('Preview में जोड़ें')),
  const Text('Local preview only; server पर publish नहीं होगा।',style:TextStyle(fontSize:10))]));
}
class TaskForm extends StatefulWidget {
 const TaskForm({super.key});@override State<TaskForm> createState()=>_TaskFormState();
}
class _TaskFormState extends State<TaskForm>{
 final name=TextEditingController(),qty=TextEditingController(text:'10'),rate=TextEditingController(text:'500');
 String unit='पीस';@override void dispose(){name.dispose();qty.dispose();rate.dispose();super.dispose();}
 @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Measurable task बनाएँ')),body:ListView(padding:const EdgeInsets.all(18),children:[
  TextField(controller:name,decoration:const InputDecoration(labelText:'Task का नाम')),
  const SizedBox(height:10),TextField(controller:qty,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Target quantity')),
  const SizedBox(height:10),DropdownButtonFormField<String>(value:unit,decoration:const InputDecoration(labelText:'Unit'),
   items:['पीस','खंभे','वर्ग फुट','मीटर','घंटे','काम'].map((v)=>DropdownMenuItem(value:v,child:Text(v))).toList(),onChanged:(v)=>setState(()=>unit=v??unit)),
  const SizedBox(height:10),TextField(controller:rate,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Rate per unit ₹')),
  const SizedBox(height:18),FilledButton(onPressed:submit,child:const Text('Task जोड़ें')),
  const Text('Preview only. Evidence और safety approval वास्तविक रूप से connected नहीं।',style:TextStyle(fontSize:10))]));
 void submit(){final q=int.tryParse(qty.text),r=int.tryParse(rate.text);
  if(name.text.trim().isEmpty||q==null||q<=0||r==null||r<=0){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('सही task, quantity और rate भरें।')));return;}
  Navigator.pop(context,[name.text.trim(),q.toString(),unit,r.toString()]);}
}
