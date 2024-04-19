import 'package:flutter/foundation.dart';
import 'package:tools/core/presentation/viewmodel/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  final ValueNotifier<int> _counter = ValueNotifier(0);
  ValueNotifier<int> get counter => _counter;

  void increment() {
    _counter.value += 1;
  }

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }
}
