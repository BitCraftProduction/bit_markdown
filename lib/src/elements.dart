import 'package:bit_markdown/bit_markdown.dart';
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

class BlockQuoteElement extends MarkdownElement {
  final String text;

  BlockQuoteElement(this.text);

  @override
  Widget render() => MarkdownRenderer.renderBlockQuote(text);
}

class ListItemElement extends MarkdownElement {
  final String text;
  final bool ordered;

  ListItemElement(this.text, {this.ordered = false});

  @override
  Widget render() => MarkdownRenderer.renderListItem(text, ordered);
}

class HorizontalLine extends MarkdownElement {
  HorizontalLine();
  @override
  Widget render() => MarkdownRenderer.renderHorizontalLine();
}

class TableRowElement extends MarkdownElement {
  final List<String> cells;
  TableRowElement(this.cells);

  @override
  Widget render() => MarkdownRenderer.renderTableRow(cells);
}

class CodeBlockElement extends MarkdownElement {
  CodeBlockElement(this.code, {this.language});
  final String code;
  final String? language;

  @override
  Widget render() => MarkdownRenderer.renderCodeBlock(code, language: language);
}

class MathBlockElement extends MarkdownElement {
  MathBlockElement(this.expression);
  final String expression;
  @override
  Widget render() => MarkdownRenderer.renderMathBlock(expression);
}

class MathInlineElement extends MarkdownElement {
  MathInlineElement(this.expression);
  final String expression;
  @override
  Widget render() => MarkdownRenderer.renderMathInline(expression);
}
