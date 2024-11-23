import 'package:example/slider_page_config.dart';
import 'package:example/slider_page.dart';
import 'package:flutter/material.dart';
import 'package:stun_slider/stun_slider.dart';

class VerticalExample extends StatefulWidget {
  const VerticalExample({super.key});

  @override
  State<VerticalExample> createState() => _VerticalExampleState();
}

class _VerticalExampleState extends State<VerticalExample> {
  final _controller = StunSliderController();

  final _items = [
    SliderItem.random(),
    SliderItem.random(),
    SliderItem.random(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton(
                onPressed: () {
                  if (_items.isEmpty) return;
                  setState(() {
                    _items.removeLast();
                  });
                  _controller.jumpToIndex(_items.length - 1);
                },
                child: const Text('Remove page'),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                child: const Text('Add new page'),
                onPressed: () {
                  setState(() {
                    _items.add(SliderItem.random());
                  });
                  _controller.jumpToIndex(_items.length - 1);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StunSlider.builder(
              itemCount: _items.length,
              itemBuilder: (_, index) {
                return SliderItemWidget(item: _items[index]);
              },
              controller: _controller,
              scrollDirection: Axis.vertical,
              scrollBehavior: const StunSliderScrollBehavior().copyWith(
                scrollbars: false,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StunSliderNavButton.prev(
                  itemCount: _items.length,
                  controller: _controller,
                  scrollDirection: Axis.vertical,
                ),
                StunSliderPagination(
                  controller: _controller,
                  spacing: 8,
                  itemBuilder: (context, index, isActive) {
                    return _PagintationItem(
                      color: isActive ? Colors.amber : Colors.blue,
                      title: '$index',
                    );
                  },
                  itemCount: _items.length,
                  scrollDirection: Axis.vertical,
                ),
                StunSliderNavButton.next(
                  itemCount: _items.length,
                  controller: _controller,
                  scrollDirection: Axis.vertical,
                ),
              ],
            ),
            const SizedBox(width: 16),
            StunSliderHelper(
              controller: _controller,
              itemBuilder: (_, index) {
                return Text('${index + 1} / ${_items.length}');
              },
              itemCount: _items.length,
            ),
          ],
        ),
      ),
    );
  }
}

class _PagintationItem extends StatelessWidget {
  final Color color;
  final String title;
  const _PagintationItem({
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Center(child: Text(title)),
      ),
    );
  }
}
