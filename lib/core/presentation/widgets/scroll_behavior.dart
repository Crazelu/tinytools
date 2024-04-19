import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TinyToolsScrollBehavior extends MaterialScrollBehavior {
  const TinyToolsScrollBehavior();
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
