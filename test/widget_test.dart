import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym_member_intelligence/main.dart';
void main(){
 Future<void> setSize(WidgetTester t,Size s)async{t.view.physicalSize=s;t.view.devicePixelRatio=1;
  addTearDown(t.view.resetPhysicalSize);addTearDown(t.view.resetDevicePixelRatio);}
 testWidgets('dashboard and attendance render',(t)async{await setSize(t,const Size(360,780));
  await t.pumpWidget(const BadGymApp());expect(find.text('BAD GYM'),findsOneWidget);
  expect(find.text('Attendance Intelligence'),findsOneWidget);});
 testWidgets('member payment and plan render',(t)async{await setSize(t,const Size(360,780));
  await t.pumpWidget(const BadGymApp());expect(find.text('₹500 Due'),findsWidgets);
  expect(find.textContaining('8 Days Left'),findsOneWidget);expect(find.text('Gold Plan   ·   Active'),findsOneWidget);});
 testWidgets('compact 320dp viewport renders',(t)async{await setSize(t,const Size(320,720));
  await t.pumpWidget(const BadGymApp());await t.pumpAndSettle();expect(find.text('BAD GYM'),findsOneWidget);
  final error=t.takeException(); if(error!=null){debugDumpRenderTree();} expect(error,isNull);});
 testWidgets('navigation rail interaction works',(t)async{await setSize(t,const Size(360,780));
  await t.pumpWidget(const BadGymApp());await t.ensureVisible(find.byType(InkWell).first); await t.tap(find.byType(InkWell).first);await t.pump();
  expect(t.takeException(),isNull);});
}
