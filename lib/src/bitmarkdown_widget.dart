// lib/src/bitmarkdown_widget.dart
import 'package:bit_markdown/src/parser.dart';
import 'package:flutter/material.dart';


class BitMarkdown extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final bool shrinkWrap;

  const BitMarkdown(
    this.data, {
    super.key,
    this.style,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    final lines = data
        .split('\n')
        .where((l) => l.trim().isNotEmpty)
        .map((l) => l.trim())
        .toList();

    return ListView.builder(
      shrinkWrap: shrinkWrap,
      itemCount: lines.length,
      itemBuilder: (context, index) {
        final element = MarkdownParser.parse(lines[index]);
        return element.render();
      },
    );
  }
}