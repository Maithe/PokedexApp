import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedexapp/pokemon/data/models/pokemon_dto.dart';
import 'package:pokedexapp/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedexapp/pokemon/data/models/pokemon_detail_dto.dart';
import 'package:pokedexapp/pokemon/domain/entities/pokemon_detail.dart';
import 'package:pokedexapp/pokemon/domain/entities/pokemon.dart';
import '../../mocks.mocks.dart';

void main() {
  late PokemonRepositoryImpl repository;
  late MockPokemonAPIService mockPokemonAPIService;

  setUp(() {
    mockPokemonAPIService = MockPokemonAPIService();
    repository = PokemonRepositoryImpl(mockPokemonAPIService);
  });

  group('FetchPokemons Tests', () {
    test(
        'should return a list of Pokemon when the call to data source is successful',
        () async {
      when(mockPokemonAPIService.fetchPokemons()).thenAnswer(
          (_) async => [PokemonDTO(id: 1, name: 'Bulbasaur', url: '')]);
      final result = await repository.fetchPokemons();

      expect(result, isA<List<Pokemon>>());
      expect(result.first.name, equals('Bulbasaur'));

      verify(mockPokemonAPIService.fetchPokemons()).called(1);
    });
  });

  group('GetPokemonDetail Tests', () {
    test(
        'should return Pokemon details when the call to data source is successful',
        () async {
      final pokemonDetailDTO = PokemonDetailDTO(
          name: 'Bulbasaur',
          imageUrl: null,
          height: 7,
          weight: 9,
          types: [
            'Grass',
            'Poison'
          ],
          abilities: [
            AbilityInfoDTO(name: 'chlorophyll', url: ''),
            AbilityInfoDTO(name: 'overgrow', url: '')
          ]);

      when(mockPokemonAPIService.fetchPokemonDetail('1'))
          .thenAnswer((_) async => pokemonDetailDTO);

      final result = await repository.getPokemonDetail('1');

      expect(result, isA<PokemonDetail>());
      expect(result.name, equals('Bulbasaur'));
      expect(result.imageUrl, null);
      expect(result.heightM, equals(0.7));
      expect(result.weightKg, equals(0.9));
      expect(result.types, containsAll(['Grass', 'Poison']));
      expect(result.abilities, containsAll(['overgrow', 'chlorophyll']));

      verify(mockPokemonAPIService.fetchPokemonDetail('1')).called(1);
    });
  });
}
