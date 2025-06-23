

import 'package:flutter/material.dart';

class ChartData {
  ChartData(this.category, this.amount);

  final String category;
  final double amount;
}

class CharInfo {
  final String title;
  final Color color;

  CharInfo({
    required this.title,
    required this.color,
  });
}