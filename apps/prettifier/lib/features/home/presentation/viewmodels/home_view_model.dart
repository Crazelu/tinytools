import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:prettifier/core/presentation/viewmodel/base_view_model.dart';
import 'package:prettifier/core/utils/logger.dart';

class HomeViewModel extends BaseViewModel {
  late final _logger = LoggerFactory.getLogger(HomeViewModel);

  final ValueNotifier<String> _prettifiedJSON = ValueNotifier('');
  ValueNotifier<String> get prettifiedJSON => _prettifiedJSON;

  static const _decoder = JsonDecoder();
  static const _encoder = JsonEncoder.withIndent('  ');

  void prettify(String value) {
    try {
      final data = _decoder.convert(value);
      _prettifiedJSON.value = _encoder.convert(data);
    } catch (e, trace) {
      _prettifiedJSON.value = '';
      _logger.error(
        'Error from prettify',
        error: e,
        stackTrace: trace,
      );
    }
  }

  @override
  void dispose() {
    _prettifiedJSON.dispose();
    super.dispose();
  }
}
