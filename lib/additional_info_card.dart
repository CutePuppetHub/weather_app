import 'package:flutter/material.dart';

// This widget is a placeholder for the additional information card
class AddtionalInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AddtionalInfoCard({super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32),
        const SizedBox(height: 10),
        Text(label, style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Text(value, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
