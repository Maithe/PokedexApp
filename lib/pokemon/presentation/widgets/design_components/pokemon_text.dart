import 'package:flutter/material.dart';

class PokemonText extends StatelessWidget {
  const PokemonText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14),
    );
  }
}
