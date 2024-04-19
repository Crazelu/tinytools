import 'package:flutter/material.dart';
import 'package:tools/core/app/app.dart';
import 'package:tools/core/dependencies/dependency_registry.dart';
import 'package:tools/core/utils/logger.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  Logger.showLogs();
  await DependencyRegistry.register();
  runApp(const TinyToolsApp());
}
