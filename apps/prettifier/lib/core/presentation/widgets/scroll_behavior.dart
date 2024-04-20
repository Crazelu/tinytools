import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PrettifierScrollBehavior extends MaterialScrollBehavior {
  const PrettifierScrollBehavior();
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
