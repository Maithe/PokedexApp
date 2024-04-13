import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedexapp/pokemon/domain/entities/pokemon.dart';
import 'package:pokedexapp/pokemon/domain/entities/pokemon_detail.dart';
import 'package:pokedexapp/pokemon/domain/usecases/fetch_pokemons.dart';
import 'package:pokedexapp/pokemon/domain/usecases/get_pokemon_detail.dart';
import 'package:pokedexapp/pokemon/data/models/pokemon_detail_dto.dart';
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
                imageUrl:
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png')
          ]);

      final result = await useCaseFetchPokemons.execute();

      expect(result, isA<List<Pokemon>>());
      expect(result.first.name, equals('Bulbasaur'));
    });

    test('should handle errors without returning null', () async {
      when(mockRepository.fetchPokemons())
          .thenThrow(Exception('Failed to fetch data'));

      expect(() async => await useCaseFetchPokemons.execute(), throwsException);
    });
  });

  group('GetPokemonDetail Tests', () {
    test('should get Pokemon details from the repository', () async {
      final pokemonDetailDTO = PokemonDetailDTO(
          name: 'Bulbasaur',
          imageUrl: 'https://pokeapi.co/api/v2/pokemon/1/image',
          height: 7,
          weight: 69,
          types: [
            'Grass',
            'Poison'
          ],
          abilities: [
            AbilityInfoDTO(name: 'chlorophyll', url: ''),
            AbilityInfoDTO(name: 'overgrow', url: '')
          ]);

      final expectedPokemonDetail = PokemonDetail.fromDTO(pokemonDetailDTO);

      when(mockRepository.getPokemonDetail('Bulbasaur'))
          .thenAnswer((_) async => expectedPokemonDetail);

      final result = await useCaseGetPokemonDetail.execute('Bulbasaur');

      expect(result, isA<PokemonDetail>());
      expect(result.name, equals('Bulbasaur'));
      expect(result.heightM, equals(0.7));
      expect(result.weightKg, equals(6.9));
      expect(result.types, containsAll(['Grass', 'Poison']));
      expect(result.abilities, containsAll(['overgrow', 'chlorophyll']));

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
