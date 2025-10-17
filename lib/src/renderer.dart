// lib/src/renderer.dart
import 'package:flutter/material.dart';

class MarkdownRenderer {
  static Widget renderHeading(String text, int level) {
    final size = 24.0 - (level * 2);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
      ),
    );
  }

  static Widget renderListItem(String text, bool ordered) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ordered ? '• ' : '• '),
          Expanded(child: renderText(text, null)),
        ],
      ),
    );
  }

  static Widget renderTableRow(List<String> cells) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: cells
            .map(
              (cell) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: renderText(cell, null),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  static Widget renderText(String text, TextStyle? style) {
    final spans = <TextSpan>[];
    var i = 0;

    while (i < text.length) {
      // Bold
      if (text.startsWith('**', i)) {
        final end = text.indexOf('**', i + 2);
        if (end != -1) {
          spans.add(
            TextSpan(
              text: text.substring(i + 2, end),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
          i = end + 2;
          continue;
        }
      }

      // Italic
      if (text.startsWith('*', i) && !text.startsWith('**', i)) {
        final end = text.indexOf('*', i + 1);
        if (end != -1) {
          spans.add(
            TextSpan(
              text: text.substring(i + 1, end),
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          );
          i = end + 1;
          continue;
        }
      }

      // Regular
      final next = _findNext(text, i);
      spans.add(TextSpan(text: text.substring(i, next)));
      i = next;
    }

    return RichText(
      text: TextSpan(
        style: style ?? const TextStyle(fontSize: 16, color: Colors.black),
        children: spans,
      ),
    );
  }

  static int _findNext(String text, int start) {
    var pos = text.length;

    final bold = text.indexOf('**', start);
    if (bold != -1 && bold < pos) pos = bold;

    final italic = text.indexOf('*', start);
    if (italic != -1 && italic < pos) pos = italic;

    return pos;
  }
}
