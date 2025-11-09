import 'package:flutter/material.dart';

class ChapterSelectorDialog extends StatelessWidget {
  final List<int> chapters;
  final int current;

  const ChapterSelectorDialog({super.key, required this.chapters, required this.current});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Chapter'),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.count(
          crossAxisCount: 5,
          shrinkWrap: true,
          children: chapters.map((ch) {
            final isSelected = ch == current;
            return GestureDetector(
              onTap: () => Navigator.pop(context, ch),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isSelected ? Theme.of(context).primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '$ch',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}