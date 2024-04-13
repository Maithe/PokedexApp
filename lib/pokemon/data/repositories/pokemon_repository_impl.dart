import 'package:pokedexapp/pokemon/data/models/pokemon_detail_dto.dart';
import 'package:pokedexapp/pokemon/domain/entities/pokemon_detail.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_api_service.dart';
import '../models/pokemon_dto.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonAPIService apiService;

  PokemonRepositoryImpl(this.apiService);

  @override
  Future<List<Pokemon>> fetchPokemons() async {
    try {
      List<PokemonDTO> dtos = await apiService.fetchPokemons();
      return dtos.map((dto) => Pokemon.fromDTO(dto)).toList();
    } catch (e) {
      throw Exception('Failed to fetch pokemons: ${e.toString()}');
    }
  }

  @override
  Future<PokemonDetail> getPokemonDetail(String name) async {
    try {
      PokemonDetailDTO dto = await apiService.fetchPokemonDetail(name);
      return PokemonDetail.fromDTO(dto);
    } catch (e) {
      throw Exception('Failed to fetch pokemon detail: ${e.toString()}');
    }
  }
}
