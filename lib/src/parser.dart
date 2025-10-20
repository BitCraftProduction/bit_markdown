import 'package:bit_markdown/src/elements.dart';

class MarkdownParser {
  // Multiline parser
  static List<MarkdownElement> parseDocument(String text) {
    final lines = text.split('\n');
    final elements = <MarkdownElement>[];

    var i = 0;
    while (i < lines.length) {
      final line = lines[i].trim();

      if (line.isEmpty) {
        i++;
        continue;
      }

      // Code block
      if (line.startsWith('```')) {
        final language = line.substring(3).trim();
        final codeLines = <String>[];
        i++;

        while (i < lines.length && !lines[i].trim().startsWith('```')) {
          codeLines.add(lines[i]);
          i++;
        }

        elements.add(
          CodeBlockElement(
            codeLines.join('\n'),
            language: language.isEmpty ? null : language,
          ),
        );
        i++;
        continue;
      }

      // Block Math $$...$$
      if (line.startsWith(r'$$')) {
        final mathLines = <String>[];
        i++;
        while (i < lines.length && !lines[i].trim().startsWith(r'$$')) {
          mathLines.add(lines[i]);
          i++;
        }

        elements.add(MathBlockElement(mathLines.join('\n').trim()));
        i++;
        continue;
      }

      elements.add(parseLine(line));
      i++;
    }

    return elements;
  }

  // Line by line parser
  static MarkdownElement parseLine(String line) {
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

    // Block quote
    if (line.startsWith('> ')) {
      return BlockQuoteElement(line.substring(2));
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

    // Horizontal line
    if (line.startsWith('---') || line.startsWith('***')) {
      return HorizontalLine();
    }

    final imageMatch = RegExp(
      r'!\[(.*?)\]\((.*?)(?:\s+"(.*?)")?\)',
    ).firstMatch(line);
    if (imageMatch != null) {
      final alt = imageMatch.group(1) ?? '';
      final url = imageMatch.group(2) ?? '';
      final title = imageMatch.group(3);
      return ImageElement(alt, url, title: title);
    }

    // Default text
    return TextElement(line);
  }
}
