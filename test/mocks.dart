import 'package:mockito/annotations.dart';
import 'package:pokedexapp/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedexapp/pokemon/data/datasources/pokemon_api_service.dart';

@GenerateMocks([PokemonRepository, PokemonAPIService])
void main() {}
