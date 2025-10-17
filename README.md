# BitMarkdown

BitMarkdown is a minimal, fast, and Flutter-friendly Markdown renderer that allows you to render Markdown content directly in Flutter widgets without converting it to HTML. It is lightweight and optimized for performance, making it suitable for large documents and mobile apps.


## Features

- **Blazing Fast** - Uses `ListView.builder` for optimal performance with large documents (1k-100k+ lines)
- **Minimal** - Clean, simple codebase with no dependencies
- **Extensible** - Modular architecture makes adding new features seamless
- **Lightweight** - Only ~300 lines of code

## Supported Markdown

- Headings (`#` to `######`)
- Bold (`**text**`) and Italic (`*text*`)
- Unordered lists (`- item`)
- Ordered lists (`1. item`)
- Tables (`| cell | cell |`)
- and more...

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  bitmarkdown: ^0.0.1
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:bit_markdown/bit_markdown.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BitMarkdown('''
# Hello World

This is **bold** and *italic* text.

- Item 1
- Item 2

| Col A | Col B |
| 1 | 2 |
        '''),
      ),
    );
  }
}
```

## Custom Styling

```dart
BitMarkdown(
  data,
  style: TextStyle(
    fontSize: 18,
    color: Colors.grey.shade800,
  ),
)
```

## Performance

BitMarkdown uses lazy loading with `ListView.builder`, so it can handle massive documents efficiently:

- 1,000 lines: Instant
- 10,000 lines: Smooth
- 100,000 lines: Still works

## Extending BitMarkdown

The modular architecture makes it easy to add new features:

### 1. Create a new element in `lib/src/parser.dart`:

```dart
class CodeBlockElement extends MarkdownElement {
  final String code;
  final String? language;
  
  CodeBlockElement(this.code, {this.language});
  
  @override
  Widget render() => MarkdownRenderer.renderCodeBlock(code, language);
}
```

### 2. Add parsing logic:

```dart
// In MarkdownParser.parse()
if (line.startsWith('```')) {
  return CodeBlockElement(extractCode(line));
}
```

### 3. Add renderer:

```dart
// In MarkdownRenderer
static Widget renderCodeBlock(String code, String? language) {
  return Container(
    padding: EdgeInsets.all(12),
    color: Colors.black87,
    child: Text(code, style: TextStyle(fontFamily: 'monospace')),
  );
}
```

That's it! No need to touch existing code.

## Architecture

```
lib/
├── bit_markdown.dart         # Main export
└── src/
    ├── bitmarkdown_widget.dart  # Main widget
    ├── parser.dart              # Parsing logic
    └── renderer.dart            # Rendering logic
```

**Separation of concerns:**
- `parser.dart` - Converts markdown strings to element objects
- `renderer.dart` - Converts elements to Flutter widgets
- `bitmarkdown_widget.dart` - Orchestrates everything

## Contributing

PRs welcome! Keep it minimal and fast.

## License

MIT License - see LICENSE file

## Author

Ganesh Kumar

Built with frustration and coffee ☕
