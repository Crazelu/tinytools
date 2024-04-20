import 'package:prettifier/core/localization/app_localizations.dart';
import 'package:prettifier/core/localization/app_localizations_en.dart';
import 'package:flutter/material.dart';

extension PrettifierLocaleExtension on BuildContext {
  PrettifierLocalizations get locale =>
      PrettifierLocalizations.of(this) ?? PrettifierLocalizationsEn();
}
