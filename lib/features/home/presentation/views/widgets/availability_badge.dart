
  import 'package:flutter/material.dart';

Widget availabilityBadge(bool isOpen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isOpen ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isOpen ? "Open" : "Closed",
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }