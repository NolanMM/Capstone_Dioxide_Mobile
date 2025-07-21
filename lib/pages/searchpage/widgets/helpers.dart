import 'package:flutter/material.dart';


Widget buildInfoRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(color: valueColor, fontWeight: FontWeight.w500)),
      ],
    ),
  );
}

Widget buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}

Widget buildListItem(String text, {IconData icon = Icons.arrow_right, Color? color}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: color ?? Colors.blue),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    ),
  );
}
