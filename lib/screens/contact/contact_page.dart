import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_contact_app/blocs/contact/contact_bloc.dart';
import 'package:get_contact_app/models/contact_response.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    super.initState();
    context.read<ContactBloc>().add(ContactFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambahkan fungsi tambah kontak
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[100]!, Colors.grey[200]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            if (state is ContactLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                ),
              );
            } else if (state is ContactLoaded) {
              return state.contacts.isEmpty
                  ? _buildEmptyState()
                  : RefreshIndicator(
                      onRefresh: () async {
                        context.read<ContactBloc>().add(ContactFetch());
                      },
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.contacts.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final contact = state.contacts[index];
                          return _buildContactCard(contact);
                        },
                      ),
                    );
            } else if (state is ContactError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.red, size: 50),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<ContactBloc>().add(ContactFetch()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Try Again',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildContactCard(Contact contact) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.person, color: Colors.blueAccent, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.contactName!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    contact.contactPhone!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.phone, color: Colors.green),
              onPressed: () {
                // Tambahkan fungsi panggilan
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty-contacts.png', width: 200),
          const SizedBox(height: 20),
          const Text(
            'No Contacts Found',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Tap the + button to add new contacts',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
