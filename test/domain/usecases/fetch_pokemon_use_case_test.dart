import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedexapp/pokemon/domain/entities/pokemon.dart';
import 'package:pokedexapp/pokemon/domain/entities/pokemon_detail.dart';
import 'package:pokedexapp/pokemon/domain/usecases/fetch_pokemons.dart';
import 'package:pokedexapp/pokemon/domain/usecases/get_pokemon_detail.dart';
import '../../mocks.mocks.dart';

void main() {
  late FetchPokemons useCaseFetchPokemons;
  late GetPokemonDetail useCaseGetPokemonDetail;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    useCaseFetchPokemons = FetchPokemons(repository: mockRepository);
    useCaseGetPokemonDetail = GetPokemonDetail(mockRepository);
  });

  group('FetchPokemons Tests', () {
    test('should get Pokemon list from the repository', () async {
      when(mockRepository.fetchPokemons()).thenAnswer((_) async => [
            Pokemon(
                id: 1,
                name: 'Bulbasaur',
                url: 'https://pokeapi.co/api/v2/pokemon/1/')
          ]);

      final result = await useCaseFetchPokemons.execute();

      expect(result, isA<List<Pokemon>>());
      expect(result.first.name, equals('Bulbasaur'),
          reason: 'The Pokemon name should match the expected value');
    });

    test('should handle errors without returning null', () async {
      when(mockRepository.fetchPokemons())
          .thenThrow(Exception('Failed to fetch data'));

      expect(() async => await useCaseFetchPokemons.execute(), throwsException);
    });
  });

  group('GetPokemonDetail Tests', () {
    test('should get Pokemon details from the repository', () async {
      final pokemonDetail = PokemonDetail(
          name: 'Bulbasaur',
          imageUrl: null,
          height: 7,
          weight: 9,
          types: [
            'Grass',
            'Poison'
          ],
          stats: [],
          abilities: [
            AbilityInfo(
                name: 'overgrow', url: 'https://pokeapi.co/api/v2/ability/65/'),
            AbilityInfo(
                name: 'chlorophyll',
                url: 'https://pokeapi.co/api/v2/ability/34/')
          ]);

      when(mockRepository.getPokemonDetail('Bulbasaur'))
          .thenAnswer((_) async => pokemonDetail);

      final result = await useCaseGetPokemonDetail.execute('Bulbasaur');

      expect(result, isA<PokemonDetail>());
      // Verificando os valores
      expect(result.name, equals('Bulbasaur'));
      expect(result.height, equals(7));
      expect(result.weight, equals(9));
      expect(result.types, containsAll(['Grass', 'Poison']));
      expect(result.abilities.map((a) => a.name),
          containsAll(['overgrow', 'chlorophyll']));

      verify(mockRepository.getPokemonDetail('Bulbasaur')).called(1);
    });

    test('should handle errors when fetching Pokemon details', () async {
      when(mockRepository.getPokemonDetail('Bulbasaur'))
          .thenThrow(Exception('Failed to fetch pokemon details'));

      expect(() async => await useCaseGetPokemonDetail.execute('Bulbasaur'),
          throwsException);
    });
  });
}
