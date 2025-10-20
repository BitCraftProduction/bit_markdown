import 'package:bit_markdown/bit_markdown.dart';
import 'package:flutter/material.dart';

abstract class MarkdownElement {
  Widget render({Spacing? spacing}) {
    final child = buildWidget();
    final edgeInsets =
        spacing?.toEdgeInsets() ?? const EdgeInsets.only(top: 0, bottom: 8);
    return Padding(padding: edgeInsets, child: child);
  }

  Widget buildWidget();
}

class TextElement extends MarkdownElement {
  final String text;
  final TextStyle? style;

  TextElement(this.text, {this.style});

  @override
  Widget buildWidget() => MarkdownRenderer.renderText(text, style);
}

class HeadingElement extends MarkdownElement {
  final String text;
  final int level;

  HeadingElement(this.text, this.level);

  @override
  Widget buildWidget() => MarkdownRenderer.renderHeading(text, level);
}

class BlockQuoteElement extends MarkdownElement {
  final String text;

  BlockQuoteElement(this.text);

  @override
  Widget buildWidget() => MarkdownRenderer.renderBlockQuote(text);
}

class ListItemElement extends MarkdownElement {
  final String text;
  final bool ordered;

  ListItemElement(this.text, {this.ordered = false});

  @override
  Widget buildWidget() => MarkdownRenderer.renderListItem(text, ordered);
}

class HorizontalLine extends MarkdownElement {
  @override
  Widget buildWidget() => MarkdownRenderer.renderHorizontalLine();
}

class TableRowElement extends MarkdownElement {
  final List<String> cells;
  TableRowElement(this.cells);

  @override
  Widget buildWidget() => MarkdownRenderer.renderTableRow(cells);
}

class CodeBlockElement extends MarkdownElement {
  final String code;
  final String? language;
  CodeBlockElement(this.code, {this.language});

  @override
  Widget buildWidget() =>
      MarkdownRenderer.renderCodeBlock(code, language: language);
}

class MathBlockElement extends MarkdownElement {
  final String expression;
  MathBlockElement(this.expression);

  @override
  Widget buildWidget() => MarkdownRenderer.renderMathBlock(expression);
}

class MathInlineElement extends MarkdownElement {
  final String expression;
  MathInlineElement(this.expression);

  @override
  Widget buildWidget() => MarkdownRenderer.renderMathInline(expression);
}

class ImageElement extends MarkdownElement {
  final String alt;
  final String url;
  final String? title;

  ImageElement(this.alt, this.url, {this.title});
  @override
  Widget buildWidget() =>
      MarkdownRenderer.renderImage(url, altText: alt, title: title);
}
