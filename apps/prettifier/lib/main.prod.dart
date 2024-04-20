import 'package:flutter/material.dart';
import 'package:prettifier/core/app/app.dart';
import 'package:prettifier/core/dependencies/dependency_registry.dart';
import 'package:prettifier/core/utils/logger.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  Logger.hideLogs();
  await DependencyRegistry.register();
  runApp(const PrettifierApp());
}
