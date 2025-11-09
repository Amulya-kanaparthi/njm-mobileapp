import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:njm_mobileapp/constants/key_constants.dart';
import 'package:njm_mobileapp/constants/string_constants.dart';
import 'package:njm_mobileapp/network/api_handler.dart';
import 'package:njm_mobileapp/network/end_point.dart';

class BibleService {
  static Map<String, dynamic>? _bibleCache;

  /// Load from API or local Hive
  static Future<void> fetchBibleFromAPI(String language) async {
    final box = await Hive.openBox(BoxTitleStrConstants.bibleBox);
    final key = 'bible_$language';

    // Load from local if available
    if (box.containsKey(key)) {
      final cached = box.get(key);
      _bibleCache = Map<String, dynamic>.from(jsonDecode(cached));
      print("Loaded $language Bible from local Hive storage");
      return;
    }

    try {
      final endPoint = ApiHandler.buildEndpoint(EndPoint.getFullBible, {
        KeyConstants.language: language,
      });

      final response = await ApiHandler.getRequest(endPoint);

      if (response["status"] == 1) {
        final data = response["data"];
        _bibleCache = Map<String, dynamic>.from(data);
        await box.put(key, jsonEncode(data));
        print("Bible saved locally to Hive");
      } else {
        throw Exception(
          response[KeyConstants.message] ?? "Failed to fetch Bible",
        );
      }
    } catch (e) {
      print("Error fetching Bible: $e");
      rethrow;
    }
  }

  /// Is Bible available in cache?
  static bool isBibleLoaded() => _bibleCache != null;

  /// Get all books
  static List<String> getBooks() {
    if (_bibleCache == null) throw Exception("Bible not loaded");
    return _bibleCache!.keys.toList();
  }

  /// Get chapters in a book
  static List<int> getChapters(String book) {
    if (_bibleCache == null) throw Exception("Bible not loaded");

    final chapters = _bibleCache![book];
    if (chapters == null) throw Exception("Book not found");
    final chapterNumbers = chapters.keys
        .map((key) => int.tryParse(key.toString()))
        .where((num) => num != null)
        .cast<int>()
        .toList();

    chapterNumbers.sort();
    return chapterNumbers;
  }

  /// Get verses of a chapter
  static Map<String, String> getVerses(String book, int chapter) {
    if (_bibleCache == null) throw Exception("Bible not loaded");
    final chapters = _bibleCache![book];
    if (chapters == null || !chapters.containsKey(chapter.toString())) {
      throw Exception("Chapter not found");
    }
    return Map<String, String>.from(chapters[chapter.toString()]);
  }

  /// Clear local Bible cache
  static Future<void> clearBibleCache(String language) async {
    final box = await Hive.openBox(BoxTitleStrConstants.bibleBox);
    await box.delete('bible_$language');
    _bibleCache = null;
    print("🧹 Cleared cached Bible for $language");
  }
}
