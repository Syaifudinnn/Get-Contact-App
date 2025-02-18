import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_contact_app/blocs/info/info_bloc.dart';
import 'package:get_contact_app/core/service/search_history_service.dart';
import 'package:get_contact_app/models/search_response.dart';
import 'package:get_contact_app/widgets/search_form.dart';
import 'package:get_contact_app/widgets/search_history_list.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  InfoPageState createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SearchHistoryService _searchHistoryService = SearchHistoryService();
  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    final history = await _searchHistoryService.getSearchHistory();
    print('Loading history: $history'); // Debug print
    setState(() {
      searchHistory = history;
    });
  }

  Future<void> _performSearch(String query) async {
    if (_formKey.currentState!.validate()) {
      await _searchHistoryService.addSearch(query);
      await _loadSearchHistory();
      context.read<InfoBloc>().add(SearchContact(query));
      print('Current history after search: $searchHistory'); // Debug print
    }
  }

  Future<void> _removeSearchItem(String query) async {
    await _searchHistoryService.removeSearch(query);
    await _loadSearchHistory();
    print('History after removal: $searchHistory'); // Debug print
  }

  Future<void> _clearHistory() async {
    await _searchHistoryService.clearHistory();
    await _loadSearchHistory();
    print('History after clearing: $searchHistory'); // Debug print
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchForm(
              controller: _searchController,
              formKey: _formKey,
              onSearch: () => _performSearch(_searchController.text),
            ),
            SearchHistoryList(
              searchHistory: searchHistory,
              onSearchSelected: (query) {
                _searchController.text = query;
                _performSearch(query);
              },
              onSearchRemoved: _removeSearchItem,
              onClearHistory: _clearHistory,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocProvider.value(
                value: context.read<InfoBloc>(),
                child: BlocConsumer<InfoBloc, InfoState>(
                  listener: (context, state) {
                    if (state is InfoError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is InfoLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is InfoLoaded) {
                      return ListView.builder(
                        itemCount: state.contacts.length,
                        itemBuilder: (context, index) {
                          final SearchResponse contact = state.contacts[index];
                          return Card(
                            child: ListTile(
                              leading:
                                  const Icon(Icons.person, color: Colors.blue),
                              title: Text(contact.contactName ?? 'Unknown'),
                              subtitle: Text(
                                  contact.contactPhone ?? 'No phone number'),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                        child: Text('Masukkan kata kunci pencarian'));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
