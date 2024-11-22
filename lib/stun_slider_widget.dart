part of 'stun_slider.dart';

class StunSliderWidget extends StatefulWidget {
  final int itemCount;

  final Widget Function(BuildContext context, int index) itemBuilder;

  final StunSliderController? controller;

  final Clip clipBehavior;

  const StunSliderWidget.builder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.clipBehavior = Clip.hardEdge,
  });

  @override
  State<StatefulWidget> createState() => _StunSliderWidgetState();
}

class _StunSliderWidgetState extends State<StunSliderWidget> {
  late List<double> _sizes;
  int _currentPage = 0;
  int _previousPage = 0;
  bool _shouldDisposePageController = false;
  bool _firstPageLoaded = false;

  double get _currentSize => _sizes[_currentPage];

  double get _previousSize => _sizes[_previousPage];

  late final StunSliderController _controller;

  @override
  void initState() {
    super.initState();
    _sizes = _prepareSizes();
    _controller = widget.controller ?? StunSliderController();
    _controller.pageController.addListener(_updatePage);
    _currentPage = _controller.index.clamp(0, _sizes.length - 1);
    _previousPage = _currentPage - 1 < 0 ? 0 : _currentPage - 1;
    _shouldDisposePageController = widget.controller == null;
  }

  @override
  void didUpdateWidget(covariant StunSliderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_updatePage);
      _controller.pageController.addListener(_updatePage);
      _shouldDisposePageController = widget.controller == null;
    }
    if (_shouldReinitializeHeights(oldWidget)) {
      _reinitializeSizes();
    }
  }

  @override
  void dispose() {
    _controller.pageController.removeListener(_updatePage);
    if (_shouldDisposePageController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: _getDuration(),
      tween: Tween<double>(begin: _previousSize, end: _currentSize),
      builder: (context, value, child) => SizedBox(
        height: value,
        width: null,
        child: child,
      ),
      child: _buildPageView(),
    );
  }

  bool _shouldReinitializeHeights(StunSliderWidget oldWidget) {
    return oldWidget.itemCount != widget.itemCount;
  }

  void _reinitializeSizes() {
    final currentPageSize = _sizes[_currentPage];
    _sizes = _prepareSizes();

    if (_currentPage >= _sizes.length) {
      final differenceFromPreviousToCurrent = _previousPage - _currentPage;
      _currentPage = _sizes.length - 1;

      _previousPage = (_currentPage + differenceFromPreviousToCurrent)
          .clamp(0, _sizes.length - 1);
    }

    _previousPage = _previousPage.clamp(0, _sizes.length - 1);
    _sizes[_currentPage] = currentPageSize;
  }

  Duration _getDuration() {
    if (_firstPageLoaded) {
      return const Duration(milliseconds: 200);
    }
    return Duration.zero;
  }

  Widget _buildPageView() {
    final physics =
        widget.itemCount < 2 ? const NeverScrollableScrollPhysics() : null;
    return PageView.builder(
      controller: _controller.pageController,
      itemBuilder: _itemBuilder,
      itemCount: widget.itemCount,
      physics: physics,
      clipBehavior: widget.clipBehavior,
      scrollBehavior: StunSliderScrollBehavior(),
    );
  }

  List<double> _prepareSizes() {
    return List.filled(widget.itemCount, 0.0);
  }

  void _updatePage() {
    final newPage = _controller.pageController.page!.round();
    if (_currentPage != newPage) {
      setState(() {
        _firstPageLoaded = true;
        _previousPage = _currentPage;
        _currentPage = newPage;
      });
    }
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final item = widget.itemBuilder(context, index);
    return OverflowPage(
      onSizeChange: (size) => setState(
        () => _sizes[index] = size.height,
      ),
      alignment: Alignment.center,
      scrollDirection: Axis.horizontal,
      child: Align(
        child: item,
      ),
    );
  }
}

class OverflowPage extends StatelessWidget {
  final ValueChanged<Size> onSizeChange;
  final Widget child;
  final Alignment alignment;
  final Axis scrollDirection;

  const OverflowPage({
    super.key,
    required this.onSizeChange,
    required this.child,
    required this.alignment,
    required this.scrollDirection,
  });

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      minHeight: 0,
      maxHeight: double.infinity,
      alignment: Alignment.topCenter,
      child: SizeReportingWidget(
        onSizeChange: onSizeChange,
        child: child,
      ),
    );
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
  State<StatefulWidget> createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  final _widgetKey = GlobalKey();
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Container(
          key: _widgetKey,
          child: widget.child,
        ),
      ),
    );
  }

  void _notifySize() {
    final context = _widgetKey.currentContext;
    if (context == null) return;
    final size = context.size;
    if (_oldSize != size) {
      _oldSize = size;
      widget.onSizeChange(size!);
    }
  }
}
