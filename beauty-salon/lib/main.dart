import 'package:flutter/material.dart';

void main() => runApp(const SalonApp());

class P {
  static const rose = Color(0xFFD88FA2);
  static const deep = Color(0xFFA94F6B);
  static const ivory = Color(0xFFFFF9F5);
  static const gold = Color(0xFFC6A46A);
  static const ink = Color(0xFF382F33);
  static const muted = Color(0xFF8C7D82);
  static const blush = Color(0xFFF7E2E7);
  static const line = Color(0xFFF0E4E5);
}

class Service {
  const Service(this.name, this.category, this.price, this.minutes, this.icon);
  final String name, category;
  final int price, minutes;
  final IconData icon;
}

const services = <Service>[
  Service('Signature haircut', 'Hair', 499, 45, Icons.content_cut),
  Service('Hair spa ritual', 'Hair', 999, 60, Icons.spa),
  Service('Radiance facial', 'Skin', 799, 50, Icons.face_retouching_natural),
  Service('Bridal glow facial', 'Skin', 1899, 75, Icons.auto_awesome),
  Service('Classic manicure', 'Nails', 399, 35, Icons.brush),
  Service('Gel nail art', 'Nails', 899, 60, Icons.palette),
  Service('Relaxing head massage', 'Wellness', 599, 30, Icons.self_improvement),
];

enum Role { customer, owner, staff }

class SalonApp extends StatelessWidget {
  const SalonApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Beauty Studio', debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: P.ivory,
      colorScheme: ColorScheme.fromSeed(seedColor: P.rose),
      appBarTheme: const AppBarTheme(backgroundColor: P.ivory, foregroundColor: P.ink, elevation: 0),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none))),
    home: const RoleGate(),
  );
}

class RoleGate extends StatelessWidget {
  const RoleGate({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: ListView(padding: const EdgeInsets.all(22), children: [
      const Row(children: [CircleAvatar(backgroundColor: P.blush, child: Icon(Icons.spa, color: P.deep)),
        SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('BEAUTY PARLOUR', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w900, color: P.deep)),
          Text('BEAUTY PARLOUR MANAGEMENT', style: TextStyle(fontSize: 9, color: P.muted))])]),
      const SizedBox(height: 30),
      Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [P.blush, Color(0xFFFFF0E1)]), borderRadius: BorderRadius.circular(26)),
        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('BEAUTY,\nMADE PERSONAL.', style: TextStyle(fontSize: 32, height: 1.1, fontWeight: FontWeight.w900, color: P.ink)),
          SizedBox(height: 10), Text('Your beauty parlour experience. Your business. One beautiful space.', style: TextStyle(color: P.muted)),
          SizedBox(height: 18), Text('BOOK  •  MANAGE  •  GROW', style: TextStyle(letterSpacing: 1.4, fontSize: 10, color: P.deep, fontWeight: FontWeight.w800))])),
      const SizedBox(height: 26),
      const Text('Choose your workspace', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: P.ink)),
      const SizedBox(height: 6), const Text('Demo access for customer, salon owner and team.', style: TextStyle(color: P.muted)),
      const SizedBox(height: 18),
      _role(context, Role.customer, 'Customer', 'Explore services and book appointments', Icons.face_retouching_natural),
      _role(context, Role.owner, 'Salon Owner', 'Appointments, billing and business overview', Icons.storefront),
      _role(context, Role.staff, 'Salon Team', 'Your schedule, clients and commissions', Icons.badge),
      const SizedBox(height: 10), const Center(child: Text('DEMO BUILD • SAMPLE DATA', style: TextStyle(fontSize: 10, letterSpacing: 1.2, color: P.muted))),
    ])),
  );

  Widget _role(BuildContext context, Role role, String title, String subtitle, IconData icon) => Padding(
    padding: const EdgeInsets.only(bottom: 11),
    child: Card(color: Colors.white, elevation: 0, shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18), side: const BorderSide(color: P.line)),
      child: ListTile(contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(backgroundColor: P.blush, child: Icon(icon, color: P.deep)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, color: P.gold),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Workspace(role: role)))),
    ),
  );
}

class Workspace extends StatefulWidget {
  const Workspace({super.key, required this.role});
  final Role role;
  @override
  State<Workspace> createState() => _WorkspaceState();
}

class _WorkspaceState extends State<Workspace> {
  int tab = 0;
  final bookings = <String>['11:00 • Riya Sharma • Radiance facial', '12:30 • Ananya Singh • Hair spa ritual'];
  final cart = <Service>[];
  int get total => cart.fold(0, (sum, item) => sum + item.price);

  List<String> get labels => switch (widget.role) {
    Role.customer => ['Home', 'Services', 'Bookings', 'Profile'],
    Role.owner => ['Overview', 'Bookings', 'POS', 'Business'],
    Role.staff => ['My day', 'Schedule', 'Clients', 'Profile'],
  };
  List<IconData> get icons => switch (widget.role) {
    Role.customer => [Icons.home_outlined, Icons.spa_outlined, Icons.calendar_month, Icons.person_outline],
    Role.owner => [Icons.dashboard_outlined, Icons.event_note, Icons.point_of_sale, Icons.store_outlined],
    Role.staff => [Icons.today_outlined, Icons.calendar_month, Icons.people_outline, Icons.person_outline],
  };

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      title: const Text('BEAUTY PARLOUR', style: TextStyle(fontSize: 14, letterSpacing: 2, fontWeight: FontWeight.w900, color: P.deep)),
      actions: [IconButton(onPressed: () => toast('No new notifications'), icon: const Icon(Icons.notifications_none))]),
    body: AnimatedSwitcher(duration: const Duration(milliseconds: 180), child: page()),
    bottomNavigationBar: NavigationBar(selectedIndex: tab, backgroundColor: Colors.white, indicatorColor: P.blush,
      onDestinationSelected: (v) => setState(() => tab = v),
      destinations: List.generate(4, (i) => NavigationDestination(icon: Icon(icons[i]), label: labels[i]))),
  );

  Widget page() => switch (widget.role) {
    Role.customer => customerPage(), Role.owner => ownerPage(), Role.staff => staffPage(),
  };

  Widget customerPage() {
    if (tab == 1) return scroll('Explore services', 'Choose a treatment and reserve your slot.', [for (final s in services) serviceCard(s)]);
    if (tab == 2) return scroll('My bookings', 'Your appointments and visit history.', [
      for (final b in bookings) tile(Icons.event_available, b, 'Appointment details and stylist', 'VIEW'),
      tile(Icons.history, 'Past visits', 'Your salon visit history', 'OPEN'),
    ]);
    if (tab == 3) return scroll('Your profile', 'Manage your beauty parlour experience.', [
      tile(Icons.person_outline, 'Personal details', 'Name, phone and preferences', 'EDIT'),
      tile(Icons.card_giftcard, 'Rewards & memberships', 'Offers and loyalty benefits', 'OPEN'),
      tile(Icons.help_outline, 'Help & support', 'Contact the beauty parlour team', 'HELP'),
    ]);
    return scroll('Hello, beautiful ✨', 'Ready for a little self-care?', [
      hero('YOUR SELF-CARE MOMENT', 'Discover services made around you.'),
      section('Popular services', 'VIEW ALL', () => setState(() => tab = 1)),
      serviceCard(services[0]), serviceCard(services[2]), serviceCard(services[4]),
      section('Your next visit', 'MY BOOKINGS', () => setState(() => tab = 2)),
      empty('No upcoming appointment', 'Book a service to see your next visit here.'),
    ]);
  }

  Widget ownerPage() {
    if (tab == 1) return scroll('Appointments', 'Today • 18 November 2026', [
      for (final b in bookings) tile(Icons.calendar_month, b, 'Stylist assigned • appointment details', 'CONFIRMED'),
      tile(Icons.add_circle_outline, 'Create walk-in booking', 'Add a phone or walk-in appointment', 'ADD', newBooking),
    ]);
    if (tab == 2) return posPage();
    if (tab == 3) return scroll('Business centre', 'Your salon operations in one place.', [
      tile(Icons.people, 'Team & permissions', 'Staff profiles, shifts and access', 'OPEN'),
      tile(Icons.inventory_2, 'Inventory', 'Products and low-stock alerts', 'OPEN'),
      tile(Icons.account_balance_wallet, 'Expenses & finance', 'Costs, commissions and profit', 'OPEN'),
      tile(Icons.campaign, 'Offers & memberships', 'Coupons and loyalty plans', 'OPEN'),
      tile(Icons.analytics, 'Reports & insights', 'Sales and staff performance', 'OPEN'),
      tile(Icons.settings, 'Salon settings', 'Business profile and preferences', 'OPEN'),
    ]);
    return scroll('Good morning, Owner', 'Here is your salon at a glance.', [
      hero('TODAY’S REVENUE', '₹ 18,450  •  +12.8% compared with yesterday'),
      Row(children: [metric('24', 'Bookings', Icons.calendar_month), const SizedBox(width: 9), metric('18', 'Completed', Icons.task_alt)]),
      const SizedBox(height: 9),
      Row(children: [metric('₹2,450', 'Avg. bill', Icons.receipt_long), const SizedBox(width: 9), metric('8', 'Team online', Icons.people_alt)]),
      section('Today’s activity', 'ALL BOOKINGS', () => setState(() => tab = 1)),
      for (final b in bookings) tile(Icons.schedule, b, 'Confirmed appointment', 'TODAY'),
      section('Quick actions', 'OPEN POS', () => setState(() => tab = 2)),
      tile(Icons.point_of_sale, 'Create a bill', 'Add services and collect payment', 'BILL', () => setState(() => tab = 2)),
    ]);
  }

  Widget posPage() => scroll('Quick billing', 'Add services to create a demo invoice.', [
    Container(padding: const EdgeInsets.all(17), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: P.line)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('CURRENT BILL', style: TextStyle(fontSize: 11, letterSpacing: 1.3, color: P.muted, fontWeight: FontWeight.w800)),
        const SizedBox(height: 7), Text('₹' + total.toString(), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: P.ink)),
        Text(cart.length.toString() + ' service(s) added', style: const TextStyle(color: P.muted)),
        if (cart.isNotEmpty) ...[
          const Divider(height: 20),
          for (final item in cart) Padding(padding: const EdgeInsets.only(bottom: 5), child: Text(item.name + '  •  ₹' + item.price.toString())),
          const SizedBox(height: 8),
          SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: payment, icon: const Icon(Icons.payments), label: const Text('Collect payment'))),
        ],
      ])),
    section('Add a service', 'SERVICE MENU', () {}),
    for (final s in services) tile(s.icon, s.name, s.minutes.toString() + ' min', '₹' + s.price.toString(), () => setState(() => cart.add(s))),
  ]);

  Widget staffPage() {
    if (tab == 1) return scroll('My schedule', 'Your assigned sessions for today.', [
      tile(Icons.schedule, '10:30 AM · Riya Sharma', 'Radiance facial · 50 min', 'DONE'),
      tile(Icons.schedule, '12:00 PM · Ananya Singh', 'Hair spa ritual · 60 min', 'NEXT'),
      tile(Icons.schedule, '02:30 PM · Neha Gupta', 'Classic manicure · 35 min', 'LATER'),
    ]);
    if (tab == 2) return scroll('My clients', 'Client care and appointment notes.', [
      tile(Icons.person, 'Riya Sharma', 'Prefers gentle skincare products', 'VIEW'),
      tile(Icons.person, 'Ananya Singh', 'Regular hair spa client', 'VIEW'),
      tile(Icons.star, 'Customer feedback', '4.9 average rating', 'OPEN'),
    ]);
    if (tab == 3) return scroll('My profile', 'Your team account and work details.', [
      tile(Icons.badge, 'Meera Kapoor', 'Senior Beauty Therapist', 'PROFILE'),
      tile(Icons.payments, 'Commission this month', '₹8,450 earned', 'VIEW'),
      tile(Icons.event_busy, 'Leave & attendance', 'Shift and leave requests', 'OPEN'),
    ]);
    return scroll('Your workday', 'Welcome back, Meera. Let’s make it a great one.', [
      hero('YOU’RE ON SHIFT', 'Senior Beauty Therapist • 9:00 AM – 6:00 PM'),
      Row(children: [metric('6', 'Sessions', Icons.spa), const SizedBox(width: 9), metric('4', 'Completed', Icons.task_alt)]),
      const SizedBox(height: 9),
      Row(children: [metric('₹1,250', 'Commission', Icons.payments), const SizedBox(width: 9), metric('7.5h', 'Hours', Icons.schedule)]),
      section('Next appointment', 'VIEW SCHEDULE', () => setState(() => tab = 1)),
      tile(Icons.face_3, '11:15 AM · Riya Verma', 'Signature facial · 60 min', 'NEXT'),
    ]);
  }

  Widget scroll(String title, String subtitle, List<Widget> children) => ListView(
    key: ValueKey(title + tab.toString()), padding: const EdgeInsets.fromLTRB(19, 10, 19, 28),
    children: [Text(title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: P.ink)),
      const SizedBox(height: 5), Text(subtitle, style: const TextStyle(color: P.muted)),
      const SizedBox(height: 17), ...children],
  );

  Widget hero(String title, String subtitle) => Container(margin: const EdgeInsets.only(bottom: 13), padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [P.blush, Color(0xFFFFF0E1)]), borderRadius: BorderRadius.circular(22)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: P.ink)),
      const SizedBox(height: 7), Text(subtitle, style: const TextStyle(color: P.muted))]));

  Widget section(String title, String action, VoidCallback onTap) => Padding(padding: const EdgeInsets.only(top: 12, bottom: 9),
    child: Row(children: [Expanded(child: Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: P.ink))),
      TextButton(onPressed: onTap, child: Text(action, style: const TextStyle(fontSize: 10, color: P.deep, fontWeight: FontWeight.w800)))]));
  
  Widget metric(String value, String label, IconData icon) => Expanded(child: Container(padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), border: Border.all(color: P.line)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: P.deep, size: 19), const SizedBox(height: 8),
      Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: P.ink)),
      Text(label, style: const TextStyle(fontSize: 11, color: P.muted))])));

  Widget serviceCard(Service s) => InkWell(borderRadius: BorderRadius.circular(17), onTap: () => book(s),
    child: Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), border: Border.all(color: P.line)),
      child: Row(children: [
        CircleAvatar(backgroundColor: P.blush, child: Icon(s.icon, color: P.deep)), const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(s.name, style: const TextStyle(fontWeight: FontWeight.w800, color: P.ink)),
          Text(s.category + ' • ' + s.minutes.toString() + ' min', style: const TextStyle(fontSize: 11, color: P.muted))])),
        Text('₹' + s.price.toString(), style: const TextStyle(fontWeight: FontWeight.w900, color: P.deep))])));

  Widget tile(IconData icon, String title, String subtitle, String tag, [VoidCallback? action]) => Container(margin: const EdgeInsets.only(bottom: 9),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: P.line)),
    child: ListTile(onTap: action ?? () => toast(title + ' • Demo screen'),
      leading: CircleAvatar(backgroundColor: P.blush, child: Icon(icon, color: P.deep, size: 19)),
      title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: P.ink)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 11, color: P.muted)),
      trailing: Text(tag, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: P.deep))));

  Widget empty(String title, String subtitle) => Container(padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17)),
    child: Column(children: [const Icon(Icons.event_available, color: P.gold, size: 30), const SizedBox(height: 8),
      Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: P.ink)),
      Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: P.muted))]));

  Future<void> book(Service service) async {
    final result = await showModalBottomSheet<bool>(context: context, isScrollControlled: true, backgroundColor: P.ivory,
      builder: (_) => BookingSheet(service: service));
    if (result == true && mounted) {
      setState(() { bookings.insert(0, 'New • ' + service.name + ' • Requested'); tab = 2; });
      toast('Booking request saved in this demo');
    }
  }

  Future<void> newBooking() async {
    final name = TextEditingController();
    final result = await showDialog<String>(context: context, builder: (context) => AlertDialog(
      title: const Text('New walk-in booking'),
      content: TextField(controller: name, decoration: const InputDecoration(labelText: 'Customer name')),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(context, name.text.trim()), child: const Text('Save'))]));
    if (result != null && result.isNotEmpty && mounted) setState(() => bookings.insert(0, 'Walk-in • ' + result));
  }

  Future<void> payment() async {
    final method = await showDialog<String>(context: context, builder: (context) => AlertDialog(
      title: const Text('Collect payment'), content: Text('Demo invoice total: ₹' + total.toString() + '\nChoose a payment method.'),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        TextButton(onPressed: () => Navigator.pop(context, 'Cash'), child: const Text('Cash')),
        FilledButton(onPressed: () => Navigator.pop(context, 'UPI'), child: const Text('UPI'))]));
    if (method != null && mounted) { setState(cart.clear); toast(method + ' payment recorded in demo'); }
  }

  void toast(String text) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

class BookingSheet extends StatefulWidget {
  const BookingSheet({super.key, required this.service});
  final Service service;
  @override
  State<BookingSheet> createState() => _BookingSheetState();
}

class _BookingSheetState extends State<BookingSheet> {
  String slot = '11:00 AM';
  String stylist = 'Any available';
  @override
  Widget build(BuildContext context) => SafeArea(child: Padding(
    padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + MediaQuery.viewInsetsOf(context).bottom),
    child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Book your service', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: P.ink)),
      const SizedBox(height: 5), Text(widget.service.name, style: const TextStyle(color: P.deep, fontWeight: FontWeight.w800)),
      Text('₹' + widget.service.price.toString() + ' • ' + widget.service.minutes.toString() + ' minutes', style: const TextStyle(color: P.muted)),
      const SizedBox(height: 17), const Text('Choose a time', style: TextStyle(fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        children: ['11:00 AM', '12:30 PM', '02:00 PM', '04:30 PM']
            .map((v) => ChoiceChip(
                  label: Text(v),
                  selected: slot == v,
                  onSelected: (_) => setState(() => slot = v),
                ))
            .toList(),
      ),
      const SizedBox(height: 15), const Text('Stylist', style: TextStyle(fontWeight: FontWeight.w800)),
      DropdownButton<String>(isExpanded: true, value: stylist,
        items: ['Any available', 'Priya', 'Meera', 'Aditi'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: (v) => setState(() => stylist = v ?? stylist)),
      const SizedBox(height: 12), SizedBox(width: double.infinity,
        child: FilledButton(onPressed: () => Navigator.pop(context, true), child: Text('Request booking • ' + slot))),
    ]),
  ));
}
