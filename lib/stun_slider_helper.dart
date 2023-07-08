part of 'stun_slider.dart';

class StunSliderHelper extends StatefulWidget {
  final StunSliderController controller;
  final Widget Function(BuildContext context, int index) itemBuilder;
  const StunSliderHelper({
    Key? key,
    required this.controller,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  State<StunSliderHelper> createState() => _StunSliderHelperState();
}

class _StunSliderHelperState extends State<StunSliderHelper> {
  @override
  void initState() {
    widget.controller.addListener(_listener);
    super.initState();
  }

  void _listener() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return widget.itemBuilder(context, widget.controller.index);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }
}
