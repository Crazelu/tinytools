import 'package:mockito/annotations.dart';
import 'package:tools/core/dialog/dialog_handler.dart';
import 'package:tools/core/navigation/navigation_bus.dart';

@GenerateNiceMocks([
    MockSpec<DialogHandler>(),
    MockSpec<NavigationBus>(),
    ])
void main() {}