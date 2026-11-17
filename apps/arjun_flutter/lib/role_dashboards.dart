import 'package:flutter/material.dart';

const _forest = Color(0xFF0B6B50);
const _forestDark = Color(0xFF073D32);
const _paper = Color(0xFFF5F7F4);
const _violet = Color(0xFF7651D6);
const _saffron = Color(0xFFFFB547);

class ManagerDashboard extends StatelessWidget {
  const ManagerDashboard({super.key});
  @override
  Widget build(BuildContext context) => _RolePage(
    eyebrow: 'FIELD OPERATIONS',
    title: 'नमस्ते, मैनेजर 👷',
    subtitle: 'आज की साइट और टीम',
    accent: const Color(0xFF3567C8),
    heroIcon: Icons.location_city_rounded,
    heroTitle: '5 साइट पर काम चल रहा है',
    heroSubtitle: '2 निरीक्षण बाकी • 1 समस्या पर ध्यान दें',
    primary: 'साइट सूची खोलें',
    tiles: const [
      _TileData('साइट विजिट', 'आज 5', Icons.map_rounded, Color(0xFFE7EEFF)),
      _TileData('मजदूर', '28 मौजूद', Icons.groups_rounded, Color(0xFFE3F6ED)),
      _TileData('जाँच बाकी', '2 रिपोर्ट', Icons.fact_check_rounded, Color(0xFFFFF1D9)),
      _TileData('समस्याएँ', '1 नई', Icons.warning_amber_rounded, Color(0xFFFFE8E5)),
    ],
    sections: const [
      _SectionData('अगली साइट विजिट', 'दीवार की चिनाई • काशीपुर', '11:30 AM', Icons.construction_rounded),
      _SectionData('गुणवत्ता जाँच', 'सामग्री और काम की फोटो जाँचें', 'बाकी', Icons.verified_rounded),
      _SectionData('टीम उपस्थिति', 'आज की उपस्थिति की पुष्टि करें', 'खोलें', Icons.qr_code_scanner_rounded),
    ],
  );
}

class SupplierDashboard extends StatelessWidget {
  const SupplierDashboard({super.key});
  @override
  Widget build(BuildContext context) => _RolePage(
    eyebrow: 'MATERIAL MARKETPLACE',
    title: 'नमस्ते, सप्लायर 👋',
    subtitle: 'आपकी दुकान और ऑर्डर',
    accent: _violet,
    heroIcon: Icons.storefront_rounded,
    heroTitle: 'नए ग्राहक तक पहुँचें',
    heroSubtitle: 'अपना स्टॉक और दाम अपडेट रखें',
    primary: 'सामान जोड़ें',
    tiles: const [
      _TileData('नए ऑर्डर', '12', Icons.shopping_bag_rounded, Color(0xFFEDE7FF)),
      _TileData('स्टॉक', '48 आइटम', Icons.inventory_2_rounded, Color(0xFFE3F6ED)),
      _TileData('डिलीवरी', '4 बाकी', Icons.local_shipping_rounded, Color(0xFFFFF1D9)),
      _TileData('कमाई', 'डेमो', Icons.currency_rupee_rounded, Color(0xFFE7EEFF)),
    ],
    sections: const [
      _SectionData('सीमेंट', 'ACC / UltraTech • प्रति बैग', 'दाम जोड़ें', Icons.business_rounded),
      _SectionData('सरिया', 'ब्रांड, मोटाई और लंबाई', 'स्टॉक जोड़ें', Icons.stacked_bar_chart_rounded),
      _SectionData('ईंट और बालू', 'ग्रेड, मात्रा और डिलीवरी', 'लिस्ट करें', Icons.grain_rounded),
    ],
    promo: const _SponsoredBanner(
      title: 'अपनी दुकान को आगे बढ़ाएँ',
      subtitle: 'Sponsored ऑफर और लोकल ग्राहकों तक पहुँच',
      label: 'विज्ञापन',
      color: _violet,
      icon: Icons.campaign_rounded,
    ),
  );
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});
  @override
  Widget build(BuildContext context) => _RolePage(
    eyebrow: 'PLATFORM CONTROL',
    title: 'ARJUN Operations',
    subtitle: 'प्लेटफॉर्म की निगरानी',
    accent: const Color(0xFF263B67),
    heroIcon: Icons.admin_panel_settings_rounded,
    heroTitle: 'सभी सेवाएँ एक जगह',
    heroSubtitle: 'KYC, विवाद, विज्ञापन और भुगतान की समीक्षा',
    primary: 'Operations खोलें',
    tiles: const [
      _TileData('यूज़र', '12,540', Icons.people_alt_rounded, Color(0xFFE7EEFF)),
      _TileData('KYC बाकी', '38', Icons.verified_user_rounded, Color(0xFFFFF1D9)),
      _TileData('विवाद', '6', Icons.gavel_rounded, Color(0xFFFFE8E5)),
      _TileData('विज्ञापन', '12', Icons.campaign_rounded, Color(0xFFEDE7FF)),
    ],
    sections: const [
      _SectionData('KYC समीक्षा', 'नए worker और supplier आवेदन', 'खोलें', Icons.badge_rounded),
      _SectionData('विवाद डेस्क', 'सबूत और अपील की समीक्षा', 'खोलें', Icons.support_agent_rounded),
      _SectionData('विज्ञापन मॉडरेशन', 'क्रिएटिव और दावे की जाँच', 'खोलें', Icons.fact_check_rounded),
    ],
  );
}

class _RolePage extends StatelessWidget {
  const _RolePage({
    required this.eyebrow, required this.title, required this.subtitle,
    required this.accent, required this.heroIcon, required this.heroTitle,
    required this.heroSubtitle, required this.primary, required this.tiles,
    required this.sections, this.promo,
  });
  final String eyebrow, title, subtitle, heroTitle, heroSubtitle, primary;
  final Color accent;
  final IconData heroIcon;
  final List<_TileData> tiles;
  final List<_SectionData> sections;
  final Widget? promo;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: _paper,
    body: SafeArea(child: ListView(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 30),
      children: [
        Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(
            color: _forestDark, borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.engineering_rounded, color: _saffron, size: 27)),
          const SizedBox(width: 11),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('ARJUN', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.4, color: _forestDark, fontSize: 18)),
            Text('Rooted in Kashi', style: TextStyle(color: Colors.black54, fontSize: 11)),
          ])),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)),
        ]),
        const SizedBox(height: 22),
        Text(eyebrow, style: TextStyle(color: accent, fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.w900)),
        const SizedBox(height: 5),
        Text(title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: _forestDark)),
        Text(subtitle, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 18),
        Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(
          gradient: LinearGradient(colors: [accent, Color.lerp(accent, Colors.white, .22)!]),
          borderRadius: BorderRadius.circular(25)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(heroIcon, color: Colors.white, size: 34),
            const SizedBox(height: 14),
            Text(heroTitle, style: const TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w900)),
            const SizedBox(height: 4),
            Text(heroSubtitle, style: const TextStyle(color: Colors.white, fontSize: 12)),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('यह मॉड्यूल अभी demo है; server integration बाकी है.'))),
              style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: accent),
              child: Text(primary),
            ),
          ]),
        ),
        if (promo != null) ...[const SizedBox(height: 14), promo!],
        const SizedBox(height: 20),
        const Text('आज का सार', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: _forestDark)),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          itemCount: tiles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.7),
          itemBuilder: (context, index) {
            final item = tiles[index];
            return Container(padding: const EdgeInsets.all(13), decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(19)),
              child: Row(children: [
                Container(width: 42, height: 42, decoration: BoxDecoration(
                  color: item.color, borderRadius: BorderRadius.circular(14)),
                  child: Icon(item.icon, color: accent)),
                const SizedBox(width: 10),
                Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(item.value, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: _forestDark)),
                  Text(item.label, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: Colors.black54)),
                ])),
              ]),
            );
          },
        ),
        const SizedBox(height: 20),
        const Text('ज़रूरी काम', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: _forestDark)),
        const SizedBox(height: 8),
        ...sections.map((item) => Card(
          color: Colors.white, elevation: 0, margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: const Color(0xFFE7F4ED), child: Icon(item.icon, color: _forest)),
            title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w800)),
            subtitle: Text(item.subtitle),
            trailing: Text(item.action, style: TextStyle(color: accent, fontSize: 11, fontWeight: FontWeight.w800)),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('यह workflow अभी demo है.')),
            ),
          ),
        )),
      ],
    )),
  );
}

class _SponsoredBanner extends StatelessWidget {
  const _SponsoredBanner({required this.title, required this.subtitle, required this.label, required this.color, required this.icon});
  final String title, subtitle, label;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
    child: Row(children: [
      Icon(icon, color: Colors.white, size: 32),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label.toUpperCase(), style: const TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1)),
        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15)),
        Text(subtitle, style: const TextStyle(color: Colors.white, fontSize: 11)),
      ])),
    ]),
  );
}

class _TileData {
  const _TileData(this.label, this.value, this.icon, this.color);
  final String label, value;
  final IconData icon;
  final Color color;
}
class _SectionData {
  const _SectionData(this.title, this.subtitle, this.action, this.icon);
  final String title, subtitle, action;
  final IconData icon;
}
