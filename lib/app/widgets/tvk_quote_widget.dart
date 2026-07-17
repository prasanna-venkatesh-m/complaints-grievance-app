import 'package:flutter/material.dart';

Widget TVKQuoteWidget() {
  return Container(
    width: double.infinity,
    color: Colors.black,
    padding: const EdgeInsets.all(5),
    child: const Text(
      'பிறப்பொக்கும் எல்லா உயிர்க்கும்',
      textAlign: TextAlign.center,
      style: TextStyle(
        letterSpacing: 0.7,
        color: Colors.yellow,
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
