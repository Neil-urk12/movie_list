import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movie_list/main.dart';

void main() {
  testWidgets('Selecting a movie updates details after delay', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Rating: 8.8'), findsOneWidget);

    await tester.tap(find.text('Parasite'));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Rating: 8.6'), findsOneWidget);
    expect(find.text('Rating: 8.8'), findsNothing);
  });
}
