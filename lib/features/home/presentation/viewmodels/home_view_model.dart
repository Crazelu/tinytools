import 'package:tools/core/presentation/viewmodel/base_view_model.dart';
import "package:universal_html/html.dart" as html;

class HomeViewModel extends BaseViewModel {
  void launchUrl(String url, String name) {
    html.window.open(url, name);
  }
}
