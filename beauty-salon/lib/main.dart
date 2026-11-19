import 'package:flutter/material.dart';

void main() => runApp(const GlowBelleApp());

class GlowBelleApp extends StatelessWidget {
  const GlowBelleApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'GlowBelle Beauty Parlour',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFFE8ED),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF9E123D)),
      fontFamily: 'Georgia',
    ),
    home: const GlowBelleHome(),
  );
}

const wine = Color(0xFF851333);
const burgundy = Color(0xFF9F1745);
const blush = Color(0xFFFFE5EB);
const gold = Color(0xFFD7AE69);
const ink = Color(0xFF4B1428);
const muted = Color(0xFF8B5969);

class GlowBelleHome extends StatefulWidget {
  const GlowBelleHome({super.key});
  @override
  State<GlowBelleHome> createState() => _GlowBelleHomeState();
}

class _GlowBelleHomeState extends State<GlowBelleHome> {
  int nav = 0;
  int category = 0;
  final search = TextEditingController();
  final categories = const [
    (Icons.face_retouching_natural, 'Facial'),
    (Icons.content_cut, 'Hair'),
    (Icons.brush, 'Nails'),
    (Icons.auto_awesome, 'Makeup'),
    (Icons.spa, 'Spa'),
    (Icons.apps, 'More'),
  ];
  final services = const [
    ('Skin Brightening Facial', '₹1,299', Icons.face_retouching_natural),
    ('Hair Spa & Repair', '₹899', Icons.spa),
    ('Gel Nails Art', '₹699', Icons.brush),
    ('Threading (Eyebrow)', '₹149', Icons.remove_red_eye),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [Color(0xFFFFF0F2), Color(0xFFFFDDE6), Color(0xFFFFF0EE)],
            ),
          ),
          child: nav == 0 ? _home() : _otherPage(),
        ),
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }

  Widget _home() => LayoutBuilder(builder: (context, constraints) {
    final compact = constraints.maxHeight < 760;
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 20),
      children: [
        _topBar(),
        const SizedBox(height: 12),
        _greeting(),
        const SizedBox(height: 14),
        _searchBar(),
        const SizedBox(height: 17),
        _categoryRow(),
        SizedBox(height: compact ? 15 : 20),
        _featured(),
        SizedBox(height: compact ? 13 : 17),
        _insightRow(),
        const SizedBox(height: 15),
        _sectionTitle('♡  Recommended For You', 'View All'),
        const SizedBox(height: 9),
        _recommended(),
        const SizedBox(height: 18),
        _offerStrip(),
      ],
    );
  });

  Widget _topBar() => Row(
    children: [
      SizedBox(width: 38, child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () => _message('Menu'),
        icon: const Icon(Icons.menu, color: wine, size: 27),
      )),
      Expanded(child: Column(children: [
        const Icon(Icons.face_3, color: burgundy, size: 27),
        const FittedBox(fit: BoxFit.scaleDown, child: Text(
          'GlowBelle',
          style: TextStyle(fontSize: 27, fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w700, color: wine, letterSpacing: -1.4),
        )),
        const Text('— BEAUTY PARLOUR —', style: TextStyle(
          fontSize: 7, letterSpacing: 1.2, color: ink, fontWeight: FontWeight.w700)),
      ])),
      SizedBox(width: 38, child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () => _message('Notifications'),
        icon: const Icon(Icons.notifications_none, color: wine, size: 24),
      )),
      SizedBox(width: 38, child: Stack(children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => _message('Your cart'),
          icon: const Icon(Icons.shopping_cart_outlined, color: wine, size: 24),
        ),
        Positioned(right: 0, top: 0, child: _countBadge('3')),
      ])),
    ],
  );

  Widget _greeting() => LayoutBuilder(builder: (context, constraints) {
    final portraitSize = constraints.maxWidth < 350 ? 88.0 : 104.0;
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('👋 Hello,', style: TextStyle(fontSize: 19, color: ink)),
        const SizedBox(height: 1),
        const FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft,
          child: Text('Priya Sharma 👑', style: TextStyle(fontSize: 24, height: 1.12, fontWeight: FontWeight.w900, color: wine))),
        const SizedBox(height: 5),
        const FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft,
          child: Row(children: [Text('Ready to Glow Today? ', style: TextStyle(fontSize: 15, color: ink)), Icon(Icons.favorite_border, color: burgundy, size: 20)])),
      ])),
      const SizedBox(width: 6),
      _BeautyPortrait(size: portraitSize),
    ]);
  });

  Widget _searchBar() => Container(
    height: 51, padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(color: const Color(0xFFFFF8F8), borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.white, width: 2), boxShadow: [BoxShadow(color: wine.withOpacity(.10), blurRadius: 12, offset: const Offset(0, 4))]),
    child: Row(children: [
      const Icon(Icons.search, color: ink, size: 25),
      const SizedBox(width: 10),
      Expanded(child: TextField(controller: search, decoration: const InputDecoration(border: InputBorder.none, hintText: 'Search services, packages...', hintStyle: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: muted), isDense: true))),
      IconButton(onPressed: () => _message('Voice search'), icon: const Icon(Icons.mic_none, color: wine)),
    ]),
  );

  Widget _categoryRow() => SizedBox(height: 93, child: ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: categories.length,
    separatorBuilder: (_, __) => const SizedBox(width: 9),
    itemBuilder: (context, i) {
      final selected = category == i;
      return GestureDetector(
        onTap: () => setState(() => category = i),
        child: AnimatedContainer(duration: const Duration(milliseconds: 180), width: 82,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFFFF4F5) : const Color(0xFFFFEDEF),
            borderRadius: BorderRadius.circular(23),
            border: Border.all(color: selected ? gold : Colors.white, width: 1.6),
            boxShadow: [BoxShadow(color: wine.withOpacity(.10), blurRadius: 8, offset: const Offset(0, 3))],
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(categories[i].$1, size: 31, color: wine),
            const SizedBox(height: 5),
            Text(categories[i].$2, style: const TextStyle(fontFamily: 'Roboto', fontSize: 13, color: ink, fontWeight: FontWeight.w600)),
          ]),
        ),
      );
    },
  ));

  Widget _featured() => Container(
    height: 224,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(27),
      border: Border.all(color: gold, width: 1.3),
      gradient: const LinearGradient(colors: [Color(0xFFFFC9D7), Color(0xFFFFE5E9), Color(0xFFF7B8CA)]),
      boxShadow: [BoxShadow(color: wine.withOpacity(.13), blurRadius: 12, offset: const Offset(0, 5))],
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(children: [
      const Positioned(right: -8, top: 4, child: _BeautyPortrait(size: 190)),
      Positioned(left: 16, top: 16, child: _pill('👑 Featured Treatment')),
      Positioned(left: 17, top: 54, child: Text('Glow Facial', style: TextStyle(fontSize: 36, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700, color: wine, shadows: [Shadow(color: Colors.white.withOpacity(.7), blurRadius: 8)]))),
      const Positioned(left: 20, top: 101, child: Text('Deep Cleanse • Hydrate • Brighten', style: TextStyle(fontFamily: 'Roboto', fontSize: 12, color: ink))),
      const Positioned(left: 18, top: 135, child: Row(children: [
        Text('₹999', style: TextStyle(fontFamily: 'Roboto', fontSize: 23, fontWeight: FontWeight.w900, color: wine)),
        SizedBox(width: 10),
        Text('₹1,499', style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: muted, decoration: TextDecoration.lineThrough)),
        SizedBox(width: 8),
      ])),
      Positioned(left: 17, bottom: 18, child: FilledButton(
        style: FilledButton.styleFrom(backgroundColor: burgundy, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10)),
        onPressed: () => _message('Glow Facial booking'),
        child: const Text('Book Now  →', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700)),
      )),
      const Positioned(right: 18, bottom: 15, child: Text('●  ○  ○', style: TextStyle(color: burgundy, letterSpacing: 3))),
    ]),
  );

  Widget _insightRow() => LayoutBuilder(builder: (context, constraints) {
    final narrow = constraints.maxWidth < 390;
    final booking = _infoCard(
      icon: Icons.calendar_month, title: 'Your Upcoming Booking',
      child: Row(children: [
        const _MiniBeauty(size: 58),
        const SizedBox(width: 8),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Bridal Makeup', maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: ink)),
          SizedBox(height: 7),
          Text('▦  Sun, 04 Feb', maxLines: 1, style: TextStyle(fontFamily: 'Roboto', fontSize: 10, color: ink)),
          SizedBox(height: 4),
          Text('◷  11:00 AM', maxLines: 1, style: TextStyle(fontFamily: 'Roboto', fontSize: 10, color: ink)),
        ])),
        const Icon(Icons.chevron_right, color: burgundy, size: 20),
      ]),
    );
    final intelligence = _infoCard(
      icon: Icons.workspace_premium, title: 'Member Intelligence',
      child: Row(children: [
        SizedBox(width: 76, height: 76, child: Stack(alignment: Alignment.center, children: [
          SizedBox.expand(child: CircularProgressIndicator(value: .8, strokeWidth: 8, backgroundColor: blush, color: burgundy)),
          const Column(mainAxisSize: MainAxisSize.min, children: [
            Text('80%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: wine)),
            Text('Beauty Score', style: TextStyle(fontFamily: 'Roboto', fontSize: 7, color: ink)),
          ]),
        ])),
        const SizedBox(width: 8),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _ScoreLine('Skin Care', '85%'), SizedBox(height: 7),
          _ScoreLine('Hair Care', '78%'), SizedBox(height: 7),
          _ScoreLine('Self Care', '88%'),
        ])),
      ]),
    );
    if (narrow) {
      return Column(children: [booking, const SizedBox(height: 10), intelligence]);
    }
    return Row(children: [Expanded(child: booking), const SizedBox(width: 10), Expanded(child: intelligence)]);
  });

  Widget _infoCard({required IconData icon, required String title, required Widget child}) => Container(
    height: 174, padding: const EdgeInsets.all(11),
    decoration: BoxDecoration(color: const Color(0xFFFFF0F2), borderRadius: BorderRadius.circular(22), border: Border.all(color: gold, width: 1.1),
      boxShadow: [BoxShadow(color: wine.withOpacity(.08), blurRadius: 8, offset: const Offset(0, 3))]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Icon(icon, size: 19, color: burgundy), const SizedBox(width: 5), Expanded(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: wine)))]),
      const SizedBox(height: 12),
      Expanded(child: child),
    ]),
  );

  Widget _sectionTitle(String title, String action) => Row(children: [
    Expanded(child: Text(title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900, color: wine))),
    TextButton(onPressed: () => _message(action), child: Text('$action →', style: const TextStyle(fontSize: 13, color: burgundy, fontWeight: FontWeight.w800))),
  ]);

  Widget _recommended() => SizedBox(height: 174, child: ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: services.length,
    separatorBuilder: (_, __) => const SizedBox(width: 9),
    itemBuilder: (context, i) => Container(
      width: 145, decoration: BoxDecoration(color: const Color(0xFFFFF2F4), borderRadius: BorderRadius.circular(20), border: Border.all(color: gold, width: 1.1)),
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        Expanded(child: Container(width: double.infinity, decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFF7C2D0), Color(0xFFFFE7E8)])),
          child: Center(child: Icon(services[i].$3, size: 52, color: burgundy)))),
        Padding(padding: const EdgeInsets.fromLTRB(5, 6, 5, 1), child: Text(services[i].$1, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: 'Roboto', fontSize: 12, fontWeight: FontWeight.w700, color: ink))),
        Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(services[i].$2, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: wine))),
      ]),
    ),
  ));

  Widget _offerStrip() => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), gradient: const LinearGradient(colors: [wine, burgundy])),
    child: const Row(children: [
      Icon(Icons.card_giftcard, color: Colors.white, size: 28),
      SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('GlowBelle Rewards', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
        Text('Earn points on every beauty ritual', style: TextStyle(color: Color(0xFFFFDDE7), fontFamily: 'Roboto', fontSize: 11)),
      ])),
      Icon(Icons.arrow_forward_ios, size: 15, color: Colors.white),
    ]),
  );

  Widget _bottomNav() => NavigationBar(
    height: 76,
    backgroundColor: wine,
    indicatorColor: const Color(0xFFFFC6D7),
    selectedIndex: nav,
    onDestinationSelected: (i) => setState(() => nav = i),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    destinations: const [
      NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.calendar_month_outlined), label: 'Bookings'),
      NavigationDestination(icon: Icon(Icons.workspace_premium_outlined), label: 'Membership'),
      NavigationDestination(icon: Icon(Icons.card_giftcard_outlined), label: 'Rewards'),
      NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
    ],
  );

  Widget _otherPage() {
    switch (nav) {
      case 1: return _bookingsPage();
      case 2: return _membershipPage();
      case 3: return _rewardsPage();
      default: return _profilePage();
    }
  }

  Widget _pageShell(String title, IconData icon, List<Widget> children) =>
    ListView(padding: const EdgeInsets.fromLTRB(18, 24, 18, 24), children: [
      Row(children: [Icon(icon, color: burgundy, size: 28), const SizedBox(width: 9),
        Text(title, style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w900, color: wine))]),
      const SizedBox(height: 18), ...children,
    ]);

  Widget _bookingsPage() => _pageShell('My Bookings', Icons.calendar_month, [
    _infoCard(icon: Icons.event_available, title: 'Upcoming Booking', child: Column(children: [
      const _MiniBeauty(size: 58), const SizedBox(height: 8),
      const Text('Bridal Makeup', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: ink)),
      const Text('Sun, 04 Feb  •  11:00 AM', style: TextStyle(color: muted)),
      const SizedBox(height: 8),
      FilledButton(onPressed: () => _message('Booking details'), child: const Text('View Details')),
    ])),
    _sectionTitle('Book a Service', 'Explore'),
    ...services.map((s) => Card(color: const Color(0xFFFFF3F4), child: ListTile(
      leading: Icon(s.$3, color: burgundy), title: Text(s.$1, style: const TextStyle(color: ink)),
      subtitle: Text(s.$2, style: const TextStyle(color: burgundy, fontWeight: FontWeight.bold)),
      trailing: IconButton(icon: const Icon(Icons.add_circle_outline, color: burgundy),
        onPressed: () => _message('Added ${s.$1} to booking')),
    ))),
  ]);

  Widget _membershipPage() => _pageShell('Membership', Icons.workspace_premium, [
    Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24), gradient: const LinearGradient(colors: [wine, burgundy])),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('GLOWBELLE ROYAL', style: TextStyle(color: Color(0xFFFFDDE7), letterSpacing: 2)),
        SizedBox(height: 8), Text('Beauty Club', style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold)),
        Text('Your membership journey starts here.', style: TextStyle(color: Colors.white70)),
      ])),
    const SizedBox(height: 14),
    _infoCard(icon: Icons.stars, title: 'Member Benefits', child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('• Exclusive member-only offers'), Text('• Priority appointment booking'),
      Text('• Birthday beauty surprise'), Text('• Reward points on every visit'),
    ])),
    FilledButton(onPressed: () => _message('Membership plans'), child: const Text('Explore Membership Plans')),
  ]);

  Widget _rewardsPage() => _pageShell('GlowBelle Rewards', Icons.card_giftcard, [
    Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24), gradient: const LinearGradient(colors: [wine, burgundy])),
      child: const Column(children: [
        Icon(Icons.card_giftcard, color: Colors.white, size: 45),
        Text('250', style: TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.w900)),
        Text('Reward Points', style: TextStyle(color: Colors.white70)),
      ])),
    const SizedBox(height: 14),
    _infoCard(icon: Icons.auto_awesome, title: 'Ways to Earn', child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('• Complete a beauty service — earn points'),
      Text('• Refer a friend — bonus points'),
      Text('• Birthday month — special reward'),
    ])),
    _infoCard(icon: Icons.redeem, title: 'Redeem Rewards', child: const Text('Use your points for discounts on selected beauty services.')),
  ]);

  Widget _profilePage() => _pageShell('My Profile', Icons.person, [
    const Center(child: _MiniBeauty(size: 104)),
    const Center(child: Text('Priya Sharma', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: wine))),
    const Center(child: Text('GlowBelle Beauty Member', style: TextStyle(color: muted))),
    const SizedBox(height: 15),
    _infoCard(icon: Icons.badge, title: 'Personal Details', child: const Column(children: [
      ListTile(dense: true, leading: Icon(Icons.person, color: burgundy), title: Text('Name'), subtitle: Text('Priya Sharma')),
      ListTile(dense: true, leading: Icon(Icons.mail_outline, color: burgundy), title: Text('Email'), subtitle: Text('Add email address')),
      ListTile(dense: true, leading: Icon(Icons.phone, color: burgundy), title: Text('Phone'), subtitle: Text('Add phone number')),
    ])),
    _infoCard(icon: Icons.settings, title: 'Preferences & Support', child: Column(children: [
      ListTile(leading: const Icon(Icons.notifications, color: burgundy), title: const Text('Notifications'), onTap: () => _message('Notification preferences')),
      ListTile(leading: const Icon(Icons.help_outline, color: burgundy), title: const Text('Help & Support'), onTap: () => _message('Contact GlowBelle salon team')),
    ])),
  ]);

  Widget _pill(String text) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: const Color(0xFFFFF4F4).withOpacity(.85), borderRadius: BorderRadius.circular(30)),
    child: Text(text, style: const TextStyle(fontSize: 12, color: wine, fontWeight: FontWeight.w900)));

  Widget _countBadge(String text) => Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: burgundy, shape: BoxShape.circle),
    child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900)));

  void _message(String value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$value • Preview')));

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }
}

class _ScoreLine extends StatelessWidget {
  const _ScoreLine(this.label, this.value);
  final String label, value;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [Expanded(child: Text(label, style: const TextStyle(fontFamily: 'Roboto', fontSize: 9, color: ink, fontWeight: FontWeight.w600))), Text(value, style: const TextStyle(fontFamily: 'Roboto', fontSize: 9, color: ink, fontWeight: FontWeight.w800))]),
    const SizedBox(height: 3),
    ClipRRect(borderRadius: BorderRadius.circular(5), child: LinearProgressIndicator(value: double.parse(value.replaceAll('%', ''))/100, minHeight: 5, backgroundColor: const Color(0xFFF5CBD5), color: burgundy)),
  ]);
}

class _BeautyPortrait extends StatelessWidget {
  const _BeautyPortrait({required this.size});
  final double size;
  @override
  Widget build(BuildContext context) => SizedBox(width: size, height: size, child: Stack(alignment: Alignment.center, children: [
    Container(width: size*.88, height: size*.88, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [Color(0xFFFFF5F4), Color(0xFFF6B9C9), Color(0xFFE78DA9)]))),
    Positioned(top: size*.07, child: Icon(Icons.face_3, size: size*.68, color: const Color(0xFF9A435C))),
    Positioned(top: size*.02, right: size*.08, child: Icon(Icons.local_florist, size: size*.22, color: burgundy)),
    Positioned(bottom: size*.05, left: size*.08, child: Icon(Icons.auto_awesome, size: size*.16, color: gold)),
  ]));
}

class _MiniBeauty extends StatelessWidget {
  const _MiniBeauty({required this.size});
  final double size;
  @override
  Widget build(BuildContext context) => Container(width: size, height: size,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), gradient: const LinearGradient(colors: [Color(0xFFF6C0D0), Color(0xFFFFE9E8)])),
    child: Image.asset('assets/booking_avatar.jpg', width: size, height: size, fit: BoxFit.contain));
}
