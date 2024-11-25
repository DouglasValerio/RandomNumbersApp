import 'package:flutter/material.dart';
import 'package:random_number_app/apis/random_number_api.dart';

class HomepageViewModel extends ChangeNotifier {
  final RandomNumberApi _randomNumberApi;

  HomepageViewModel({required RandomNumberApi randomNumberApi})
      : _randomNumberApi = randomNumberApi;

  List<int> _numbers = [];
  List<int> get numbers => _numbers;
  int _moveCount = 0;
  int get moveCount => _moveCount;

  bool _isOrdered = false;

  bool get isOrdered => _isOrdered;

  void generateNumbers(int quantity) {
    _moveCount = 0;
    _isOrdered = false;
    _numbers = _randomNumberApi.getRandomNumbers(quantity);
    notifyListeners();
  }

  void reorderNumbers(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final int item = _numbers.removeAt(oldIndex);
    _numbers.insert(newIndex, item);
    _moveCount++;
    _isOrdered = _randomNumberApi.checkOrder(_numbers);
    notifyListeners();
  }

  bool checkOrder() {
    return _randomNumberApi.checkOrder(numbers);
  }

  void clear() {
    _moveCount = 0;
    _numbers.clear();
    _isOrdered = false;
    notifyListeners();
  }
}
