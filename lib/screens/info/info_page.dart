import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Box with Icon and Placeholder
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.search, color: Colors.blue), // Search Icon
                hintText: 'Pencarian berdasarkan nomor', // Placeholder text
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
