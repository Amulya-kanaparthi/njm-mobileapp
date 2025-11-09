import 'package:flutter/material.dart';
import 'package:njm_mobileapp/network/bible_service.dart';
import 'package:njm_mobileapp/screens/tab_screens/bible_verse_screen.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({super.key});

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  String selectedLanguage = "english";
  String? selectedBook;
  int? selectedChapter;

  List<String> books = [];
  List<int> chapters = [];
  Map<String, dynamic> bibleData = {};

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadBibleData();
  }


  Future<void> _loadBibleData() async{
    setState(() {  
      _isLoading = true;
    });
    try {
      await BibleService.fetchBibleFromAPI(selectedLanguage);
      setState(() {
      });
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Card(
                    elevation: 5, // 👈 gives the elevated effect
                    shadowColor: Colors.black.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      title: Text(
                        book,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BibleVerseScreen(
                              language: selectedLanguage,
                              book: book,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
