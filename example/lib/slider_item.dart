import 'dart:math';

import 'package:flutter/material.dart';

class SliderItem {
  final double width;
  final double height;
  final Color color;

  SliderItem({required this.width, required this.height, required this.color});

  factory SliderItem.random() {
    final random = Random();

    return SliderItem(
      width: (200 + random.nextInt(200)).toDouble(),
      height: (200 + random.nextInt(200)).toDouble(),
      color: Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      ),
    );
  }

  SliderItem copyWith({
    double? width,
    double? height,
    Color? color,
  }) {
    return SliderItem(
      width: width ?? this.width,
      height: height ?? this.height,
      color: color ?? this.color,
    );
  }
}
