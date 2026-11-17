import 'package:flutter/material.dart';

const _navy = Color(0xFF172554);
const _mint = Color(0xFF0F766E);

class OperationsHub extends StatelessWidget {
  const OperationsHub({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('ARJUN Operations')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      const Text('काम का पूरा प्रबंधन', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: _navy)),
      const SizedBox(height: 5), const Text('नीचे दिए गए मॉड्यूल अभी UI workflows हैं; backend actions जुड़ने बाकी हैं.', style: TextStyle(color: Colors.black54)),
      const SizedBox(height: 16),
      _ModuleTile(icon: Icons.assignment_outlined, title: 'Job lifecycle', subtitle: 'काम की जानकारी, worker match और milestones', page: const JobLifecycleScreen()),
      _ModuleTile(icon: Icons.qr_code_scanner, title: 'Attendance & check-in', subtitle: 'OTP/QR verification और समय दर्ज करना', page: const AttendanceScreen()),
      _ModuleTile(icon: Icons.fact_check_outlined, title: 'Manager inspection', subtitle: 'साइट रिपोर्ट, फोटो evidence और QA checklist', page: const InspectionScreen()),
      _ModuleTile(icon: Icons.inventory_2_outlined, title: 'Supplier inventory', subtitle: 'पार्ट्स, उपलब्धता और delivery tracking', page: const SupplierScreen()),
      _ModuleTile(icon: Icons.account_balance_wallet_outlined, title: 'Payments & ledger', subtitle: 'Customer charge, milestones और worker payout view', page: const PaymentsScreen()),
      _ModuleTile(icon: Icons.notifications_active_outlined, title: 'Notifications', subtitle: 'काम, verification और payout alerts', page: const NotificationsScreen()),
      _ModuleTile(icon: Icons.support_agent, title: 'Help & dispute support', subtitle: 'समस्या दर्ज करना और human review', page: const SupportScreen()),
    ]),
  );
}
class _ModuleTile extends StatelessWidget {
  const _ModuleTile({required this.icon, required this.title, required this.subtitle, required this.page});
  final IconData icon; final String title, subtitle; final Widget page;
  @override Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      leading: CircleAvatar(backgroundColor: const Color(0xFFE9EEF9), child: Icon(icon, color: _navy)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => page)),
    ),
  );
}
class JobLifecycleScreen extends StatefulWidget {
  const JobLifecycleScreen({super.key});
  @override State<JobLifecycleScreen> createState() => _JobLifecycleScreenState();
}
class _JobLifecycleScreenState extends State<JobLifecycleScreen> {
  int stage = 1;
  final stages = const ['Posted', 'Matched', 'Accepted', 'In progress', 'Customer review', 'Completed'];
  @override Widget build(BuildContext context) => _ModuleScaffold(title: 'Job lifecycle', child: ListView(padding: const EdgeInsets.all(18), children: [
    _InfoCard(title: 'घर की वायरिंग', subtitle: 'लंका, वाराणसी • Electrician • ₹850 / दिन', trailing: 'Demo job'),
    const SizedBox(height: 18), const Text('काम की स्थिति', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
    const SizedBox(height: 8),
    ...List.generate(stages.length, (i) => ListTile(
      leading: CircleAvatar(radius: 15, backgroundColor: i <= stage ? _mint : Colors.black12, child: Icon(i < stage ? Icons.check : Icons.circle, size: 14, color: i <= stage ? Colors.white : Colors.black38)),
      title: Text(stages[i], style: TextStyle(fontWeight: i == stage ? FontWeight.w800 : FontWeight.normal)),
      subtitle: Text(i == stage ? 'Current demo stage' : i < stage ? 'Marked in demo flow' : 'Pending'),
    )),
    const SizedBox(height: 12),
    FilledButton(onPressed: () => setState(() => stage = (stage + 1).clamp(0, stages.length - 1).toInt()), child: const Text('Advance demo milestone')),
    const Text('Production में हर transition server-side authorization, audit log और idempotency से नियंत्रित होगा.', style: TextStyle(fontSize: 12, color: Colors.black54)),
  ]));
}
class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});
  @override State<AttendanceScreen> createState() => _AttendanceScreenState();
}
class _AttendanceScreenState extends State<AttendanceScreen> {
  bool checkedIn = false;
  @override Widget build(BuildContext context) => _ModuleScaffold(title: 'Attendance', child: ListView(padding: const EdgeInsets.all(18), children: [
    _InfoCard(title: 'आज का काम', subtitle: 'Site: Lanka, Varanasi\nWorker: Demo electrician', trailing: '09:00 AM'),
    const SizedBox(height: 18),
    Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: const Color(0xFFE8F5F1), borderRadius: BorderRadius.circular(20)), child: Column(children: [
      Icon(checkedIn ? Icons.verified : Icons.qr_code_2, size: 62, color: _mint),
      const SizedBox(height: 10), Text(checkedIn ? 'Check-in recorded (demo)' : 'Verify site attendance', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _navy)),
      const SizedBox(height: 6), const Text('Actual QR/OTP verification and trusted timestamp need the backend.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
      const SizedBox(height: 14), FilledButton(onPressed: () => setState(() => checkedIn = !checkedIn), child: Text(checkedIn ? 'Reset demo check-in' : 'Demo check-in')),
    ])),
    const SizedBox(height: 16), const _InfoCard(title: 'Attendance policy', subtitle: 'Worker and customer both see recorded start/end time. Disputes go to manual review.', trailing: 'Policy'),
  ]));
}
class InspectionScreen extends StatefulWidget {
  const InspectionScreen({super.key});
  @override State<InspectionScreen> createState() => _InspectionScreenState();
}
class _InspectionScreenState extends State<InspectionScreen> {
  final checks = <String, bool>{'Work scope matches request': false, 'Parts/model verified': false, 'Safety precautions followed': false, 'Customer walkthrough completed': false};
  @override Widget build(BuildContext context) => _ModuleScaffold(title: 'Manager inspection', child: ListView(padding: const EdgeInsets.all(18), children: [
    _InfoCard(title: 'Inspection #ARJ-1024', subtitle: 'Refrigerator diagnosis • Sigra, Varanasi', trailing: 'Pending'),
    const SizedBox(height: 12), const Text('Quality checklist', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
    ...checks.keys.map((k) => CheckboxListTile(value: checks[k], onChanged: (v) => setState(() => checks[k] = v ?? false), title: Text(k), controlAffinity: ListTileControlAffinity.leading, contentPadding: EdgeInsets.zero)),
    const SizedBox(height: 8), OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined), label: const Text('Attach inspection photos (UI only)')),
    FilledButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Demo checklist saved locally only.'))), child: const Text('Save inspection draft')),
    const Text('Evidence upload, tamper-resistant audit trail and approval permissions are not connected yet.', style: TextStyle(fontSize: 12, color: Colors.black54)),
  ]));
}
class SupplierScreen extends StatelessWidget {
  const SupplierScreen({super.key});
  @override Widget build(BuildContext context) => _ModuleScaffold(title: 'Supplier inventory', child: ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Nearby parts network', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: _navy)),
    const SizedBox(height: 12),
    const _StockTile(name: 'Universal refrigerator relay', code: 'REF-RLY-02', price: '₹420', stock: '8 available', eta: 'Same day'),
    const _StockTile(name: 'Copper wire 1.5 sq mm', code: 'ELE-CU-15', price: '₹1,850', stock: '12 coils', eta: '2–3 hours'),
    const _StockTile(name: 'PVC plumbing elbow set', code: 'PLB-ELB-01', price: '₹160', stock: '25 sets', eta: 'Same day'),
    const SizedBox(height: 10), const Text('Demo catalogue only. Supplier verification, live stock sync, invoices, returns and delivery proof require integrations.', style: TextStyle(fontSize: 12, color: Colors.black54)),
  ]));
}
class _StockTile extends StatelessWidget {
  const _StockTile({required this.name, required this.code, required this.price, required this.stock, required this.eta});
  final String name, code, price, stock, eta;
  @override Widget build(BuildContext context) => Card(child: ListTile(
    leading: const CircleAvatar(backgroundColor: Color(0xFFFFF1D6), child: Icon(Icons.inventory_2_outlined, color: _navy)),
    title: Text(name, style: const TextStyle(fontWeight: FontWeight.w800)), subtitle: Text('$code • $stock\nETA: $eta'),
    isThreeLine: true, trailing: Text(price, style: const TextStyle(color: _mint, fontWeight: FontWeight.w900)),
  ));
}
class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});
  @override Widget build(BuildContext context) => _ModuleScaffold(title: 'Payments & ledger', child: ListView(padding: const EdgeInsets.all(18), children: [
    Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: const LinearGradient(colors: [_navy, Color(0xFF334E87)]), borderRadius: BorderRadius.circular(20)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Demo payable amount', style: TextStyle(color: Colors.white70)), SizedBox(height: 6),
      Text('₹850.00', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900)),
      Text('No real funds collected or held', style: TextStyle(color: Colors.white70, fontSize: 12)),
    ])),
    const SizedBox(height: 14), const _InfoCard(title: 'Customer payment', subtitle: 'Pending provider checkout integration', trailing: 'Not live'),
    const _InfoCard(title: 'Worker payout', subtitle: 'Eligible after verified milestone and provider settlement', trailing: 'Not live'),
    const _InfoCard(title: 'Platform fee', subtitle: 'Must be disclosed before customer confirmation', trailing: 'Policy'),
    const SizedBox(height: 10), const Text('Never treat this screen as a wallet or proof of payment. A regulated payment provider and reviewed marketplace settlement flow are required.', style: TextStyle(fontSize: 12, color: Colors.black54)),
  ]));
}
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override Widget build(BuildContext context) => _ModuleScaffold(title: 'Notifications', child: ListView(padding: const EdgeInsets.all(18), children: const [
    _InfoCard(title: 'New job near Lanka', subtitle: 'Electrician requirement • Demo alert', trailing: 'Now'),
    _InfoCard(title: 'Inspection pending', subtitle: 'Manager review required before milestone approval', trailing: '1h'),
    _InfoCard(title: 'Profile verification', subtitle: 'Complete identity checks when secure KYC is enabled', trailing: 'Today'),
  ]));
}
class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});
  @override State<SupportScreen> createState() => _SupportScreenState();
}
class _SupportScreenState extends State<SupportScreen> {
  String topic = 'Payment or payout';
  final details = TextEditingController();
  @override void dispose() { details.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => _ModuleScaffold(title: 'Help & dispute support', child: ListView(padding: const EdgeInsets.all(18), children: [
    const Text('हम आपकी मदद करेंगे', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: _navy)),
    const SizedBox(height: 14),
    DropdownButtonFormField<String>(value: topic, decoration: const InputDecoration(labelText: 'समस्या का प्रकार'), items: const ['Payment or payout','Work quality','Attendance dispute','Cancellation','Safety concern','Other'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(), onChanged: (v) => setState(() => topic = v ?? topic)),
    const SizedBox(height: 12), TextField(controller: details, minLines: 4, maxLines: 7, decoration: const InputDecoration(labelText: 'समस्या का विवरण', hintText: 'क्या हुआ, कब हुआ और किस काम से जुड़ा है?')),
    const SizedBox(height: 14), FilledButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Demo only: support case was not submitted to a server.'))), child: const Text('Support request preview')),
    const Text('Safety-related reports must route to a staffed response process before launch.', style: TextStyle(fontSize: 12, color: Colors.black54)),
  ]));
}
class _ModuleScaffold extends StatelessWidget {
  const _ModuleScaffold({required this.title, required this.child});
  final String title; final Widget child;
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(title)), body: child);
}
class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.subtitle, required this.trailing});
  final String title, subtitle, trailing;
  @override Widget build(BuildContext context) => Card(margin: const EdgeInsets.only(bottom: 10), child: ListTile(
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: _navy)),
    subtitle: Text(subtitle), trailing: Text(trailing, style: const TextStyle(color: _mint, fontWeight: FontWeight.w700)),
  ));
}
