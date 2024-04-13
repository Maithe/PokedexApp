import 'package:pokedexapp/pokemon/domain/entities/pokemon.dart';
import 'package:pokedexapp/pokemon/domain/entities/pokemon_detail.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> fetchPokemons();
  Future<PokemonDetail> getPokemonDetail(String name);
}
