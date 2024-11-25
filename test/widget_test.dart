import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_number_app/apis/random_number_api.dart';
import 'package:random_number_app/dependency_injection.dart';

import 'package:random_number_app/main.dart';
import 'package:random_number_app/view_model/homepage_view_model.dart';

class _MockRandomNumberApi extends Mock implements RandomNumberApi {}

void _stepInjectionForTesting() {
  injector.registerLazySingleton<HomepageViewModel>(
      () => HomepageViewModel(randomNumberApi: injector<RandomNumberApi>()));
  injector.registerLazySingleton<RandomNumberApi>(() => _MockRandomNumberApi());
}

void _setupMockRandomNumberApi() {
  final mockRandomNumberApi = injector<RandomNumberApi>();
  when(() => mockRandomNumberApi.getRandomNumbers(any()))
      .thenReturn([2, 1, 3, 4, 5, 6, 7, 8, 9, 10]);
  when(() => mockRandomNumberApi.checkOrder(any())).thenReturn(false);
}

void main() {
  setUp(() {
    _stepInjectionForTesting();
    _setupMockRandomNumberApi();
  });

  tearDown((){
    injector.reset();
  });

  testWidgets(
      'Ensure user can input a number, view a list of random numbers',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.enterText(find.byType(TextField), '10');
    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsWidgets);
  });
  testWidgets(
      'Ensure user can input a number, view a list of random numbers and validate order using the UI',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.enterText(find.byType(TextField), '10');
    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsWidgets);
    await tester.tap(find.text('Validar'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
