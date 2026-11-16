import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/presentation/widgets/attendance_calendar_grid.dart';

void main() {
  testWidgets(
      'calendar derives weekdays and renders Sundays as disabled OFF days',
      (tester) async {
    tester.view.physicalSize = const Size(360, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AttendanceCalendarGrid(
            year: 2026,
            month: 10,
            days: [
              CalendarDayItem(day: 4, status: DayAttendanceStatus.absent),
              CalendarDayItem(day: 6, status: DayAttendanceStatus.holiday),
              CalendarDayItem(day: 7, status: DayAttendanceStatus.absent),
              CalendarDayItem(day: 8, status: DayAttendanceStatus.present),
            ],
          ),
        ),
      ),
    );

    expect(find.text('October 2026'), findsOneWidget);
    expect(find.text('OFF'), findsNWidgets(4));
    expect(find.text('HOL'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'calendar supports months with different lengths and weekday offsets',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AttendanceCalendarGrid(
            year: 2026,
            month: 2,
            days: [],
          ),
        ),
      ),
    );

    expect(find.text('February 2026'), findsOneWidget);
    expect(find.byKey(const ValueKey('attendance_day_28')), findsOneWidget);
    expect(find.byKey(const ValueKey('attendance_day_29')), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
