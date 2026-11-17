import 'package:flutter/material.dart';

class SponsoredSupplierPlacement extends StatelessWidget {
  const SponsoredSupplierPlacement({super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(17),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF5C3BB7), Color(0xFF8A62E8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22),
    ),
    child: Row(children: [
      Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .16),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.storefront_rounded, color: Colors.white, size: 31),
      ),
      const SizedBox(width: 13),
      const Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('प्रायोजित • स्थानीय सप्लायर',
            style: TextStyle(color: Color(0xFFE8DEFF), fontSize: 10, fontWeight: FontWeight.w800)),
          SizedBox(height: 4),
          Text('निर्माण सामग्री सही दाम पर पाएँ',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
          SizedBox(height: 3),
          Text('सीमेंट • सरिया • ईंट • बालू',
            style: TextStyle(color: Colors.white, fontSize: 11)),
        ],
      )),
      const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 17),
    ]),
  );
}

class SponsoredServicePlacement extends StatelessWidget {
  const SponsoredServicePlacement({super.key});
  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    color: const Color(0xFFFFF2D9),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    child: const Padding(
      padding: EdgeInsets.all(14),
      child: Row(children: [
        CircleAvatar(
          backgroundColor: Color(0xFFFFD98E),
          child: Icon(Icons.campaign_rounded, color: Color(0xFF805000)),
        ),
        SizedBox(width: 12),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('विज्ञापन', style: TextStyle(color: Color(0xFF805000), fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1)),
            Text('अपने क्षेत्र की खास सर्विस ऑफर',
              style: TextStyle(color: Color(0xFF503400), fontWeight: FontWeight.w800)),
            Text('प्रायोजित सेवा • ऑफर की शर्तें देखें',
              style: TextStyle(color: Color(0xFF805000), fontSize: 10)),
          ],
        )),
        Icon(Icons.chevron_right_rounded, color: Color(0xFF805000)),
      ]),
    ),
  );
}
