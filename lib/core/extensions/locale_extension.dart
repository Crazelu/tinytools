import 'package:tools/core/localization/app_localizations.dart';
import 'package:tools/core/localization/app_localizations_en.dart';
import 'package:flutter/material.dart';

extension TinyToolsLocaleExtension on BuildContext {
  TinyToolsLocalizations get locale =>
      TinyToolsLocalizations.of(this) ?? TinyToolsLocalizationsEn();
}
