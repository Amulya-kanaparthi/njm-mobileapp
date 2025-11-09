import 'package:flutter/material.dart';
import 'package:njm_mobileapp/network/bible_service.dart';
import 'package:njm_mobileapp/screens/tab_screens/chapter_selector_dialog.dart';

class BibleVerseScreen extends StatefulWidget {
  final String language;
  final String book;
  const BibleVerseScreen({
    super.key,
    required this.book,
    required this.language,
  });

  @override
  State<BibleVerseScreen> createState() => _BibleVerseScreenState();
}

class _BibleVerseScreenState extends State<BibleVerseScreen> {
  int _currentChapter = 1;
  Map<String, dynamic> verses = {};
  List<int> chapters = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadChapters();
  }

  Future<void> loadChapters() async {
  setState(() => _isLoading = true);

  try {
    // Wait for chapters
    chapters = BibleService.getChapters(widget.book);
    await loadVerses();
  } catch (e) {
    print("Error loading chapters: $e");
  } finally {
    setState(() => _isLoading = false);
  }
}

  void changeChapter(int newChapter) {
    if (newChapter < 1 || newChapter > chapters.length) return;
    setState(() {
      _currentChapter = newChapter;
    });
    loadVerses();
  }

  Future<void> loadVerses() async {
    setState(() => _isLoading = true);
    try {
      verses = BibleService.getVerses(widget.book, _currentChapter);
    } catch (e) {
      print("Error loading verses: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void showChapterSelector() async {
    final selected = await showDialog<int>(
      context: context,
      builder: (_) =>
          ChapterSelectorDialog(chapters: chapters, current: _currentChapter),
    );
    if (selected != null && selected != _currentChapter) {
      changeChapter(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.book}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: showChapterSelector,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: verses.length,
              itemBuilder: (_, i) {
                final verseNum = verses.keys.elementAt(i);
                final verseText = verses[verseNum];
                return ListTile(
                  leading: Text(verseNum),
                  title: Text(verseText),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => changeChapter(_currentChapter - 1),
            ),
            Text('Chapter $_currentChapter of ${chapters.length}'),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () => changeChapter(_currentChapter + 1),
            ),
          ],
        ),
      ),
    );
  }
}
