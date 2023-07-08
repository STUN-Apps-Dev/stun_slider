import 'package:flutter/material.dart';
import 'package:stun_slider/stun_slider.dart';

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
  static const colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
  ];

  late final StunSliderController _controller;

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StunSliderWidget(
            itemCount: colors.length,
            itemBuilder: (_, index) {
              return Container(
                height: index == 1 ? 500 : 300,
                width: 300,
                color: colors[index],
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
                itemCount: colors.length,
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
                itemCount: colors.length,
              ),
              StunSliderNavButton(
                direction: StunSliderNavDirection.next,
                itemCount: colors.length,
                controller: _controller,
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          const SizedBox(height: 16),
          StunSliderHelper(
            controller: _controller,
            itemBuilder: (_, index) {
              return Text('${index + 1} / ${colors.length}');
            },
          ),
        ],
      ),
    );
  }
}
