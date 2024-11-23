part of 'stun_slider.dart';

class StunSliderPagination extends StatefulWidget {
  final StunSliderController controller;
  final Widget Function(BuildContext context, int index, bool isActive)
      itemBuilder;

  final int itemCount;
  final double spacing;
  final Axis scrollDirection;

  const StunSliderPagination({
    super.key,
    required this.controller,
    required this.itemBuilder,
    required this.itemCount,
    this.spacing = 8,
    this.scrollDirection = Axis.horizontal,
  });

  @override
  State<StunSliderPagination> createState() => _StunSliderPaginationState();
}

class _StunSliderPaginationState extends State<StunSliderPagination> {
  @override
  void initState() {
    widget.controller.addListener(_listener);
    super.initState();
  }

  void _listener() => setState(() {});

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount < 2) return const SizedBox.shrink();
    switch (widget.scrollDirection) {
      case Axis.horizontal:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: _buildChildren(
            EdgeInsets.symmetric(horizontal: widget.spacing),
          ),
        );
      case Axis.vertical:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: _buildChildren(
            EdgeInsets.symmetric(vertical: widget.spacing),
          ),
        );
    }
  }

  List<Widget> _buildChildren(EdgeInsets margin) {
    return List.generate(
      widget.itemCount,
      (index) {
        return Container(
          margin: margin,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => widget.controller.jumpToIndex(index),
              child: widget.itemBuilder(
                context,
                index,
                _isActive(index),
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isActive(int index) {
    return index == widget.controller.index;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }
}
