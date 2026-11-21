import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/member_theme.dart';
class PurpleMemberDashboard extends StatefulWidget{
 const PurpleMemberDashboard({super.key});
 @override State<PurpleMemberDashboard> createState()=>_DashboardState();
}
class _DashboardState extends State<PurpleMemberDashboard>{
 int selected=0;
 Widget _ic(String n,{double size=24})=>Image.asset('assets/images/individual/$n.png',
  width:size,height:size,fit:BoxFit.contain,errorBuilder:(_,__,___)=>SizedBox(width:size,height:size));
 Widget _card(Widget child)=>Container(padding:const EdgeInsets.all(12),
  decoration:BoxDecoration(color:Colors.white.withValues(alpha:.95),
   borderRadius:BorderRadius.circular(19),border:Border.all(color:MemberTheme.line),
   boxShadow:[BoxShadow(color:MemberTheme.purple.withValues(alpha:.08),blurRadius:12)]),child:child);
 Widget _metric(String i,String t,String v,Color c)=>Expanded(child:_card(Column(children:[
  _ic(i,size:24),Text(t,style:const TextStyle(fontSize:10,color:MemberTheme.muted)),
  Text(v,style:TextStyle(fontSize:12,fontWeight:FontWeight.w900,color:c))])));
 @override Widget build(BuildContext context){
  final compact=MediaQuery.sizeOf(context).width<370;
  const rail=['icon_home','icon_calendar','icon_dumbbell','icon_wallet','icon_tag','icon_clock'];
  return SingleChildScrollView(padding:EdgeInsets.all(compact?9:14),child:Center(
   child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:520),child:Column(
    crossAxisAlignment:CrossAxisAlignment.stretch,children:[
     Row(children:[_ic('icon_dumbbell',size:30),const SizedBox(width:8),
      const Expanded(child:Text('BAD GYM',style:TextStyle(fontSize:22,fontWeight:FontWeight.w900,color:MemberTheme.ink))),
      _ic('icon_bell',size:24)]),
     const SizedBox(height:9),
     _card(Row(children:[_ic('icon_shield',size:24),const SizedBox(width:7),
      const Expanded(child:Text('CHECK-IN\nCompleted · 07:12 AM',style:TextStyle(fontWeight:FontWeight.w800))),
      _ic('icon_snowflake',size:24),const Text(' FREEZE',style:TextStyle(fontWeight:FontWeight.w900))])),
     const SizedBox(height:9),
     _card(Row(children:[Container(width:76,height:88,decoration:BoxDecoration(
      gradient:const LinearGradient(colors:[MemberTheme.violet,MemberTheme.purple]),
      borderRadius:BorderRadius.circular(16)),child:Center(child:_ic('icon_person',size:54))),
      const SizedBox(width:10),const Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
       Text('Welcome Back 👋',style:TextStyle(color:MemberTheme.purple,fontSize:12)),
       Text('Member Name',style:TextStyle(fontSize:18,fontWeight:FontWeight.w900,color:MemberTheme.ink)),
       Text('BG215 · 28 Yrs · Male',style:TextStyle(fontSize:11,color:MemberTheme.muted)),
       SizedBox(height:7),Text('Gold Plan   ·   Active',style:TextStyle(fontWeight:FontWeight.w900,fontSize:11))
      ]))])),
     const SizedBox(height:9),
     _card(Row(children:[_ic('icon_wallet',size:26),const SizedBox(width:6),
      const Expanded(child:Text('Payment\n₹500 Due',style:TextStyle(fontWeight:FontWeight.w900,color:MemberTheme.red))),
      _ic('icon_calendar',size:26),const SizedBox(width:6),
      const Expanded(child:Text('Membership\n8 Days Left',style:TextStyle(fontWeight:FontWeight.w900,color:MemberTheme.purple))),
      QrImageView(data:'BADGYM-BG215',size:40,padding:EdgeInsets.zero)])),
     const SizedBox(height:7),
     const Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
      Text('Membership 22 / 30 Days',style:TextStyle(fontSize:12,fontWeight:FontWeight.w800)),Text('73%',style:TextStyle(fontWeight:FontWeight.w900))]),
     const SizedBox(height:5),ClipRRect(borderRadius:BorderRadius.circular(20),
      child:const LinearProgressIndicator(value:.73,minHeight:9,color:MemberTheme.violet,backgroundColor:MemberTheme.line)),
     const SizedBox(height:9),
     _card(Row(children:[_ic('icon_tag',size:30),const SizedBox(width:8),
      const Expanded(child:Text('BIG BILLION SALE\nUp to 40% OFF · Fitness Gear',style:TextStyle(fontWeight:FontWeight.w900,color:MemberTheme.purple))),
      _ic('equip_dumbbell_purple_sm',size:40)])),
     const SizedBox(height:9),
     Row(children:[_metric('icon_calendar','Attendance','81%',MemberTheme.green),const SizedBox(width:5),
      _metric('icon_dumbbell','Workout','58 min',MemberTheme.purple),const SizedBox(width:5),
      _metric('icon_wallet','Payment','₹500 Due',MemberTheme.red),const SizedBox(width:5),
      _metric('icon_chart','Body','69.5 kg',MemberTheme.ink)]),
     const SizedBox(height:9),
     _card(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Row(children:[_ic('icon_chart',size:24),const SizedBox(width:6),
       const Expanded(child:Text('Attendance Intelligence',style:TextStyle(fontSize:15,fontWeight:FontWeight.w900,color:MemberTheme.ink))),
       const Text('● LIVE',style:TextStyle(color:MemberTheme.red,fontWeight:FontWeight.w900,fontSize:10))]),
      const SizedBox(height:9),Row(children:[
       Container(width:43,padding:const EdgeInsets.symmetric(vertical:8),
        decoration:BoxDecoration(gradient:const LinearGradient(colors:[MemberTheme.violet,MemberTheme.ink],begin:Alignment.topCenter,end:Alignment.bottomCenter),borderRadius:BorderRadius.circular(14)),
        child:Column(children:List.generate(rail.length,(i)=>InkWell(onTap:()=>setState(()=>selected=i),
         child:Padding(padding:const EdgeInsets.symmetric(vertical:6),child:Opacity(opacity:selected==i?1:.55,child:_ic(rail[i],size:22))))))),
       const SizedBox(width:9),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        const Text('Home overview',style:TextStyle(fontWeight:FontWeight.w900,color:MemberTheme.purple)),
        const Text('Check-in complete · 07:12 AM',style:TextStyle(fontSize:10,color:MemberTheme.muted)),
        const SizedBox(height:8),Row(children:[
         SizedBox(width:76,height:76,child:Stack(alignment:Alignment.center,children:[
          const CircularProgressIndicator(value:.81,strokeWidth:8,color:MemberTheme.green,backgroundColor:MemberTheme.line),
          const Column(mainAxisSize:MainAxisSize.min,children:[Text('81%',style:TextStyle(fontWeight:FontWeight.w900,fontSize:20)),Text('25/31',style:TextStyle(fontSize:9))])])),
         const SizedBox(width:8),const Expanded(child:Column(children:[
          _Legend(color:MemberTheme.green,label:'Present',value:'25 · 81%'),
          _Legend(color:MemberTheme.red,label:'Absent',value:'2 · 6%'),
          _Legend(color:MemberTheme.violet,label:'Holiday',value:'4 · 13%'),
          _Legend(color:MemberTheme.gold,label:'Payment',value:'1/1 · 100%')]))])]))]),
      const Divider(height:18),Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[
       _stat('icon_fire','5d','Streak'),_stat('icon_trophy','14d','Goal'),_stat('icon_chart','+6%','Trend')])
     ])),
     const SizedBox(height:8),Row(mainAxisAlignment:MainAxisAlignment.center,children:[
      _ic('plant_potted_1',size:38),_ic('equip_kettlebell_black',size:34),
      _ic('acc_shaker_purple',size:28),_ic('acc_towel_rolled',size:36),_ic('plant_monstera',size:38)])
   ]))));
 }
 Widget _stat(String i,String v,String l)=>Row(children:[_ic(i,size:21),const SizedBox(width:4),
  Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(v,style:const TextStyle(fontWeight:FontWeight.w900)),
   Text(l,style:const TextStyle(fontSize:9,color:MemberTheme.muted))])]);
}
class _Legend extends StatelessWidget{
 const _Legend({required this.color,required this.label,required this.value});
 final Color color;final String label;final String value;
 @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.symmetric(vertical:2),
  child:Row(children:[Container(width:8,height:8,decoration:BoxDecoration(color:color,shape:BoxShape.circle)),
   const SizedBox(width:5),Expanded(child:Text(label,style:const TextStyle(fontSize:10,fontWeight:FontWeight.w700))),
   Text(value,style:const TextStyle(fontSize:9,fontWeight:FontWeight.w900))]));
}
