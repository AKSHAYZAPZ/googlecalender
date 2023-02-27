
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Event {
  final String title;

  final DateTime from;
  final DateTime to;
  final Color backgroundColor;

  Event({
    required this.title,
    required this.from,
    required this.to,
    this.backgroundColor = Colors.blue,
  });
}