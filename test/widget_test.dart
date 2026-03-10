// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/theme/app_theme.dart';
import 'package:todo_list/views/home/home_screen.dart';

void main() {
  testWidgets('Home screen uses edge-to-edge background-friendly scaffold chrome', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Welcome to the Home Screen!'), findsOneWidget);

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    final appBar = tester.widget<AppBar>(find.byType(AppBar));

    expect(scaffold.backgroundColor, Colors.transparent);
    expect(scaffold.extendBodyBehindAppBar, isTrue);
    expect(appBar.backgroundColor, Colors.transparent);
    expect(appBar.elevation, 0);
  });
}
