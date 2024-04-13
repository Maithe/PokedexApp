import 'package:flutter/material.dart';
import 'package:pokedexapp/pokemon/presentation/widgets/design_components/pokemon_text.dart';

class PokemonCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const PokemonCard({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: ListTile(
        title: PokemonText(text: name),
        onTap: onTap,
      ),
    );
  }
}
