import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final String? name;
  final String? phoneNumber;

  const ContactItem({
    this.name,
    this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name ?? 'Unknown Name'),
      subtitle: Text(phoneNumber ?? 'Unknown Number'),
    );
  }
}

