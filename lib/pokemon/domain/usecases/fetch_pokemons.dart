import '../repositories/pokemon_repository.dart';
import '../entities/pokemon.dart';

class FetchPokemons {
  final PokemonRepository repository;

  FetchPokemons({required this.repository});

  Future<List<Pokemon>> execute() async {
    return await repository.fetchPokemons();
  }
}
