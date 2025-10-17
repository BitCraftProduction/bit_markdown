
import 'package:bit_markdown/src/renderer.dart';
import 'package:flutter/material.dart';

abstract class MarkdownElement {
  Widget render();
}

class TextElement extends MarkdownElement {
  final String text;
  final TextStyle? style;
  
  TextElement(this.text, {this.style});
  
  @override
  Widget render() => MarkdownRenderer.renderText(text, style);
}

class HeadingElement extends MarkdownElement {
  final String text;
  final int level;
  
  HeadingElement(this.text, this.level);
  
  @override
  Widget render() => MarkdownRenderer.renderHeading(text, level);
}

class ListItemElement extends MarkdownElement {
  final String text;
  final bool ordered;
  
  ListItemElement(this.text, {this.ordered = false});
  
  @override
  Widget render() => MarkdownRenderer.renderListItem(text, ordered);
}

class TableRowElement extends MarkdownElement {
  final List<String> cells;
  
  TableRowElement(this.cells);
  
  @override
  Widget render() => MarkdownRenderer.renderTableRow(cells);
}

class MarkdownParser {
  static MarkdownElement parse(String line) {
    // Heading
    if (line.startsWith('#')) {
      final level = line.indexOf(' ');
      final text = line.substring(level + 1);
      return HeadingElement(text, level);
    }

    // Unordered list
    if (line.startsWith('- ')) {
      return ListItemElement(line.substring(2));
    }

    // Ordered list
    final numMatch = RegExp(r'^\d+\.\s+').firstMatch(line);
    if (numMatch != null) {
      return ListItemElement(line.substring(numMatch.end), ordered: true);
    }

    // Table
    if (line.startsWith('|') && line.endsWith('|')) {
      final cells = line
          .substring(1, line.length - 1)
          .split('|')
          .map((c) => c.trim())
          .toList();
      return TableRowElement(cells);
    }

    // Default text
    return TextElement(line);
  }
}