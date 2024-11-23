import 'package:flutter/material.dart';
import 'package:example/slider_page_config.dart';

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
    return Card(
      color: _item.color,
      child: SizedBox(
        height: _item.height,
        width: _item.width,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilledButton(
                onPressed: () {
                  if (_item.height - 20 < 0) return;
                  _item = _item.copyWith(height: _item.height - 20);
                  setState(() {});
                },
                child: const Text('height - 20'),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  _item = _item.copyWith(height: _item.height + 20);
                  setState(() {});
                },
                child: const Text('height + 20'),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
