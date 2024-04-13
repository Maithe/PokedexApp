import 'package:flutter/material.dart';
import 'package:pokedexapp/pokemon/presentation/widgets/design_components/pokemon_text.dart';
import '../../domain/entities/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;

  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: ListTile(
        leading: SizedBox(
          width: 50,
          height: 50,
          child: pokemon.imageUrl != null
              ? Image.network(pokemon.imageUrl!, fit: BoxFit.contain)
              : const Icon(Icons.image_not_supported,
                  size: 40, color: Color.fromARGB(255, 99, 99, 99)),
        ),
        title: PokemonText(text: pokemon.name),
        onTap: onTap,
      ),
    );
  }
}
