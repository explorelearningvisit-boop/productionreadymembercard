import 'package:flutter/material.dart';

import 'design_system/app_tokens.dart';
import 'design_system/marketplace_components.dart';

class CustomerHomeContent extends StatelessWidget {
  const CustomerHomeContent({
    super.key,
    required this.onBrowse,
    required this.onCategorySelected,
    required this.onCreateBooking,
    required this.onWorkerSelected,
  });

  final VoidCallback onBrowse;
  final ValueChanged<String> onCategorySelected;
  final VoidCallback onCreateBooking;
  final ValueChanged<String> onWorkerSelected;

  static const _categories = <_ServiceCategory>[
    _ServiceCategory('निर्माण', Icons.construction, Color(0xFFFFE8C2)),
    _ServiceCategory('सफाई', Icons.cleaning_services, Color(0xFFDDF4E8)),
    _ServiceCategory('प्लंबर', Icons.plumbing, Color(0xFFDDEBFF)),
    _ServiceCategory('इलेक्ट्रिशियन', Icons.electrical_services, Color(0xFFFFF0C7)),
    _ServiceCategory('बढ़ई', Icons.carpenter, Color(0xFFF1E5FF)),
    _ServiceCategory('पेंटर', Icons.format_paint, Color(0xFFFFE2E8)),
    _ServiceCategory('लोडिंग', Icons.local_shipping, Color(0xFFE0F2FE)),
    _ServiceCategory('अन्य काम', Icons.grid_view, Color(0xFFECEFF4)),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey<String>('customer-home'),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Row(
          children: [
            const Icon(Icons.location_on_rounded, color: AppTokens.worker, size: 19),
            const SizedBox(width: 5),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('आपकी लोकेशन', style: TextStyle(color: AppTokens.muted, fontSize: 10)),
                  Text('वाराणसी, उत्तर प्रदेश', style: TextStyle(color: AppTokens.ink, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            IconButton(
              tooltip: 'सूचनाएँ',
              onPressed: () => _showMessage(context, 'सूचनाएँ', 'नई booking और worker updates यहाँ दिखेंगे।'),
              icon: const Icon(Icons.notifications_none_rounded),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text('नमस्ते! 👋', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: AppTokens.ink)),
        const Text('आज आपको किस काम के लिए labour चाहिए?', style: TextStyle(color: AppTokens.muted, fontSize: 13)),
        const SizedBox(height: 14),
        TextField(
          readOnly: true,
          onTap: onBrowse,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search_rounded),
            hintText: 'काम, हुनर या labour खोजें',
            suffixIcon: Icon(Icons.tune_rounded),
          ),
        ),
        const SizedBox(height: 18),
        _HiringBanner(onTap: onCreateBooking),
        const SizedBox(height: 22),
        MarketplaceSectionTitle('काम की कैटेगरी', action: 'सभी देखें', onAction: onBrowse),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 9,
            childAspectRatio: .91,
          ),
          itemBuilder: (context, index) {
            final item = _categories[index];
            return _CategoryTile(
              item: item,
              onTap: () => onCategorySelected(item.label),
            );
          },
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Expanded(child: MarketplaceSectionTitle('आपके पास उपलब्ध labour')),
            TextButton(onPressed: onBrowse, child: const Text('सभी देखें')),
          ],
        ),
        const SizedBox(height: 8),
        _WorkerCard(
          name: 'अर्जुन कुमार',
          skill: 'राजमिस्त्री • निर्माण',
          rating: '4.9 (126)',
          rate: '₹700 / दिन',
          distance: '1.2 km',
          onTap: () => onWorkerSelected('अर्जुन कुमार'),
        ),
        const SizedBox(height: 9),
        _WorkerCard(
          name: 'सुजीत यादव',
          skill: 'हेल्पर • लोडिंग',
          rating: '4.8 (98)',
          rate: '₹550 / दिन',
          distance: '1.8 km',
          onTap: () => onWorkerSelected('सुजीत यादव'),
        ),
        const SizedBox(height: 20),
        MarketplaceSectionTitle('काम कैसे करें?', action: 'बुक करें', onAction: onCreateBooking),
        const SizedBox(height: 10),
        const _TrustStrip(),
      ],
    );
  }

  static void _showMessage(BuildContext context, String title, String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('ठीक है')),
        ],
      ),
    );
  }
}

class _ServiceCategory {
  const _ServiceCategory(this.label, this.icon, this.tint);
  final String label;
  final IconData icon;
  final Color tint;
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.item, required this.onTap});
  final _ServiceCategory item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(17),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(color: item.tint, borderRadius: BorderRadius.circular(14)),
                  child: Icon(item.icon, color: AppTokens.ink, size: 23),
                ),
                const SizedBox(height: 6),
                Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: AppTokens.ink),
                ),
              ],
            ),
          ),
        ),
      );
}

class _HiringBanner extends StatelessWidget {
  const _HiringBanner({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: AppTokens.providerDeep,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF5420A6), Color(0xFF7A42D5), Color(0xFF087F5B)],
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('प्रोजेक्ट के लिए manpower चाहिए?',
                          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900)),
                      SizedBox(height: 5),
                      Text('एक साथ कई verified workers बुक करें',
                          style: TextStyle(color: Colors.white, fontSize: 11.5, height: 1.35)),
                      SizedBox(height: 12),
                      _BannerActionLabel(),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.engineering, color: Colors.white, size: 68),
              ],
            ),
          ),
        ),
      );
}

class _BannerActionLabel extends StatelessWidget {
  const _BannerActionLabel();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: const Text('अभी बुक करें  →',
            style: TextStyle(color: AppTokens.providerDeep, fontSize: 11, fontWeight: FontWeight.w900)),
      );
}

class _WorkerCard extends StatelessWidget {
  const _WorkerCard({
    required this.name,
    required this.skill,
    required this.rating,
    required this.rate,
    required this.distance,
    required this.onTap,
  });
  final String name, skill, rating, rate, distance;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppTokens.workerSoft,
                child: const Icon(Icons.person_rounded, color: AppTokens.workerDeep, size: 29),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.w900, color: AppTokens.ink)),
                    Text(skill, style: const TextStyle(fontSize: 11, color: AppTokens.muted)),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Color(0xFFFFB52E), size: 14),
                        Text(' $rating  •  $distance', style: const TextStyle(fontSize: 10, color: AppTokens.muted)),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(rate, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: AppTokens.workerDeep)),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 34,
                    child: FilledButton(
                      onPressed: onTap,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTokens.worker,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        minimumSize: const Size(0, 34),
                      ),
                      child: const Text('देखें', style: TextStyle(fontSize: 11)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

class _TrustStrip extends StatelessWidget {
  const _TrustStrip();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(color: AppTokens.workerSoft, borderRadius: BorderRadius.circular(17)),
        child: const Row(
          children: [
            Expanded(child: _TrustItem(icon: Icons.verified_user_outlined, label: 'Verified')),
            Expanded(child: _TrustItem(icon: Icons.bolt_rounded, label: 'Fast booking')),
            Expanded(child: _TrustItem(icon: Icons.lock_outline_rounded, label: 'Secure pay')),
          ],
        ),
      );
}

class _TrustItem extends StatelessWidget {
  const _TrustItem({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Icon(icon, color: AppTokens.workerDeep, size: 20),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: AppTokens.workerDeep)),
        ],
      );
}
