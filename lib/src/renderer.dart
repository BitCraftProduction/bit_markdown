// lib/src/renderer.dart
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

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

  static Widget renderHorizontalLine() {
    return Divider(height: 1.0, thickness: 1.0);
  }

  static Widget renderTableRow(List<String> cells) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1)),
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

  static Widget renderBlockQuote(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(border: Border(left: BorderSide(width: 1))),
      child: Text(text, style: TextStyle(fontStyle: FontStyle.italic)),
    );
  }

  static Widget renderCodeBlock(String code, {String? language}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 230, 230, 230),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (language != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  language,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            Text(
              code,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  static Widget renderMathBlock(String expression) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      child: Math.tex(
        expression,
        textStyle: const TextStyle(fontSize: 20),
        mathStyle: MathStyle.display,
      ),
    );
  }

  static Widget renderMathInline(String expression) {
    return Math.tex(
      expression,
      textStyle: const TextStyle(fontSize: 16),
      mathStyle: MathStyle.text,
    );
  }

  static Widget renderText(String text, TextStyle? style) {
    final spans = <InlineSpan>[];
    var i = 0;

    while (i < text.length) {
      // Bold (** or __)
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
      } else if (text.startsWith('__', i)) {
        final end = text.indexOf('__', i + 2);
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
      } else if (text.startsWith('_', i) && !text.startsWith('__', i)) {
        final end = text.indexOf('_', i + 1);
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

      //Strikethrough
      if (text.startsWith('~~', i)) {
        if (text.startsWith('~~', i)) {
          final end = text.indexOf('~~', i + 2);
          if (end != -1) {
            spans.add(
              TextSpan(
                text: text.substring(i + 2, end),
                style: const TextStyle(decoration: TextDecoration.lineThrough),
              ),
            );
            i = end + 2;
            continue;
          }
        }
      }

      // Inline Code
      if (text.startsWith('`', i)) {
        final end = text.indexOf('`', i + 1);
        if (end != -1) {
          spans.add(
            TextSpan(
              text: text.substring(i + 1, end),
              style: const TextStyle(
                fontFamily: 'monospace',
                backgroundColor: Color.fromARGB(255, 230, 230, 230),
              ),
            ),
          );
          i = end + 1;
          continue;
        }
      }

      // Inline Math
      if (text.startsWith('\$', i) && !text.startsWith('\$\$', i)) {
        final end = text.indexOf('\$', i + 1);
        if (end != -1) {
          spans.add(
            WidgetSpan(
              // alignment: PlaceholderAlignment.middle,
              child: Math.tex(
                text.substring(i + 1, end),
                mathStyle: MathStyle.text,
                textStyle: const TextStyle(fontSize: 16),
              ),
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

    final inlineCode = text.indexOf('`', start);
    if (inlineCode != -1 && inlineCode < pos) pos = inlineCode;

    final strike = text.indexOf('~~', start);
    if (strike != -1 && strike < pos) pos = strike;

    final inlineMath = text.indexOf('\$', start);
    if (inlineMath != -1 && inlineMath < pos) pos = inlineMath;

    return pos;
  }
}
