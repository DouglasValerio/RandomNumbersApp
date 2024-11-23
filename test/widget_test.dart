
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
      .thenReturn([10, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
  when(() => mockRandomNumberApi.checkOrder(any())).thenReturn(false);
}

void main() {
  setUp(() {
    _stepInjectionForTesting();
    _setupMockRandomNumberApi();
  });

  testWidgets('Ensure user views number list on home page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    // Verify that all numbers are present in the list.
    for (var element in List.generate(10, (index) => index + 1)) {
      final finder = find.text('$element');
       await tester.scrollUntilVisible(finder, 50);
      expect(finder, findsOneWidget);
     
    }
    expect(find.byType(ListTile), findsWidgets);
  });
}
