import 'package:flutter/material.dart';
import 'package:pokedexapp/pokemon/presentation/mobx/pokemon_store.dart';
import 'package:pokedexapp/pokemon/presentation/widgets/design_components/search_component.dart';
import 'package:pokedexapp/pokemon/presentation/widgets/pokemon_list.dart';

class PokemonListPage extends StatefulWidget {
  final PokemonStore store;
  final TextEditingController searchController;

  const PokemonListPage(
      {super.key, required this.store, required this.searchController});

  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  @override
  void initState() {
    super.initState();
    widget.store.loadPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PokemonSearchInput(
            onChanged: (value) => widget.store.searchTerm = value,
            controller: widget.searchController),
        Expanded(child: PokemonList(store: widget.store)),
      ],
    );
  }
}
