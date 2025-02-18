import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_contact_app/blocs/user/user_bloc.dart';
import 'package:get_contact_app/core/service/api_service.dart';
import 'package:get_contact_app/core/shared_preference/shared_preference.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUserProfile());
  }

  void _updateSpamProtection(bool isEnabled) async {
    try {
      await ApiService().updateSpamProtection(isEnabled);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Spam Protection updated')),
      );
      context.read<UserBloc>().add(FetchUserProfile()); // Perbarui UI setelah edit
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update Spam Protection')),
      );
    }
  }

  void _updateVisibility(String visibility) async {
    try {
      await ApiService().updateUserVisibility(visibility);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Visibility updated to $visibility')),
      );
      context.read<UserBloc>().add(FetchUserProfile()); // Perbarui UI setelah edit
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update visibility')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final user = state.user;

              return Column(
                children: [
                  // Foto Profil
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                        'assets/images/get_contact_logo.jpg',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Nama Pengguna
                  Center(
                    child: Text(
                      user.name ?? 'Username',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Nomor Telepon
                  Center(
                    child: Text(
                      user.phoneNumber ?? '08123456789',
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
                      user.email ?? 'username@gmail.com',
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
                        Icon(Icons.warning, color: Colors.red),
                        const SizedBox(width: 10),
                        const Text('Enable Spam Protection'),
                      ],
                    ),
                    value: user.settings?.spamProtectionEnabled ?? false,
                    onChanged: (value) {
                      _updateSpamProtection(value);
                    },
                  ),

                  // Visibility dengan Icon Mata
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.visibility, color: Colors.blue),
                        const SizedBox(width: 10),
                        const Text('Visibility'),
                      ],
                    ),
                    trailing: DropdownButton<String>(
                      value: user.settings?.tagVisibility ?? 'public',
                      items: ['public', 'private'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          _updateVisibility(newValue);
                        }
                      },
                    ),
                  ),

                  const Divider(
                    thickness: 1,
                    color: Colors.blue,
                    indent: 20,
                    endIndent: 20,
                  ),

                  const Spacer(),

                  // Logout Button
                  ElevatedButton(
                    onPressed: () async {
                      await TokenManager.deleteToken();
                      if (!mounted) return;
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0072ff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is UserError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            return const Center(child: Text('No user data available'));
          },
        ),
      ),
    );
  }
}
