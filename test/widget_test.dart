import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signup_app/main.dart';

void main() {
  testWidgets('Haunted Mansion welcome screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(const HauntedMansionApp());
 expect(find.text('Enter If You Dare'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}