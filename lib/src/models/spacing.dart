import 'package:flutter/material.dart';

class Spacing {
  final double top;
  final double bottom;
  final double left;
  final double right;

  const Spacing.only({
    this.top = 0.0,
    this.bottom = 8.0,
    this.left = 0.0,
    this.right = 0.0,
  });

  EdgeInsets toEdgeInsets() =>
      EdgeInsets.only(top: top, bottom: bottom, left: left, right: right);
}
