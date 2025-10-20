import 'package:flutter/material.dart';
import 'package:bit_markdown/bit_markdown.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BitMarkdown Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int _selectedIndex = 0;

  final List<String> _demos = [_basicDemo, _documentDemo, _largeDemo];

  final List<String> _titles = [
    'Basic Example',
    'Document Example',
    'Large Document (1000+ lines)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BitMarkdown(
          _demos[_selectedIndex],
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          spacing: Spacing.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
          onLinkTap: (url) {
            // TODO: Create launchURL method
          },
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.article_outlined),
            selectedIcon: Icon(Icons.article),
            label: 'Basic',
          ),
          NavigationDestination(
            icon: Icon(Icons.description_outlined),
            selectedIcon: Icon(Icons.description),
            label: 'Document',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.list_alt),
            label: 'Large',
          ),
        ],
      ),
    );
  }
}

// Basic Demo
const String _basicDemo = '''
# Welcome to BitMarkdown

This is a **minimal** and *fast* markdown renderer for Flutter.

## Features

- Headings (H1-H6)
- **Bold** and *italic* text
- Unordered lists
- Ordered lists
- Tables

## Lists

### Unordered List
- First item
- Second item
- Third item

### Ordered List
1. Step one
2. Step two
3. Step three

## Tables

| Feature | Status |
| Fast | ✓ |
| Minimal | ✓ |
| Extensible | ✓ |

---

**That's it!** Simple and clean.
''';

// Document Demo
const String _documentDemo = '''
# Project Documentation

## Overview

This project demonstrates **BitMarkdown** capabilities with a realistic document structure.

## Installation

Follow these steps:

1. Add dependency to pubspec.yaml
2. Run flutter pub get
3. Import the package
4. Start using it

## API Reference

### BitMarkdown Widget

The main widget accepts the following parameters:

- **data**: The markdown string to render
- **style**: Optional text style for customization
- **shrinkWrap**: Set to true for nested scrollables

### Example Usage

Simply pass your markdown string:

*Note: This is italic text in a note*

## Performance

BitMarkdown uses **ListView.builder** for optimal performance:

| Lines | Performance |
| 1,000 | Instant |
| 10,000 | Smooth |
| 100,000+ | Still works |

## Best Practices

- Keep markdown strings organized
- Use custom styling when needed
- Leverage the modular architecture
- Add features through the element system

## Support

For issues or questions:

- Check the README
- Look at examples
- Open an issue on GitHub

---

**Happy coding!** 🚀
''';

// Large Demo (generates 1000+ lines)
String get _largeDemo {
  final buffer = StringBuffer();

  buffer.writeln('# Performance Test Document\n');
  buffer.writeln(
    'This document contains **1000+ lines** to test performance.\n',
  );

  for (int i = 1; i <= 50; i++) {
    buffer.writeln('## Section $i\n');
    buffer.writeln('This is section number **$i** of the document.\n');
    buffer.writeln('### Subsection $i.1\n');
    buffer.writeln('Some *italic* text in subsection $i.1\n');

    buffer.writeln('#### List $i\n');
    for (int j = 1; j <= 5; j++) {
      buffer.writeln('- Item $j in section $i');
    }
    buffer.writeln('');

    buffer.writeln('#### Numbered List $i\n');
    for (int j = 1; j <= 5; j++) {
      buffer.writeln('$j. Step $j in section $i');
    }
    buffer.writeln('');

    if (i % 10 == 0) {
      buffer.writeln('| Section | Status |');
      buffer.writeln('| $i | Complete |');
      buffer.writeln('');
    }
  }

  buffer.writeln('---\n');
  buffer.writeln('**End of document.** Total sections: 50\n');
  buffer.writeln('*Scroll performance should still be smooth!*');

  return buffer.toString();
}
