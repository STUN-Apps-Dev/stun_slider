part of 'stun_slider.dart';

class StunSliderNavButton extends StatefulWidget {
  final StunSliderNavDirection direction;
  final StunSliderController controller;
  final Widget child;
  final int itemCount;

  const StunSliderNavButton.prev({
    super.key,
    required this.controller,
    required this.itemCount,
    this.direction = StunSliderNavDirection.prev,
    this.child = const Icon(Icons.arrow_back),
  });

  const StunSliderNavButton.next({
    super.key,
    required this.controller,
    required this.itemCount,
    this.direction = StunSliderNavDirection.next,
    this.child = const Icon(Icons.arrow_forward),
  });

  @override
  State<StunSliderNavButton> createState() => _StunSliderNavButtonState();
}

class _StunSliderNavButtonState extends State<StunSliderNavButton> {
  @override
  void initState() {
    if (widget.itemCount >= 2) {
      widget.controller.addListener(_listener);
    }
    super.initState();
  }

  void _listener() => setState(() {});

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount < 2) return const SizedBox.shrink();
    return Opacity(
      opacity: _isActive ? 1 : 0.7,
      child: IgnorePointer(
        ignoring: !_isActive,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _onTap,
            child: widget.child,
          ),
        ),
      ),
    );
  }

  void _onTap() {
    if (widget.direction == StunSliderNavDirection.next) {
      return widget.controller.nextPage();
    } else {
      return widget.controller.previousPage();
    }
  }

  bool get _isActive {
    if (widget.direction == StunSliderNavDirection.next) {
      return widget.controller.index < widget.itemCount - 1 ? true : false;
    } else {
      return widget.controller.index == 0 ? false : true;
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }
}
