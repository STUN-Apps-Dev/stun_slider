part of 'stun_slider.dart';

class StunSliderWidget extends StatefulWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final StunSliderController? controller;
  final Clip clipBehavior;
  final bool fixed;
  const StunSliderWidget({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.controller,
    this.clipBehavior = Clip.hardEdge,
    this.fixed = false,
  }) : super(key: key);

  @override
  State<StunSliderWidget> createState() => _StunSliderWidgetState();
}

class _StunSliderWidgetState extends State<StunSliderWidget>
    with TickerProviderStateMixin {
  late final StunSliderController _controller;

  late List<double> _heights;

  double get _currentHeight => _heights[_controller.index];

  @override
  void initState() {
    _heights = List.generate(widget.itemCount, (index) => 0.0);
    _controller = widget.controller ?? StunSliderController();
    _controller.addListener(_listener);

    super.initState();
  }

  void _listener() => setState(() {});

  void _onSizeChanged(int index, Size size) {
    if (widget.fixed) return;
    setState(() => _heights[index] = size.height);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fixed) {
      return LayoutBuilder(
        builder: (_, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: _BodyWidget(
              clipBehavior: widget.clipBehavior,
              controller: _controller.pageController,
              itemCount: widget.itemCount,
              itemBuilder: widget.itemBuilder,
              onSizeChanged: _onSizeChanged,
            ),
          );
        },
      );
    }

    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 200),
      tween: Tween<double>(begin: _heights[0], end: _currentHeight),
      builder: (context, value, child) => SizedBox(
        height: value,
        child: child,
      ),
      child: _BodyWidget(
        clipBehavior: widget.clipBehavior,
        controller: _controller.pageController,
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder,
        onSizeChanged: _onSizeChanged,
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    super.dispose();
  }
}

class _BodyWidget extends StatelessWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final Clip clipBehavior;
  final void Function(int, Size) onSizeChanged;
  final PageController? controller;
  const _BodyWidget({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    required this.clipBehavior,
    required this.onSizeChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: itemCount < 2 ? const NeverScrollableScrollPhysics() : null,
      clipBehavior: clipBehavior,
      itemBuilder: (context, index) {
        return OverflowBox(
          minHeight: 0,
          maxHeight: double.infinity,
          alignment: Alignment.topCenter,
          child: SizeReportingWidget(
            onSizeChanged: (size) => onSizeChanged(index, size),
            child: Align(
              child: itemBuilder(context, index),
            ),
          ),
        );
      },
      itemCount: itemCount,
      controller: controller,
      scrollBehavior: StunSliderScrollBehavior(),
    );
  }
}

class SizeReportingWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChanged;

  const SizeReportingWidget({
    Key? key,
    required this.child,
    required this.onSizeChanged,
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
      widget.onSizeChanged(size);
    }
  }
}
