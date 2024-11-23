import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

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
      color: Color(
        (math.Random().nextDouble() * 0xFFFFFF).toInt(),
      ).withOpacity(1.0),
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
