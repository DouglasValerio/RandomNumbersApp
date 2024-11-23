import 'package:random_number_app/apis/random_number_api.dart';

class RandomNumberApiImpl implements RandomNumberApi {
  @override
  bool checkOrder(List<int> numbers) {
   if (numbers.length <= 1) {
    return true;
  }

  bool isNonDecreasing = true;
  bool isNonIncreasing = true;

  for (int i = 1; i < numbers.length; i++) {
    if (numbers[i] < numbers[i - 1]) {
      isNonDecreasing = false;
    }
    if (numbers[i] > numbers[i - 1]) {
      isNonIncreasing = false;
    }
    if (!isNonDecreasing && !isNonIncreasing) {
      return false;
    }
  }

  return true;
  }

  @override
  List<int> getRandomNumbers(int quantity) {
    final list = List.generate(quantity, (index) => index + 1);

    list.shuffle();
    return list;
  }
}
