part of 'stun_slider.dart';

class StunSliderScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices {
    return {
      PointerDeviceKind.touch,
      PointerDeviceKind.mouse,
      PointerDeviceKind.trackpad
    };
  }
}

enum StunSliderNavDirection { prev, next }
