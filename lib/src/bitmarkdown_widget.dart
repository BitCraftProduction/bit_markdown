// lib/src/bitmarkdown_widget.dart
import 'package:bit_markdown/src/elements.dart';
import 'package:bit_markdown/src/models/spacing.dart';
import 'package:bit_markdown/src/parser.dart';
import 'package:flutter/material.dart';

class BitMarkdown extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final bool shrinkWrap;
  final Spacing? spacing;
  final void Function(String url)? onLinkTap;

  const BitMarkdown(
    this.data, {
    super.key,
    this.style,
    this.shrinkWrap = false,
    this.spacing,
    this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    final elements = MarkdownParser.parseDocument(data);

    return ListView.builder(
      shrinkWrap: shrinkWrap,
      itemCount: elements.length,
      itemBuilder: (context, index) {
        final element = elements[index];
        if (element is LinkElement) {
          element.onTap = onLinkTap;
        }
        return elements[index].render(spacing: spacing);
      },
    );
  }
}
