import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/presentation/widgets/quick_stats_row.dart';
class MemberSectionTabs extends StatelessWidget {
 final QuickStatTab selectedTab; final ValueChanged<QuickStatTab> onTabSelected;
 const MemberSectionTabs({super.key,required this.selectedTab,required this.onTabSelected});
 @override Widget build(BuildContext context) {
 const tabs=[(tab:QuickStatTab.attendance,label:'Attendance',icon:Icons.event_available_rounded),(tab:QuickStatTab.workout,label:'Workout',icon:Icons.fitness_center_rounded),(tab:QuickStatTab.payment,label:'Payment',icon:Icons.account_balance_wallet_rounded),(tab:QuickStatTab.body,label:'Body',icon:Icons.person_outline_rounded)];
 return Padding(padding:const EdgeInsets.symmetric(horizontal:10,vertical:6),child:Row(children:[for(var i=0;i<tabs.length;i++)...[
 if(i>0)const SizedBox(width:5),Expanded(child:Material(color:Colors.transparent,child:InkWell(borderRadius:BorderRadius.circular(24),onTap:(){HapticFeedback.selectionClick();onTabSelected(tabs[i].tab);},child:AnimatedContainer(duration:const Duration(milliseconds:180),height:43,decoration:BoxDecoration(gradient:selectedTab==tabs[i].tab?const LinearGradient(colors:[Color(0xFFB13BFF),Color(0xFF7418D8),Color(0xFF5511B5)]):const LinearGradient(colors:[Color(0xFFFFFFFF),Color(0xFFF3EEFF)]),borderRadius:BorderRadius.circular(24),border:Border.all(color:selectedTab==tabs[i].tab?const Color(0xFFD9B4FF):Colors.white,width:1.3),boxShadow:[BoxShadow(color:const Color(0xFF7621D6).withValues(alpha:(selectedTab==tabs[i].tab) ? .34 : .10),blurRadius:selectedTab==tabs[i].tab?11:5,offset:const Offset(0,3))]),child:Row(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(tabs[i].icon,size:17,color:selectedTab==tabs[i].tab?Colors.white:const Color(0xFF3C365B)),const SizedBox(width:4),Flexible(child:FittedBox(fit:BoxFit.scaleDown,child:Text(tabs[i].label,style:TextStyle(fontFamily:'Poppins',fontWeight:FontWeight.w700,fontSize:10,color:selectedTab==tabs[i].tab?Colors.white:const Color(0xFF34304F)))))]))))]]));
 }
}