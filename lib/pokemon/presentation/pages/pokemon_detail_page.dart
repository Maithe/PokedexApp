import 'package:flutter/material.dart';
import 'package:pokedexapp/pokemon/domain/entities/pokemon_detail.dart';

class PokemonDetailPage extends StatelessWidget {
  final PokemonDetail pokemonDetail;

  const PokemonDetailPage({super.key, required this.pokemonDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemonDetail.name),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            pokemonDetail.imageUrl != null
                ? Image.network(
                    pokemonDetail.imageUrl!,
                    height: 250,
                    fit: BoxFit.contain,
                  )
                : Container(
                    height: 250,
                    color: Colors.grey[200],
                    child: Icon(Icons.image_not_supported,
                        size: 100, color: Colors.grey[500]),
                  ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                pokemonDetail.name,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text("Height"),
              subtitle: Text("${pokemonDetail.heightM} m"),
              leading: const Icon(Icons.height),
            ),
            ListTile(
              title: const Text("Weight"),
              subtitle: Text("${pokemonDetail.weightKg} kg"),
              leading: const Icon(Icons.monitor_weight),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Types",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: pokemonDetail.types
                  .map((type) => Chip(
                        label: Text(type),
                        backgroundColor: Colors.amber,
                      ))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Abilities",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...pokemonDetail.abilities.map((ability) => ListTile(
                  title: Text(ability),
                  leading: const Icon(Icons.star),
                )),
          ],
        ),
      ),
    );
  }
}
