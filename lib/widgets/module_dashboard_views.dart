import 'package:flutter/material.dart';

import '../data/dashboard_navigation.dart';
import '../data/sample_member.dart';
import '../theme/member_theme.dart';
import 'member_charts.dart';

/// A dedicated compact intelligence surface for every contextual rail item.
class ModuleDashboardView extends StatelessWidget {
  const ModuleDashboardView({
    required this.module,
    required this.sectionIndex,
    required this.compact,
    required this.palette,
    required this.member,
    super.key,
  });

  final DashboardModule module;
  final int sectionIndex;
  final bool compact;
  final MemberPlanPalette palette;
  final MemberSample member;

  double get gap => compact ? 4 : 6;

  @override
  Widget build(BuildContext context) => switch (module) {
    DashboardModule.attendance => _attendance(),
    DashboardModule.workout => _workout(),
    DashboardModule.payment => _payment(),
    DashboardModule.body => _body(),
  };

  Widget _attendance() => switch (sectionIndex) {
    1 => _page([
      _stats('Attendance', member.attendance, 'Streak', 'Preview', MemberTheme.green, MemberTheme.amber),
      _line('WEEKLY ACTIVITY', 'Check-in distribution · illustrative sample', const [[42,58,51,72,63,84,76]], [MemberTheme.green]),
      _note('Weekly visit score', 'Dated check-in history is required for personal insights', Icons.insights_rounded),
    ]),
    2 => _calendar(),
    3 => _page([
      _stats('Attendance', member.attendance, 'Check-in', 'Preview', MemberTheme.green, palette.accent),
      _history('Gym check-in', [
        ['Latest visit', 'Demo event · server history not connected', 'Preview'],
        ['Previous visits', 'Dated attendance log not available', '—'],
        ['Check-in time', 'Waiting for the attendance service', '—'],
      ]),
      _note('Verified visit records', 'Only dated, server-confirmed visits can appear here', Icons.history_rounded),
    ]),
    4 => _page([
      _stats('Attendance average', member.attendance, 'Next goal', '90%', MemberTheme.green, palette.accent),
      _line('Attendance trend', '12-month illustrative trend · not member history', const [[61,68,74,70,58,81,76,86,78,83,75,81]], [palette.accent]),
      _stats('Best month', '—', 'Tracked months', '0 / 12', MemberTheme.amber, palette.accent),
      _note('Attendance trend is not connected', 'Dated monthly check-ins are required for an accurate trend', Icons.show_chart_rounded),
    ]),
    5 => _page([
      _goal('Monthly attendance target', 'Goal: 24 visits · sample', 0.81, MemberTheme.green),
      _goal('Attendance consistency', 'Suggested target: 90%', 0.81, palette.accent),
      _goal('Weekly routine', 'Suggested target: 5 visits', 0.72, MemberTheme.amber),
      _line('Monthly attendance', 'Illustrative goal progress', const [[35,42,48,61,66,72,81]], [MemberTheme.green]),
      _note('Personal attendance targets', 'Targets stay previews until a member goal is saved', Icons.flag_rounded),
    ]),
    _ => const SizedBox.shrink(),
  };

  Widget _calendar() {
    const days = <int>[0,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,0,0];
    const state = <int,int>{1:1,2:1,3:1,4:0,5:1,6:1,7:1,8:1,9:1,10:1,11:0,12:1,13:1,14:1,15:1,16:1,17:2,18:0,19:1,20:1,21:1,22:1,23:1,24:2,25:0,26:1,27:1,28:1,29:1,30:1,31:1};
    const colors = <int,Color>{0:Color(0xFFE7E2ED),1:Color(0xFFD6F5E0),2:Color(0xFFFFE0E6)};
    return Column(children: [
      Row(children: [
        const Expanded(child: Text('October 2026', style: TextStyle(color: MemberTheme.ink,fontSize:12,fontWeight:FontWeight.w900))),
        _legend(MemberTheme.green,'Present'),_legend(MemberTheme.rose,'Absent'),_legend(MemberTheme.amber,'Late'),
      ]),
      SizedBox(height: gap),
      const Row(children: [_Tick('Mon'),_Tick('Tue'),_Tick('Wed'),_Tick('Thu'),_Tick('Fri'),_Tick('Sat'),_Tick('Sun')]),
      Expanded(child: Column(children: [
        for (var w=0; w<5; w++) Expanded(child: Row(children: [
          for (var d=0; d<7; d++) Expanded(child: Builder(builder: (context) {
            final day = days[w*7+d];
            return Container(
              margin: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                color: day == 0 ? Colors.transparent : colors[state[day] ?? 0],
                borderRadius: BorderRadius.circular(8),
                border: day == 16 ? Border.all(color: MemberTheme.purple,width:2) : Border.all(color: Colors.white.withOpacity(0.85)),
              ),
              child: Center(child: Text(day == 0 ? '' : day.toString(),
                style: const TextStyle(color:MemberTheme.ink,fontSize:9,fontWeight:FontWeight.w900))),
            );
          })),
        ])),
      ])),
      _note('Attendance Calendar','Sample day states · live dates require the attendance service',Icons.calendar_month_rounded),
    ]);
  }

  Widget _workout() => switch (sectionIndex) {
    0 => _page([
      _stats('Workout average', member.workout, 'Weekly sessions', 'Not linked', palette.accent, MemberTheme.green),
      _stats('Best session', 'Not linked', 'Consistency', 'Not linked', MemberTheme.amber, palette.accent),
      _bar('Daily Workout Trend', 'Illustrative minutes · waiting for dated sessions', const [32,48,26,64,42,76,58], palette.accent, 90),
      _note('Session data preview','Session statistics are preview cards until workout tracking is connected',Icons.fitness_center_rounded),
    ]),
    1 => _page([
      _stats('Average duration', member.workout, 'Consistency', 'Not linked', palette.accent, MemberTheme.green),
      _line('Training load','Training load · illustrative chart',const [[26,42,35,61,48,78,58]],[palette.accent]),
      _note('Workout insights not connected','Personal insights need session history, exercise sets and recovery records',Icons.insights_rounded),
    ]),
    2 => _page([
      _stats('Latest workout summary', member.workout, 'Exercise sets', 'Not linked', palette.accent, MemberTheme.green),
      _history('Session record detail',[
        ['Exercises and sets','Reps and weights not connected','—'],
        ['Session duration','Current member sample only',member.workout],
        ['Workout date','Session date not available','—'],
      ]),
      _note('Workout log','No workout dates or exercise sets are fabricated in this preview',Icons.receipt_long_rounded),
    ]),
    3 => _page([
      _stats('Current duration',member.workout,'Monthly sessions','Not linked',palette.accent,MemberTheme.green),
      _bar('WORKOUT MINUTES • LAST 7 DAYS','Illustrative weekly load',const [32,48,26,64,42,76,58],palette.accent,90),
      _stats('Active days','—','Goal days','—',MemberTheme.green,MemberTheme.amber),
    ]),
    4 => _page([
      _stats('Sleep duration','Not linked','Hydration','Not linked',const Color(0xFF6C5BA7),const Color(0xFF278FC2)),
      _goal('Sleep target','Requires sleep tracking',0,const Color(0xFF6C5BA7)),
      _goal('Hydration target','Requires water log',0,const Color(0xFF278FC2)),
      _goal('Rest and mobility','Requires recovery plan',0,MemberTheme.green),
      _note('Recovery products','Supplement creative preview · Demo',Icons.spa_rounded),
    ]),
    5 => _page([
      _goal('Workout consistency','Target: 4 sessions · suggested',0.72,palette.accent),
      _goal('Session completion','Workout plan needed',0,MemberTheme.green),
      _goal('Recovery routine','Recovery plan needed',0,MemberTheme.amber),
      _line('Weekly goal trend','Illustrative goal progress',const [[32,42,48,57,62,69,72]],[palette.accent]),
      _note('Training goals','A coach-defined workout plan is needed for personal goals',Icons.flag_rounded),
    ]),
    _ => const SizedBox.shrink(),
  };

  Widget _payment() => switch (sectionIndex) {
    0 => _page([
      _stats('Payment due',member.paymentDue,'Days remaining',member.daysRemaining.toString(),MemberTheme.rose,palette.accent),
      _statusCard(),
      _goal('Membership period used','${member.membershipDays} / ${member.membershipTotalDays} days',member.membershipProgress.clamp(0.0,1.0).toDouble(),MemberTheme.green),
      
      _note('Balance and renewal','Transactions and receipts require a connected gym billing service',Icons.account_balance_wallet_rounded),
    ]),
    1 => _page([
      _stats('Payment due',member.paymentDue,'Renewal in','${member.daysRemaining} days',MemberTheme.rose,palette.accent),
      Expanded(child: GlassChartFrame(title:'Payment behaviour',subtitle:'Illustrative distribution · replace with ledger data',
        child: Row(children:[
          SizedBox(width:compact?82:100,child:const GlassDonutChart(values:[64,22,14],colors:[MemberTheme.green,Color(0xFF3298D4),MemberTheme.amber],centerValue:'Demo',centerLabel:'behaviour')),
          const SizedBox(width:5),
          const Expanded(child:Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.start,children:[
            _LegendRow(color:MemberTheme.green,label:'On time',value:'Demo'),
            _LegendRow(color:Color(0xFF3298D4),label:'Early',value:'Demo'),
            _LegendRow(color:MemberTheme.amber,label:'Late',value:'Demo'),
          ])),
        ]))),
      _note('Payment insights not connected','Dated transactions are required to calculate payment reliability',Icons.insights_rounded),
    ]),
    2 => _page([
      _stats('Balance due',member.paymentDue,'Renewal countdown','${member.daysRemaining} days',MemberTheme.rose,palette.accent),
      _history('Membership balance',[
        ['Invoice number','Generated after billing integration','—'],
        ['Membership period','${member.membershipDays} / ${member.membershipTotalDays} days used','${(member.membershipProgress*100).round()}%'],
        ['Download receipt','PDF receipt service not connected','Unavailable'],
      ]),
      _note('Invoice preview','No invoice ID or payment receipt is fabricated',Icons.description_rounded),
    ]),
    3 => _page([
      _stats('Outstanding membership amount',member.paymentDue,'Settled payments','Not linked',MemberTheme.rose,MemberTheme.green),
      _history('Transaction timeline',[
        ['Latest payment','No settled transaction returned','—'],
        ['Previous receipts','No payment records loaded','—'],
        ['Payment confirmation','Server verification not available','—'],
      ]),
      _note('Payment history','Only the current sample balance is displayed until transactions sync',Icons.history_rounded),
    ]),
    4 => _page([
      Expanded(child:Center(child:Image.asset('assets/material_pack/inbox/PulseVault/29_sbi_payment_card_graphic.webp',fit:BoxFit.contain,width:compact?130:180))),
      _stats('UPI','Not saved','Card','Not saved',palette.accent,const Color(0xFF328BC0)),
      _note('Payment method preview','No payment credentials are stored in this demo dashboard',Icons.security_rounded),
    ]),
    5 => _page([
      _assetBanner('29_sbi_payment_card_graphic.webp','Member reward preview','Campaign creative only · Demo',const Color(0xFFEFE4FF)),
      _stats('Reward points','Not linked','Cashback','Not linked',MemberTheme.amber,MemberTheme.green),
      const Spacer(),
      _note('Rewards not connected','Reward eligibility and balances require a configured campaign service',Icons.card_giftcard_rounded),
    ]),
    _ => const SizedBox.shrink(),
  };

  Widget _body() => switch (sectionIndex) {
    0 => _page([
      _stats('Current weight',member.bodyWeight,'Target weight','Not set',MemberTheme.green,palette.accent),
      Expanded(child:GlassChartFrame(title:'Transformation Goal',subtitle:'Body-composition breakdown needs dated measurements',
        child:Row(children:[
          Expanded(child:Center(child:Image.asset('assets/material_pack/inbox/PulseVault/01_member_bodybuilder.webp',fit:BoxFit.contain,width:compact?82:105))),
          SizedBox(width:compact?80:100,child:GlassDonutChart(values:const [1.0],colors:const [MemberTheme.green],centerValue:'69.5',centerLabel:'kg now')),
          const SizedBox(width:4),
          const Expanded(child:Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.start,children:[
            _LegendRow(color:MemberTheme.green,label:'Current weight',value:'Member data'),
            _LegendRow(color:MemberTheme.lavender,label:'Goal target',value:'Not set'),
          ])),
        ]))),
      _note('Body Intelligence','Weight is available; composition and circumference values are not connected',Icons.monitor_weight_rounded),
    ]),
    1 => _page([
      _stats('Current weight',member.bodyWeight,'BMI','Not recorded',MemberTheme.green,palette.accent),
      _history('Composition indicators',[
        ['Body fat','No measurement record','—'],
        ['Muscle mass','No measurement record','—'],
        ['Circumference','No measurement record','—'],
      ]),
      _note('Body insights not connected','No unverified body-composition values are shown',Icons.insights_rounded),
    ]),
    2 => _page([
      _stats('Latest recorded weight',member.bodyWeight,'Weight goal','Not set',MemberTheme.green,palette.accent),
      Expanded(child:GlassChartFrame(title:'Weight & Composition Trend',subtitle:'Illustrative multi-series layout · dated values not connected',
        child:Column(children:[
          Expanded(child:GlassLineChart(series:const [[66,67,67.5,68.2,69.5],[54,55,55.8,56.4,57.2],[22,21.5,20.8,19.3,18.5]],
            colors:const [MemberTheme.purple,MemberTheme.green,MemberTheme.amber],minY:0,maxY:80)),
          const Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[_Tick('Jun'),_Tick('Jul'),_Tick('Aug'),_Tick('Sep'),_Tick('Oct')]),
        ]))),
      _note('Weight trend preview','Connect dated measurements before treating any trend as personal progress',Icons.timeline_rounded),
    ]),
    3 => _page([
      GlassMetricCard(label:'Body weight',value:member.bodyWeight,icon:Icons.monitor_weight_rounded,tint:MemberTheme.green,compact:compact),
      _history('Measurement detail',[
        ['Chest','Circumference record','Not recorded'],
        ['Waist','Circumference record','Not recorded'],
        ['Arms','Circumference record','Not recorded'],
        ['Body fat','Composition record','Not recorded'],
      ]),
      _note('Measurements','Add dated measurements to unlock comparisons',Icons.straighten_rounded),
    ]),
    4 => _page([
      Expanded(child:Row(children:[
        Expanded(child:Image.asset('assets/material_pack/inbox/PulseVault/03_whey_protein_tub.webp',fit:BoxFit.contain)),
        Expanded(child:Image.asset('assets/material_pack/inbox/PulseVault/28_protinex_tub.webp',fit:BoxFit.contain)),
      ])),
      _stats('Meal journal','Not linked','Nutrition plan','Not set',MemberTheme.green,palette.accent),
      _note('Nutrition offer preview','Meal logs, macros and nutrition plans need a connected source',Icons.restaurant_menu_rounded),
    ]),
    5 => _page([
      _goal('Weight target','Set a personal target first',0,palette.accent),
      _goal('Composition target','Add a body-composition record',0,MemberTheme.green),
      _goal('Measurement milestone','Add baseline measurements',0,MemberTheme.amber),
      const Spacer(),
      _note('Set a body goal','Goals are not inferred from the sample member record',Icons.flag_rounded),
    ]),
    _ => const SizedBox.shrink(),
  };

  Widget _page(List<Widget> children) => Column(children: children);

  Widget _metric(String label,String value,IconData icon,Color tint,String caption) =>
    GlassMetricCard(label:label,value:value,icon:icon,tint:tint,compact:compact,caption:caption);

  Widget _stats(String labelA,String valueA,String labelB,String valueB,Color colorA,Color colorB) =>
    Row(children:[
      Expanded(child:_metric(labelA,valueA,Icons.insights_rounded,colorA,'Member / demo')),
      SizedBox(width:gap),
      Expanded(child:_metric(labelB,valueB,Icons.track_changes_rounded,colorB,'Preview status')),
    ]);

  Widget _line(String title,String subtitle,List<List<double>> series,List<Color> colors) =>
    Expanded(child:GlassChartFrame(title:title,subtitle:subtitle,child:GlassLineChart(series:series,colors:colors)));

  Widget _bar(String title,String subtitle,List<double> values,Color tint,double maxY) =>
    Expanded(child:GlassChartFrame(title:title,subtitle:subtitle,child:Column(children:[
      Expanded(child:GlassBarChart(values:values,color:tint,maxY:maxY)),
      const Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[_Tick('M'),_Tick('T'),_Tick('W'),_Tick('T'),_Tick('F'),_Tick('S'),_Tick('S')]),
    ])));

  Widget _history(String title,List<List<String>> rows) =>
    Expanded(child:GlassChartFrame(title:title,subtitle:'Dated records · sample source only',child:Column(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
      for(final row in rows) _historyRow(Icons.history_rounded,row[0],row[1],row[2],palette.accent),
    ])));

  Widget _goal(String label,String subtitle,double value,Color tint) => Padding(
    padding:EdgeInsets.symmetric(vertical:compact?2:3),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Row(children:[
        Expanded(child:Text(label,maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(color:MemberTheme.ink,fontSize:10,fontWeight:FontWeight.w800))),
        Text('${(value*100).round()}%',style:TextStyle(color:tint,fontSize:10,fontWeight:FontWeight.w900)),
      ]),
      const SizedBox(height:2),
      ClipRRect(borderRadius:BorderRadius.circular(6),child:LinearProgressIndicator(
        value:value.clamp(0.0,1.0),minHeight:compact?5:6,backgroundColor:MemberTheme.glassEdge.withOpacity(0.5),
        valueColor:AlwaysStoppedAnimation<Color>(tint))),
      Text(subtitle,maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(color:MemberTheme.muted,fontSize:8,fontWeight:FontWeight.w600)),
    ]),
  );

  Widget _historyRow(IconData icon,String title,String subtitle,String value,Color tint) => Padding(
    padding:EdgeInsets.symmetric(vertical:compact?2:3),
    child:Row(children:[
      Container(width:26,height:26,decoration:BoxDecoration(color:tint.withOpacity(0.10),borderRadius:BorderRadius.circular(8)),
        child:Icon(icon,color:tint,size:15)),
      const SizedBox(width:6),
      Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text(title,maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(color:MemberTheme.ink,fontSize:9,fontWeight:FontWeight.w800)),
        Text(subtitle,maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(color:MemberTheme.muted,fontSize:8,fontWeight:FontWeight.w500)),
      ])),
      const SizedBox(width:4),
      Text(value,maxLines:1,style:TextStyle(color:tint,fontSize:9,fontWeight:FontWeight.w900)),
    ]),
  );

  Widget _note(String title,String description,IconData icon) => Container(
    width:double.infinity,padding:EdgeInsets.symmetric(horizontal:8,vertical:compact?5:7),
    decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFFF2E7FF),Colors.white]),
      borderRadius:BorderRadius.circular(10),border:Border.all(color:MemberTheme.glassEdge.withOpacity(0.8))),
    child:Row(children:[
      Icon(icon,color:MemberTheme.purple,size:17),const SizedBox(width:6),
      Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text(title,maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(color:MemberTheme.ink,fontSize:9,fontWeight:FontWeight.w900)),
        Text(description,maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(color:MemberTheme.muted,fontSize:7.5,fontWeight:FontWeight.w600)),
      ])),
    ]),
  );

  Widget _statusCard() => Container(
    padding:EdgeInsets.all(compact?7:9),
    decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFFE5F9EA),Color(0xFFF4E9FF)]),
      borderRadius:BorderRadius.circular(12),border:Border.all(color:const Color(0xFFB9E7C9))),
    child:Row(children:[
      Icon(member.paymentDue=='₹0'?Icons.verified_rounded:Icons.pending_actions_rounded,
        color:member.paymentDue=='₹0'?MemberTheme.green:MemberTheme.rose,size:22),
      const SizedBox(width:7),
      Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        const Text('Payment status',style:TextStyle(color:MemberTheme.ink,fontSize:9,fontWeight:FontWeight.w800)),
        Text(member.paymentDue=='₹0'?'Paid':'Due',
          style:TextStyle(color:member.paymentDue=='₹0'?MemberTheme.green:MemberTheme.rose,fontSize:16,fontWeight:FontWeight.w900)),
      ])),
      Column(crossAxisAlignment:CrossAxisAlignment.end,children:[
        Text(member.plan,style:const TextStyle(color:MemberTheme.ink,fontSize:9,fontWeight:FontWeight.w800)),
        Text('${member.membershipTotalDays} day plan',style:const TextStyle(color:MemberTheme.muted,fontSize:8,fontWeight:FontWeight.w600)),
      ]),
    ]),
  );

  Widget _assetBanner(String file,String title,String subtitle,Color tint) => Container(
    height:compact?34:44,padding:const EdgeInsets.symmetric(horizontal:7,vertical:3),
    decoration:BoxDecoration(color:tint.withOpacity(0.32),borderRadius:BorderRadius.circular(10),border:Border.all(color:MemberTheme.glassEdge)),
    child:Row(children:[
      Image.asset('assets/material_pack/inbox/PulseVault/$file',fit:BoxFit.contain,width:compact?36:46),
      const SizedBox(width:6),
      Expanded(child:Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text(title,maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(color:MemberTheme.ink,fontSize:9,fontWeight:FontWeight.w900)),
        Text(subtitle,maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(color:MemberTheme.muted,fontSize:7.5,fontWeight:FontWeight.w600)),
      ])),
      const Text('DEMO',style:TextStyle(color:MemberTheme.purple,fontSize:7,fontWeight:FontWeight.w900)),
    ]),
  );

  Widget _legend(Color color,String text) => Padding(
    padding:const EdgeInsets.only(left:5),
    child:Row(mainAxisSize:MainAxisSize.min,children:[
      Container(width:6,height:6,decoration:BoxDecoration(color:color,shape:BoxShape.circle)),
      const SizedBox(width:2),
      Text(text,style:const TextStyle(color:MemberTheme.muted,fontSize:7,fontWeight:FontWeight.w700)),
    ]),
  );
}

class _Tick extends StatelessWidget {
  const _Tick(this.label);
  final String label;
  @override
  Widget build(BuildContext context)=>Expanded(child:Center(child:Text(label,maxLines:1,
    style:const TextStyle(color:MemberTheme.muted,fontSize:7,fontWeight:FontWeight.w800))));
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.color,required this.label,required this.value});
  final Color color;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context)=>Padding(
    padding:const EdgeInsets.symmetric(vertical:2),
    child:Row(children:[
      Container(width:7,height:7,decoration:BoxDecoration(color:color,shape:BoxShape.circle)),
      const SizedBox(width:4),
      Expanded(child:Text(label,maxLines:1,overflow:TextOverflow.ellipsis,
        style:const TextStyle(color:MemberTheme.ink,fontSize:7.5,fontWeight:FontWeight.w700))),
      const SizedBox(width:2),
      SizedBox(width:18,child:Align(alignment:Alignment.centerRight,child:FittedBox(
        fit:BoxFit.scaleDown,child:Text(value,style:const TextStyle(color:MemberTheme.muted,fontSize:7,fontWeight:FontWeight.w700))))),
    ]),
  );
}
