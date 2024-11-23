import 'package:example/horizontal_example.dart';
import 'package:example/vertical_example.dart';
import 'package:flutter/material.dart';

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
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stun Slider Demo App'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (value) => setState(() => _currentPage = value),
        items: const [
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'Horizontal',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'Vertical',
          ),
        ],
      ),
      body: Card(
        margin: const EdgeInsets.all(24),
        elevation: 10,
        child: [
          const HorizontalExample(),
          const VerticalExample(),
        ][_currentPage],
      ),
    );
  }
}
