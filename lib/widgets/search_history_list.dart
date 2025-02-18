import 'package:flutter/material.dart';

class SearchHistoryList extends StatelessWidget {
  final List<String> searchHistory;
  final Function(String) onSearchSelected;
  final Function(String) onSearchRemoved;
  final VoidCallback onClearHistory;

  const SearchHistoryList({
    Key? key,
    required this.searchHistory,
    required this.onSearchSelected,
    required this.onSearchRemoved,
    required this.onClearHistory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        'Building SearchHistoryList with history: $searchHistory'); // Debug print
    if (searchHistory.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Riwayat Pencarian',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: onClearHistory,
              child: const Text('Hapus Riwayat'),
            ),
          ],
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: searchHistory.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () => onSearchSelected(searchHistory[index]),
                  child: Chip(
                    label: Text(searchHistory[index]),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () => onSearchRemoved(searchHistory[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
