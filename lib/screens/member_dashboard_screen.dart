import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/member_theme.dart';
import '../widgets/purple_dashboard.dart';
class MemberDashboardScreen extends StatelessWidget{
 const MemberDashboardScreen({super.key});
 @override Widget build(BuildContext context)=>AnnotatedRegion<SystemUiOverlayStyle>(
  value:const SystemUiOverlayStyle(statusBarColor:MemberTheme.canvas,
   statusBarIconBrightness:Brightness.dark,systemNavigationBarColor:MemberTheme.canvas,
   systemNavigationBarIconBrightness:Brightness.dark),
  child:const Scaffold(body:SafeArea(child:PurpleMemberDashboard())));
}
