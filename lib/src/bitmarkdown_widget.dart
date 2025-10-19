// lib/src/bitmarkdown_widget.dart
import 'package:bit_markdown/src/models/spacing.dart';
import 'package:bit_markdown/src/parser.dart';
import 'package:flutter/material.dart';

class BitMarkdown extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final bool shrinkWrap;
  final Spacing? spacing;

  const BitMarkdown(
    this.data, {
    super.key,
    this.style,
    this.shrinkWrap = false,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    final elements = MarkdownParser.parseDocument(data);

    return ListView.builder(
      shrinkWrap: shrinkWrap,
      itemCount: elements.length,
      itemBuilder: (context, index) {
        return elements[index].render(spacing: spacing);
      },
    );
  }
}
