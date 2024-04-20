import 'package:mockito/annotations.dart';
import 'package:prettifier/core/dialog/dialog_handler.dart';
import 'package:prettifier/core/navigation/navigation_bus.dart';

@GenerateNiceMocks([
  MockSpec<DialogHandler>(),
  MockSpec<NavigationBus>(),
])
void main() {}
