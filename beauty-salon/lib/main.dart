import 'package:flutter/material.dart';

void main() => runApp(const BeautySalonApp());

class SalonPalette {
  static const rose = Color(0xFFD98FA2);
  static const deepRose = Color(0xFFA94F6B);
  static const ivory = Color(0xFFFFF9F5);
  static const champagne = Color(0xFFC6A46A);
  static const ink = Color(0xFF382F33);
  static const muted = Color(0xFF8C7D82);
}

class BeautySalonApp extends StatelessWidget {
  const BeautySalonApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: SalonPalette.rose,
      brightness: Brightness.light,
      surface: SalonPalette.ivory,
    );
    return MaterialApp(
      title: 'Beauty Salon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: SalonPalette.ivory,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: SalonPalette.ink),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: SalonPalette.ink),
          bodyMedium: TextStyle(fontSize: 14, color: SalonPalette.muted),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          margin: EdgeInsets.zero,
        ),
      ),
      home: const RoleLandingPage(),
    );
  }
}

enum SalonRole { customer, owner, staff }

class RoleLandingPage extends StatelessWidget {
  const RoleLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 26, 22, 28),
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: SalonPalette.rose.withValues(alpha: .16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.spa_rounded, color: SalonPalette.deepRose, size: 27),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('BEAUTY SALON', style: TextStyle(letterSpacing: 2.2, fontWeight: FontWeight.w800, color: SalonPalette.deepRose)),
                    Text('Your salon, beautifully connected', style: TextStyle(fontSize: 11, color: SalonPalette.muted)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 36),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF7E2E7), Color(0xFFFFF4E9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('A more beautiful\nway to run your salon.', style: TextStyle(fontSize: 27, height: 1.15, fontWeight: FontWeight.w800, color: SalonPalette.ink)),
                  const SizedBox(height: 10),
                  const Text('Bookings, people and business — all in one place.', style: TextStyle(color: SalonPalette.muted, height: 1.4)),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      _MiniStat(value: '3', label: 'Workspaces'),
                      const SizedBox(width: 18),
                      _MiniStat(value: '1', label: 'Connected salon'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Text('Continue as', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: SalonPalette.ink)),
            const SizedBox(height: 6),
            const Text('Choose the workspace you want to open.', style: TextStyle(color: SalonPalette.muted)),
            const SizedBox(height: 16),
            _RoleTile(icon: Icons.face_retouching_natural, title: 'Customer', subtitle: 'Explore services and book appointments', role: SalonRole.customer),
            const SizedBox(height: 12),
            _RoleTile(icon: Icons.storefront_rounded, title: 'Salon Owner', subtitle: 'Manage bookings, team and business', role: SalonRole.owner),
            const SizedBox(height: 12),
            _RoleTile(icon: Icons.badge_outlined, title: 'Staff', subtitle: 'View your schedule and assigned services', role: SalonRole.staff),
            const SizedBox(height: 24),
            const Center(child: Text('A premium salon experience starts here', style: TextStyle(fontSize: 11, color: SalonPalette.muted))),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: SalonPalette.deepRose)),
          Text(label, style: const TextStyle(fontSize: 11, color: SalonPalette.muted)),
        ],
      );
}

class _RoleTile extends StatelessWidget {
  const _RoleTile({required this.icon, required this.title, required this.subtitle, required this.role});
  final IconData icon;
  final String title;
  final String subtitle;
  final SalonRole role;

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (_) => RoleHomePage(role: role),
        )),
        child: Ink(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: SalonPalette.rose.withValues(alpha: .18)),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(color: SalonPalette.rose.withValues(alpha: .13), borderRadius: BorderRadius.circular(15)),
                child: Icon(icon, color: SalonPalette.deepRose),
              ),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: SalonPalette.ink)),
                const SizedBox(height: 3),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: SalonPalette.muted)),
              ])),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: SalonPalette.champagne),
            ],
          ),
        ),
      );
}

class RoleHomePage extends StatelessWidget {
  const RoleHomePage({super.key, required this.role});
  final SalonRole role;

  @override
  Widget build(BuildContext context) {
    final title = switch (role) {
      SalonRole.customer => 'Your appointments',
      SalonRole.owner => 'Salon overview',
      SalonRole.staff => 'My workday',
    };
    final subtitle = switch (role) {
      SalonRole.customer => 'Discover services and manage your bookings.',
      SalonRole.owner => 'Your business at a glance.',
      SalonRole.staff => 'Your schedule and assigned services.',
    };
    return Scaffold(
      appBar: AppBar(title: Text(role.name.toUpperCase()), backgroundColor: SalonPalette.ivory),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(subtitle),
          const SizedBox(height: 22),
          _DashboardCard(icon: Icons.calendar_month_rounded, title: 'Appointments', value: 'Your schedule will appear here'),
          const SizedBox(height: 12),
          _DashboardCard(icon: Icons.spa_rounded, title: 'Services', value: 'Salon services and packages'),
          const SizedBox(height: 12),
          _DashboardCard(icon: Icons.insights_rounded, title: 'Insights', value: 'Business and activity insights'),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({required this.icon, required this.title, required this.value});
  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(children: [
            Icon(icon, color: SalonPalette.deepRose, size: 25),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: SalonPalette.ink)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 12, color: SalonPalette.muted)),
            ])),
          ]),
        ),
      );
}
