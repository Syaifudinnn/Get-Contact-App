import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_contact_app/blocs/info/info_bloc.dart';
import 'package:get_contact_app/models/search_response.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  InfoPageState createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Cari kontak...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan kata kunci pencarian';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<InfoBloc>()
                            .add(SearchContact(_searchController.text));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                    ),
                    child: const Text(
                      'Cari',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
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
