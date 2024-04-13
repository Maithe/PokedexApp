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
                    pokemonDetail.imageUrl ?? "",
                    height: 250,
                    fit: BoxFit.contain,
                  )
                : Container(),
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
              subtitle: Text("${pokemonDetail.height}"),
              leading: const Icon(Icons.height),
            ),
            ListTile(
              title: const Text("Weight"),
              subtitle: Text("${pokemonDetail.weight}"),
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
                  title: Text(ability.name),
                  leading: const Icon(Icons.star),
                )),
          ],
        ),
      ),
    );
  }
}
