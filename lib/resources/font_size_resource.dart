import 'screen_size_resource.dart';

class FontSize {
  double adjustFont(double size) {
    return (size +
        (24 - 14) *
            (ScreenSize().width - 400) /
            (ScreenSize().width - ScreenSize().heightBody));
  }
}
