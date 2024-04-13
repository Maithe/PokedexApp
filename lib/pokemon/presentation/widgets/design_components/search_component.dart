import 'package:flutter/material.dart';

class PokemonSearchInput extends StatelessWidget {
  final Function(String) onChanged;
  final TextEditingController controller;

  const PokemonSearchInput(
      {super.key, required this.onChanged, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      child: Material(
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: const InputDecoration(
            labelText: 'Search Pokemon',
            suffixIcon: Icon(Icons.search, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
