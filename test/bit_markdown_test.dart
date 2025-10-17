import 'package:flutter/material.dart';
import 'package:bit_markdown/bit_markdown.dart';

void main() => runApp(const MyApp());

/// MyApp demonstrates how to use the BitMarkdown package.
/// 
/// BitMarkdown is a minimal, fast, and Flutter-friendly Markdown renderer
/// that supports headings, bold/italic text, lists, nested lists, and tables.
/// It is designed to handle large Markdown content efficiently without converting
/// to HTML.
///
/// This example showcases:
/// - Headings from H1 to H6
/// - Bold and italic text
/// - Ordered and unordered lists, including nested lists
/// - Tables
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BitMarkdown Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('BitMarkdown Demo')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: BitMarkdown(
            '''
# Welcome to BitMarkdown

BitMarkdown is a **minimal** and *fast* Markdown renderer for Flutter. 

## Features

- Headings (H1 to H6)
- Bold (**bold**) and Italic (*italic*) text
- Unordered lists
- Ordered lists
- Nested lists
- Tables
- Optimized for performance

## Examples

### Unordered List

- Item 1
- Item 2
  - Nested Item 2.1
  - Nested Item 2.2
- Item 3

### Ordered List

1. First
2. Second
   1. Sub-first
   2. Sub-second
3. Third

### Table

| Name    | Age |
|---------|-----|
| Alice   | 25  |
| Bob     | 30  |
| Charlie | 22  |

## Conclusion

BitMarkdown lets you render Markdown **directly in Flutter** without HTML conversion.
It is lightweight and perfect for large notes, documentation, or learning apps.
            '''
          ),
        ),
      ),
    );
  }
}
