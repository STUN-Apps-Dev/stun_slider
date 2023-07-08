part of 'stun_slider.dart';

class StunSliderWidget extends StatefulWidget {
  final double height;
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final StunSliderController? controller;
  final Clip clipBehavior;
  const StunSliderWidget({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.height = 300,
    this.controller,
    this.clipBehavior = Clip.hardEdge,
  }) : super(key: key);

  @override
  State<StunSliderWidget> createState() => _StunSliderWidgetState();
}

class _StunSliderWidgetState extends State<StunSliderWidget>
    with TickerProviderStateMixin {
  late final StunSliderController _controller;

  late List<double> _heights;

  double get _currentHeight => _heights[_controller.index ?? 0];

  @override
  void initState() {
    _heights = List.generate(widget.itemCount, (index) => 0.0);
    _controller = widget.controller ?? StunSliderController();
    _controller.addListener(_listener);

    super.initState();
  }

  void _listener() => setState(() {});

  void _onSizeChange(int index, Size size) {
    setState(() => _heights[index] = size.height);
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 200),
      tween: Tween<double>(begin: _heights[0], end: _currentHeight),
      builder: (context, value, child) => SizedBox(height: value, child: child),
      child: PageView.builder(
        clipBehavior: widget.clipBehavior,
        itemBuilder: (context, index) {
          return OverflowBox(
            minHeight: 0,
            maxHeight: double.infinity,
            alignment: Alignment.topCenter,
            child: SizeReportingWidget(
              onSizeChange: (size) => _onSizeChange(index, size),
              child: Align(
                child: widget.itemBuilder(context, index),
              ),
            ),
          );
        },
        itemCount: widget.itemCount,
        controller: _controller.pageController,
        scrollBehavior: StunSliderScrollBehavior(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    super.dispose();
  }
}

class SizeReportingWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  const SizeReportingWidget({
    Key? key,
    required this.child,
    required this.onSizeChange,
  }) : super(key: key);

  @override
  State<SizeReportingWidget> createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return widget.child;
  }

  void _notifySize() {
    if (!mounted) {
      return;
    }
    final size = context.size;
    if (_oldSize != size && size != null) {
      _oldSize = size;
      widget.onSizeChange(size);
    }
  }
}
