import 'app_localizations.dart';

/// The translations for English (`en`).
class TinyToolsLocalizationsEn extends TinyToolsLocalizations {
  TinyToolsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get luckysTools => 'Lucky\'s Tools';

  @override
  String get luckysToolsDescription => 'A collection of tiny tools to get common tasks done really quick!';

  @override
  String get tinyRsaTool => 'Tiny RSA Tool';

  @override
  String get tinyRsaToolDescription => 'A tiny RSA encryption and decryption tool.';

  @override
  String get tryItHere => 'Try it here';

  @override
  String get jsonPrettifierTool => 'JSON Prettifier';

  @override
  String get jsonPrettifierToolDescription => 'Turn JSON blobs into a formatted prettier version for better visualization.';
}
