import 'package:biy_daalt2/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:biy_daalt2/main.dart';

void main() {

  testWidgets('MyApp loads and builds MaterialApp', (WidgetTester tester) async {
    // Pump MyApp normally
    await tester.pumpWidget(const MyApp());

    // Ensure MaterialApp exists
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Welcome Page renders correct text', (WidgetTester tester) async {
    // Wrap Welcome in MaterialApp for proper context
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    expect(find.text('Сайн байна уу, '), findsOneWidget);
    expect(find.text('Үргэлжлүүлэх '), findsOneWidget);
  });
}
