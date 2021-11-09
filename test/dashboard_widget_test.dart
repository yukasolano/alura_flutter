import 'package:alura_flutter/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should display the main image when Dashbaord is opened',
          (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets('Should display the first feature when Dashbaord is opened',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: Dashboard()));
        final firstFeature = find.byType(MiniCard);
        expect(firstFeature, findsWidgets);
      });
}
