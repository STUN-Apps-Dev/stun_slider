part of 'stun_slider.dart';

class StunSliderController extends ChangeNotifier {
  PageController? _controller;
  PageController? get pageController => _controller;
  int _index = 0;
  int get index => _index;

  StunSliderController([PageController? controller]) {
    _controller = controller;
    setIndex(pageController?.initialPage ?? 0);

    _controller?.addListener(() {
      setIndex(_controller?.page?.round() ?? 0);
    });
  }

  void setIndex(int value) {
    if (value != _index) {
      _index = value;
      notifyListeners();
    }
  }

  void jumpToIndex(int value) {
    if (value != _index) {
      pageController?.animateToPage(
        value,
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    }
  }

  void nextPage() {
    pageController?.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  void previousPage() {
    pageController?.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }
}
