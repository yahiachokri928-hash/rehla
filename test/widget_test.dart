// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:rehla/main.dart';
import 'package:rehla/providers/favoris_model.dart';

void main() {
  testWidgets('Rihla app starts', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => FavorisModel(),
        child: const RihlaApp(),
      ),
    );

    expect(find.byType(RihlaApp), findsOneWidget);
  });
}
