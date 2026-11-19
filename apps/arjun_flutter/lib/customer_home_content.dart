import 'package:flutter/material.dart';

import 'design_system/app_tokens.dart';

class CustomerHomeContent extends StatefulWidget {
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

  @override
  State<CustomerHomeContent> createState() => _CustomerHomeContentState();
}

class _CustomerHomeContentState extends State<CustomerHomeContent> {
  String hiringMode = 'Hourly';
  static const purple = Color(0xFF5B16B8);
  static const deepPurple = Color(0xFF351078);
  static const lavender = Color(0xFFF5F0FF);
  static const green = Color(0xFF17B83E);
  static const yellow = Color(0xFFFFD21C);

  static const categories = <_Category>[
    _Category('निर्माण', 'मिस्त्री/मज़दूर', Icons.foundation_rounded, Color(0xFFFFE2C7)),
    _Category('सफाई', 'हाउसकीपिंग', Icons.cleaning_services_rounded, Color(0xFFE7F5E9)),
    _Category('प्लंबर', 'पाइप/फिटिंग', Icons.plumbing_rounded, Color(0xFFFFE4DF)),
    _Category('इलेक्ट्रिशियन', 'वायरिंग', Icons.lightbulb_rounded, Color(0xFFFFF4C9)),
    _Category('बढ़ई', 'कारपेंटर', Icons.handyman_rounded, Color(0xFFFFE8D2)),
    _Category('पेंटर', 'रंगाई/पुताई', Icons.format_paint_rounded, Color(0xFFFCE1F7)),
    _Category('ड्राइवर', 'वाहन चालक', Icons.directions_car_filled_rounded, Color(0xFFE7ECF5)),
    _Category('लोडिंग', 'माल उठाई', Icons.local_shipping_rounded, Color(0xFFFFEBC9)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lavender,
      child: ListView(
        key: const PageStorageKey<String>('customer-home'),
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 22),
        children: [
          Row(children: [
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () => _message('KaamVerse मेनू', 'होम • बुकिंग • पेमेंट • सहायता • प्रोफाइल'),
              icon: const Icon(Icons.menu_rounded, color: deepPurple, size: 27),
            ),
            const Expanded(child: Text('KaamVerse', style: TextStyle(
              color: deepPurple, fontSize: 23, fontWeight: FontWeight.w900, letterSpacing: -.6))),
            IconButton(
              onPressed: () => _message('सूचनाएँ', 'आपकी booking और worker updates यहाँ दिखेंगे।'),
              icon: const Icon(Icons.notifications_active_outlined, color: deepPurple, size: 25),
            ),
          ]),
          InkWell(
            onTap: () => _message('लोकेशन चुनें', 'अभी चुनी गई लोकेशन: वाराणसी (काशी), उत्तर प्रदेश'),
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(children: const [
                Icon(Icons.location_on_rounded, color: purple, size: 22),
                SizedBox(width: 6),
                Expanded(child: Text('वाराणसी (काशी), उत्तर प्रदेश',
                  style: TextStyle(color: deepPurple, fontWeight: FontWeight.w800, fontSize: 13))),
                Icon(Icons.keyboard_arrow_down_rounded, color: deepPurple),
              ]),
            ),
          ),
          const SizedBox(height: 9),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('नमस्ते, Riya Sharma 👋', style: TextStyle(
                color: Color(0xFF1E1530), fontSize: 19, fontWeight: FontWeight.w900)),
              SizedBox(height: 3),
              Text('आपको किस काम के लिए मदद चाहिए?',
                style: TextStyle(color: Color(0xFF514766), fontSize: 12, fontWeight: FontWeight.w600)),
            ])),
            Container(
              width: 62, height: 62,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Color(0xFFE5D1FF), Color(0xFFFDF9FF)])),
              child: const Icon(Icons.face_3_rounded, color: purple, size: 42),
            ),
          ]),
          const SizedBox(height: 12),
          Material(
            color: Colors.white,
            elevation: 2,
            shadowColor: const Color(0x335B16B8),
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              onTap: widget.onBrowse,
              borderRadius: BorderRadius.circular(18),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                child: Row(children: [
                  Icon(Icons.search_rounded, color: purple, size: 26),
                  SizedBox(width: 10),
                  Expanded(child: Text('सेवा या मज़दूर खोजें...',
                    style: TextStyle(color: Color(0xFF746B83), fontWeight: FontWeight.w600))),
                  Icon(Icons.mic_rounded, color: purple, size: 24),
                ]),
              ),
            ),
          ),
          const SizedBox(height: 14),
          _HiringBanner(onTap: widget.onCreateBooking),
          const SizedBox(height: 18),
          _SectionTitle(title: 'सेवा श्रेणियाँ', action: 'सभी देखें', onTap: widget.onBrowse),
          const SizedBox(height: 9),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 8, crossAxisSpacing: 8,
              childAspectRatio: .84,
            ),
            itemBuilder: (context, index) {
              final item = categories[index];
              return _CategoryTile(item: item, onTap: () => widget.onCategorySelected(item.label));
            },
          ),
          const SizedBox(height: 17),
          const Text('हायरिंग का तरीका चुनें', style: TextStyle(
            color: Color(0xFF21133D), fontSize: 17, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Row(children: [
            _ModeChip(label: 'घंटे के हिसाब से', sub: 'Hourly', icon: Icons.access_time_rounded,
              selected: hiringMode == 'Hourly', onTap: () => setState(() => hiringMode = 'Hourly')),
            const SizedBox(width: 6),
            _ModeChip(label: 'दैनिक', sub: 'Daily', icon: Icons.calendar_month_rounded,
              selected: hiringMode == 'Daily', onTap: () => setState(() => hiringMode = 'Daily')),
            const SizedBox(width: 6),
            _ModeChip(label: 'प्रोजेक्ट/ठेका', sub: 'Project', icon: Icons.work_outline_rounded,
              selected: hiringMode == 'Project', onTap: () => setState(() => hiringMode = 'Project')),
          ]),
          const SizedBox(height: 17),
          _SectionTitle(title: 'आपके नज़दीक उपलब्ध मज़दूर', action: 'सभी देखें', onTap: widget.onBrowse),
          const SizedBox(height: 8),
          _WorkerCard(name: 'अरुण कुमार', skill: 'मिस्त्री • 5 साल अनुभव',
            rating: '4.9 (126 रिव्यू)', rate: hiringMode == 'Hourly' ? '₹120 / घंटा' :
              hiringMode == 'Daily' ? '₹700 / दिन' : 'रेट पूछें',
            distance: '1.2 किमी', onTap: () => widget.onWorkerSelected('अरुण कुमार')),
          const SizedBox(height: 8),
          _WorkerCard(name: 'सुजीत यादव', skill: 'हेल्पर • 4 साल अनुभव',
            rating: '4.8 (98 रिव्यू)', rate: hiringMode == 'Hourly' ? '₹95 / घंटा' :
              hiringMode == 'Daily' ? '₹550 / दिन' : 'रेट पूछें',
            distance: '1.8 किमी', onTap: () => widget.onWorkerSelected('सुजीत यादव')),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [deepPurple, purple]),
              borderRadius: BorderRadius.circular(17)),
            child: Row(children: const [
              Icon(Icons.verified_user_rounded, color: Colors.white, size: 25),
              SizedBox(width: 9),
              Expanded(child: Text('सुरक्षित बुकिंग • सत्यापित प्रोफाइल • स्पष्ट रेट',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11))),
            ]),
          ),
        ],
      ),
    );
  }

  void _message(String title, String body) {
    showDialog<void>(context: context, builder: (context) => AlertDialog(
      title: Text(title), content: Text(body),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('ठीक है'))],
    ));
  }
}

class _Category {
  const _Category(this.label, this.subtitle, this.icon, this.tint);
  final String label, subtitle;
  final IconData icon;
  final Color tint;
}

class _HiringBanner extends StatelessWidget {
  const _HiringBanner({required this.onTap});
  final VoidCallback onTap;
  static const purple = Color(0xFF5B16B8);
  static const yellow = Color(0xFFFFD21C);

  @override
  Widget build(BuildContext context) => Material(
    borderRadius: BorderRadius.circular(20),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 10, 13),
        decoration: const BoxDecoration(gradient: LinearGradient(
          begin: Alignment.centerLeft, end: Alignment.centerRight,
          colors: [Color(0xFF48119A), Color(0xFF812DD0), Color(0xFFB36BEA)])),
        child: Row(children: [
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('आवश्यक है मज़दूर?', style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
            SizedBox(height: 5),
            Text('अभी काम पोस्ट करें और अपने नज़दीक के सत्यापित मज़दूरों से जुड़ें।',
              style: TextStyle(color: Colors.white, fontSize: 12, height: 1.3)),
            SizedBox(height: 10),
            _BannerButton(),
          ])),
          const SizedBox(width: 4),
          const Icon(Icons.engineering_rounded, color: Color(0xFFFFD45C), size: 78),
        ]),
      ),
    ),
  );
}

class _BannerButton extends StatelessWidget {
  const _BannerButton();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
    decoration: BoxDecoration(color: const Color(0xFFFFD21C), borderRadius: BorderRadius.circular(30)),
    child: const Text('काम पोस्ट करें  →', style: TextStyle(
      color: Color(0xFF29164A), fontSize: 12, fontWeight: FontWeight.w900)),
  );
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.item, required this.onTap});
  final _Category item;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    elevation: 2,
    shadowColor: const Color(0x225B16B8),
    borderRadius: BorderRadius.circular(15),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 7),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 43, height: 43,
            decoration: BoxDecoration(color: item.tint, borderRadius: BorderRadius.circular(13)),
            child: Icon(item.icon, size: 28, color: const Color(0xFF48246F)),
          ),
          const SizedBox(height: 5),
          Text(item.label, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFF21133D), fontSize: 10.5, fontWeight: FontWeight.w900)),
          Text(item.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFF71677F), fontSize: 8)),
        ]),
      ),
    ),
  );
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({required this.label, required this.sub, required this.icon,
    required this.selected, required this.onTap});
  final String label, sub;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Expanded(child: Material(
    color: selected ? const Color(0xFFE9D9FF) : Colors.white,
    borderRadius: BorderRadius.circular(13),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        constraints: const BoxConstraints(minHeight: 62),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: selected ? const Color(0xFF9D61E5) : const Color(0xFFE6DDF2))),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 20, color: selected ? const Color(0xFF7A25CE) : const Color(0xFF514766)),
          Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF21133D))),
          Text('($sub)', style: const TextStyle(fontSize: 8, color: Color(0xFF71677F))),
        ]),
      ),
    ),
  ));
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.action, required this.onTap});
  final String title, action;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Row(children: [
    Expanded(child: Text(title, style: const TextStyle(
      color: Color(0xFF21133D), fontSize: 16, fontWeight: FontWeight.w900))),
    TextButton(onPressed: onTap, child: Text(action,
      style: const TextStyle(color: Color(0xFF5B16B8), fontWeight: FontWeight.w900, fontSize: 11))),
  ]);
}

class _WorkerCard extends StatelessWidget {
  const _WorkerCard({required this.name, required this.skill, required this.rating,
    required this.rate, required this.distance, required this.onTap});
  final String name, skill, rating, rate, distance;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    elevation: 2,
    shadowColor: const Color(0x225B16B8),
    borderRadius: BorderRadius.circular(17),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        Container(width: 58, height: 62,
          decoration: BoxDecoration(color: const Color(0xFFFFE8D9), borderRadius: BorderRadius.circular(13)),
          child: const Icon(Icons.engineering_rounded, color: Color(0xFF9C4A18), size: 42)),
        const SizedBox(width: 9),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Flexible(child: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF21133D), fontSize: 13))),
            const SizedBox(width: 3),
            const Icon(Icons.verified_rounded, color: Color(0xFF17B83E), size: 15),
          ]),
          Row(children: [
            const Icon(Icons.star_rounded, color: Color(0xFFFFC400), size: 14),
            Text(' $rating', style: const TextStyle(fontSize: 9, color: Color(0xFF625A6D))),
          ]),
          Text(skill, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 9, color: Color(0xFF625A6D))),
        ])),
        const SizedBox(width: 5),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(rate, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFF21133D))),
          Row(children: [
            const Icon(Icons.location_on_rounded, size: 12, color: Color(0xFF625A6D)),
            Text(distance, style: const TextStyle(fontSize: 9, color: Color(0xFF625A6D))),
          ]),
          const SizedBox(height: 4),
          SizedBox(height: 29, child: FilledButton(
            onPressed: onTap,
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF17B83E), foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 13), minimumSize: const Size(0, 29)),
            child: const Text('बुक करें', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900)),
          )),
        ]),
      ]),
    ),
  );
}
