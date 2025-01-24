import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool _isSpamProtectionEnabled = false;
  bool _isVisibilityEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Foto Profil di Tengah
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/get_contact_logo.jpg'),
              ),
            ),
            const SizedBox(height: 20),

            // Nama Pengguna
            Center(
              child: Text(
                'Username', // Ganti dengan nama pengguna dinamis
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Nomor Telepon
            Center(
              child: Text(
                '08123456789', // Ganti dengan nomor telepon dinamis
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Email
            Center(
              child: Text(
                'username@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              thickness: 1,
              color: Colors.blue,
              indent: 20,
              endIndent: 20,
            ),

            // Spam Protection dengan Icon Triangle Danger
            SwitchListTile(
              title: Row(
                children: [
                  Icon(Icons.warning,
                      color: Colors.red), // Triangle danger icon
                  const SizedBox(width: 10),
                  const Text('Enable Spam Protection'),
                ],
              ),
              value: _isSpamProtectionEnabled,
              onChanged: (value) {
                setState(() {
                  _isSpamProtectionEnabled = value;
                });
              },
            ),

            // Visibility dengan Icon Mata
            SwitchListTile(
              title: Row(
                children: [
                  Icon(Icons.visibility, color: Colors.blue), // Eye icon
                  const SizedBox(width: 10),
                  const Text('Enable Visibility'),
                ],
              ),
              value: _isVisibilityEnabled,
              onChanged: (value) {
                setState(() {
                  _isVisibilityEnabled = value;
                });
              },
            ),
            const Divider(
              thickness: 1,
              color: Colors.blue,
              indent: 20,
              endIndent: 20,
            ),

            // Spacer to push the Logout button to the bottom
            const Spacer(),

            // Logout
            ElevatedButton(
              onPressed: () async {
                // Logout logic
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0072ff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                minimumSize: Size(double.infinity, 50), // Lebar tombol penuh
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
