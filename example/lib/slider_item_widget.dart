import 'package:flutter/material.dart';
import 'package:stun_slider_example/slider_item.dart';

class SliderItemWidget extends StatefulWidget {
  final SliderItem item;
  const SliderItemWidget({super.key, required this.item});

  @override
  State<SliderItemWidget> createState() => _SliderItemWidgetState();
}

class _SliderItemWidgetState extends State<SliderItemWidget> {
  var _item = SliderItem.random();

  @override
  void initState() {
    super.initState();
    _item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _item.height,
      width: _item.width,
      color: _item.color,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              _item = _item.copyWith(height: _item.height + 20);
              setState(() {});
            },
            icon: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {
              _item = _item.copyWith(height: _item.height - 20);
              setState(() {});
            },
            icon: const Icon(Icons.minimize),
          ),
        ],
      ),
    );
  }
}
