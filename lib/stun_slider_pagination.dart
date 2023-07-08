part of 'stun_slider.dart';

class StunSliderPagination extends StatefulWidget {
  final StunSliderController controller;
  final Widget Function(BuildContext context, int index, bool isActive)
      itemBuilder;
  final int itemCount;
  final double spacing;
  const StunSliderPagination({
    Key? key,
    required this.controller,
    required this.itemBuilder,
    required this.itemCount,
    this.spacing = 16,
  }) : super(key: key);

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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.itemCount,
        (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
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
      ),
    );
  }

  bool _isActive(int index) {
    return index == widget.controller.index;
  }
}
