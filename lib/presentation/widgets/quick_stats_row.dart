import 'package:flutter/material.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';
enum QuickStatTab { attendance, workout, payment, body }
class QuickStatsRow extends StatelessWidget {
 final MemberIntelligenceData data; final QuickStatTab selectedTab; final ValueChanged<QuickStatTab>? onTabSelected;
 const QuickStatsRow({super.key,required this.data,this.selectedTab=QuickStatTab.attendance,this.onTabSelected});
 @override Widget build(BuildContext context) {
 final items=<({IconData icon,String label,String value,Color color,Color start,Color end})>[
 (icon:Icons.event_available_rounded,label:'Attendance',value:'${data.attendanceRate}%',color:const Color(0xFF079B43),start:const Color(0xFFE9FFF0),end:const Color(0xFFD7F9E2)),
 (icon:Icons.fitness_center_rounded,label:'Workout',value:data.workoutTime,color:const Color(0xFF7C20E8),start:const Color(0xFFF6EEFF),end:const Color(0xFFECE0FF)),
 (icon:Icons.account_balance_wallet_rounded,label:'Payment',value:data.paymentStatus,color:const Color(0xFFD91E52),start:const Color(0xFFFFEDF3),end:const Color(0xFFFFDFEA)),
 (icon:Icons.monitor_weight_outlined,label:'Body',value:data.bodyWeight,color:const Color(0xFF1688E8),start:const Color(0xFFEBF7FF),end:const Color(0xFFDDEEFF)),
 ];
 return Padding(padding:const EdgeInsets.symmetric(horizontal:10,vertical:5),child:Row(children:[for(var i=0;i<items.length;i++)...[
 if(i>0)const SizedBox(width:6),Expanded(child:Container(height:76,padding:const EdgeInsets.symmetric(horizontal:3,vertical:7),decoration:BoxDecoration(gradient:LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[items[i].start,items[i].end]),borderRadius:BorderRadius.circular(20),border:Border.all(color:Colors.white.withValues(alpha:.95),width:1.4),boxShadow:[BoxShadow(color:items[i].color.withValues(alpha:.18),blurRadius:10,offset:const Offset(0,4)),const BoxShadow(color:Color(0x66FFFFFF),blurRadius:3,spreadRadius:-1)]),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(items[i].icon,color:items[i].color,size:22),const SizedBox(height:3),Text(items[i].label,maxLines:1,style:const TextStyle(fontFamily:BadGymTypography.fontBody,fontWeight:FontWeight.w700,fontSize:9.5,color:Color(0xFF18213F))),const SizedBox(height:1),FittedBox(fit:BoxFit.scaleDown,child:Text(items[i].value,style:TextStyle(fontFamily:BadGymTypography.fontHeading,fontWeight:FontWeight.w900,fontSize:16,color:items[i].color)))])))]]));
 }
}