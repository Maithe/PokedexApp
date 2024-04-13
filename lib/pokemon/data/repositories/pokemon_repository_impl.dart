import 'package:pokedexapp/pokemon/domain/entities/pokemon_detail.dart';

import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_api_service.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonAPIService apiService;

  PokemonRepositoryImpl(this.apiService);

  @override
  Future<List<Pokemon>> fetchPokemons() async {
    try {
      return await apiService.fetchPokemons();
    } catch (e) {
      throw Exception('Failed to fetch pokemons: ${e.toString()}');
    }
  }

  @override
  Future<PokemonDetail> getPokemonDetail(String name) async {
    try {
      return await apiService.fetchPokemonDetail(name);
    } catch (e) {
      throw Exception('Failed to fetch pokemon detail: ${e.toString()}');
    }
  }
}
