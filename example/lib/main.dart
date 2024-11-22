import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stun_slider/stun_slider.dart';
import 'package:stun_slider_example/slider_item.dart';
import 'package:stun_slider_example/slider_item_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final StunSliderController _controller;

  final List<SliderItem> _items = [
    SliderItem.random(),
    SliderItem.random(),
    SliderItem.random(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = StunSliderController(PageController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stun Slider Demo App'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              _items.add(SliderItem.random());
              _controller.jumpToIndex(_items.length - 1);

              setState(() {});
            },
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            child: const Icon(Icons.minimize),
            onPressed: () {
              final random = Random();
              _items.removeAt(random.nextInt(_items.length));
              _controller.jumpToIndex(_items.length - 1);
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StunSliderWidget.builder(
            itemCount: _items.length,
            itemBuilder: (_, index) {
              return SliderItemWidget(
                item: _items[index],
              );
            },
            controller: _controller,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              StunSliderNavButton(
                direction: StunSliderNavDirection.prev,
                itemCount: _items.length,
                controller: _controller,
                child: const Icon(Icons.arrow_back),
              ),
              StunSliderPagination(
                controller: _controller,
                itemBuilder: (context, index, isActive) {
                  return Container(
                    height: 40,
                    width: 40,
                    color: isActive ? Colors.amber : Colors.grey,
                    child: Center(child: Text('$index')),
                  );
                },
                itemCount: _items.length,
              ),
              StunSliderNavButton(
                direction: StunSliderNavDirection.next,
                itemCount: _items.length,
                controller: _controller,
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          const SizedBox(height: 16),
          StunSliderHelper(
            controller: _controller,
            itemBuilder: (_, index) {
              return Text('${index + 1} / ${_items.length}');
            },
          ),
        ],
      ),
    );
  }
}
