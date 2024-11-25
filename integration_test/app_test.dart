import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:random_number_app/dependency_injection.dart';
import 'package:random_number_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();
  testWidgets('Ensure user can input a number, view a list of random numbers and reorder list by using drag gesture',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.enterText(find.byType(TextField), '10');
    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsWidgets);
     final firstItemFinder = find.text('1');
     await tester.scrollUntilVisible(firstItemFinder, 50);
     final TestGesture drag = await tester.startGesture(tester.getCenter(firstItemFinder));
     await tester.pump(kLongPressTimeout + kPressTimeout);
      final firstListTile = find.byType(ListTile).first;
     await drag.moveTo(tester.getCenter(firstListTile).translate(0, -200));
     await drag.up();
     await tester.pumpAndSettle();
    final firstListTileAfterReorder = find.byType(ListTile).first;
    final text = find.descendant(of: firstListTileAfterReorder, matching: find.byType(Text));
    final widget = tester.widget<Text>(text);
    expect(widget.data, "1");
  });


}
