import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedexapp/pokemon/presentation/mobx/pokemon_store.dart';
import 'package:pokedexapp/pokemon/presentation/pages/pokemon_detail_page.dart';
import 'package:pokedexapp/pokemon/presentation/widgets/design_components/empty_result_widget.dart';
import 'package:pokedexapp/pokemon/presentation/widgets/design_components/loading_widget.dart';
import 'package:pokedexapp/pokemon/presentation/widgets/pokemon_card.dart';

class PokemonList extends StatefulWidget {
  final PokemonStore store;

  const PokemonList({super.key, required this.store});

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  @override
  void initState() {
    super.initState();
    widget.store.loadPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (widget.store.isLoading) {
          return const LoadingWidget();
        } else if (widget.store.filteredPokemons.isEmpty) {
          return const EmptyResultWidget();
        }
        return ListView.builder(
          itemCount: widget.store.filteredPokemons.length,
          itemBuilder: (_, index) {
            final pokemon = widget.store.filteredPokemons[index];
            return PokemonCard(
              pokemon: pokemon,
              onTap: () async {
                await widget.store.loadPokemonDetail(pokemon.name);
                if (widget.store.currentPokemonDetail != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PokemonDetailPage(
                          pokemonDetail: widget.store.currentPokemonDetail!),
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
