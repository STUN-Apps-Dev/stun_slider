part of 'stun_slider.dart';

class StunSliderNavButton extends StatefulWidget {
  final StunSliderNavDirection direction;
  final StunSliderController controller;
  final Widget child;
  final int itemCount;
  const StunSliderNavButton({
    Key? key,
    required this.direction,
    required this.controller,
    required this.child,
    required this.itemCount,
  }) : super(key: key);

  @override
  State<StunSliderNavButton> createState() => _StunSliderNavButtonState();
}

class _StunSliderNavButtonState extends State<StunSliderNavButton> {
  @override
  void initState() {
    widget.controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
}
