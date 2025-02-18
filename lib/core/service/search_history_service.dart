import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  static const String _storageKey = 'search_history';
  static const int _maxHistoryItems = 10;

  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_storageKey) ?? [];
    print('Getting history: $history'); // Debug print
    return history;
  }

  Future<void> addSearch(String query) async {
    if (query.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    List<String> history = await getSearchHistory();
    print('Before adding: $history'); // Debug print

    history.remove(query);
    history.insert(0, query);
    if (history.length > _maxHistoryItems) {
      history = history.sublist(0, _maxHistoryItems);
    }

    await prefs.setStringList(_storageKey, history);
    print('After adding: $history'); // Debug print
  }

  Future<void> removeSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = await getSearchHistory();
    history.remove(query);
    await prefs.setStringList(_storageKey, history);
    print('After removing: $history'); // Debug print
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
    print('History cleared'); // Debug print
  }
}
