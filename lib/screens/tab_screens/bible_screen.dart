import 'package:flutter/material.dart';
import 'package:njm_mobileapp/constants/image_constants.dart';
import 'package:njm_mobileapp/constants/key_constants.dart';
import 'package:njm_mobileapp/constants/string_constants.dart';
import 'package:njm_mobileapp/network/bible_service.dart';
import 'package:njm_mobileapp/screens/tab_screens/bible_verse_screen.dart';
import 'package:njm_mobileapp/utility/font_helper.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({super.key});

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  String selectedLanguage = "telugu";
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
        books = BibleService.getBooks();
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
      appBar: AppBar(
        title: selectedLanguage == KeyConstants.telugu 
        ? Text(StringConstants.teluguBibleTitle,style: FontHelper.getTextStyle(language: selectedLanguage,fontSize: 24,fontWeight: FontWeight.w600),) 
        : Text(StringConstants.englishBibleTitle,style: FontHelper.getTextStyle(language: selectedLanguage,fontSize: 24,fontWeight: FontWeight.w600),),
        actions: [
          PopupMenuButton<String>(
            icon: const Image(image: AssetImage(ImageConstants.languageIcon)),
            onSelected: (lang) {
              setState(() => selectedLanguage = lang);
              _loadBibleData();
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: "english", child: Text("English")),
              PopupMenuItem(value: "telugu", child: Text("Telugu")),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (_, i) => Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(
                    books[i],
                    style: FontHelper.getTextStyle(
                      language: selectedLanguage,
                      fontSize: 18,
                    ),
                  ),
                  trailing:
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BibleVerseScreen(
                          language: selectedLanguage,
                          book: books[i],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
