import 'package:alura_flutter/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should display the main image when Dashboard is opened',
          (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets('Should display the transfer feature when Dashboard is opened',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    // final iconTransfer = find.widgetWithIcon(MiniCard, Icons.monetization_on);
    // expect(iconTransfer, findsOneWidget);
    // final nameTransfer = find.widgetWithText(MiniCard, 'Transfer');
    // expect(nameTransfer, findsOneWidget);
    final transferMiniCard = find.byWidgetPredicate((widget) => _findMiniCard(widget, 'Transfer', Icons.monetization_on));
    expect(transferMiniCard, findsOneWidget);
  });

  testWidgets('Should display the feed feature when Dashboard is opened',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: Dashboard()));
        final feedMiniCard = find.byWidgetPredicate((widget) => _findMiniCard(widget, 'Feed', Icons.description));
        expect(feedMiniCard, findsOneWidget);
      });
}

bool _findMiniCard(Widget widget, String title, IconData icon) {
    if (widget is MiniCard) {
    return widget.title == title && widget.icon == icon;
  }
  return false;
}
