import '../entities/pokemon_detail.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonDetail {
  final PokemonRepository repository;

  GetPokemonDetail(this.repository);

  Future<PokemonDetail> execute(String name) async {
    return await repository.getPokemonDetail(name);
  }
}
