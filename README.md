# BitMarkdown

BitMarkdown is a minimal, fast, and Flutter-friendly Markdown renderer that allows you to render Markdown content directly in Flutter widgets without converting it to HTML. It is lightweight and optimized for performance, making it suitable for large documents and mobile apps. It now also supports **LaTeX** for both inline `$...$` and block `$$...$$` math expressions.

## Features

- **Blazing Fast** - Uses `ListView.builder` for optimal performance with large documents (1k-100k+ lines)
- **Minimal** - Clean, simple codebase with no dependencies
- **Extensible** - Modular architecture makes adding new features seamless
- **Lightweight** - Only ~300 lines of code
- **LaTeX Support** - Render inline and block math directly in Flutter widgets

## Supported Markdown

- Headings (`#` to `######`)
- Bold (`**text**`) and Italic (`*text*`)
- Unordered lists (`- item`)
- Ordered lists (`1. item`)
- Tables (`| cell | cell |`)
- Inline math (`$...$`)
- Block math (`$$...$$`)
- and more...

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  bitmarkdown: ^0.0.4
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
        body: BitMarkdown(
          r'''
# Hello World

This is **bold** and *italic* text.

Here is some inline math: $E = mc^2$.

$$
\int_0^\infty e^{-x^2} dx = \frac{\sqrt{\pi}}{2}
$$

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

> ⚠️ Attention: When using LaTeX in BitMarkdown, always wrap strings containing $ or $$ in raw string literals (r'...') to prevent Dart from interpreting $ as a variable:

## Performance

BitMarkdown uses lazy loading with `ListView.builder`, so it can handle massive documents efficiently:

* 1,000 lines: Instant
* 10,000 lines: Smooth
* 100,000 lines: Still works

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

* `parser.dart` - Converts markdown strings to element objects
* `renderer.dart` - Converts elements to Flutter widgets
* `bitmarkdown_widget.dart` - Orchestrates everything

## Contributing

PRs welcome! Keep it minimal and fast.

## License

MIT License - see LICENSE file

## Author

BitCraft Production
Built with frustration and coffee ☕
