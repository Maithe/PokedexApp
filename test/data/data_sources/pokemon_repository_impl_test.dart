import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedexapp/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedexapp/pokemon/domain/entities/pokemon.dart';
import 'package:pokedexapp/pokemon/domain/entities/pokemon_detail.dart';
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
          (_) async => [Pokemon(id: 1, name: 'Bulbasaur', url: '')]);

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
      final pokemonDetail = PokemonDetail(
          name: 'Bulbasaur',
          imageUrl: 'https://pokeapi.co/api/v2/pokemon/1/image',
          height: 7,
          weight: 69,
          types: [
            'Grass',
            'Poison'
          ],
          abilities: [
            AbilityInfo(
                name: 'overgrow', url: 'https://pokeapi.co/api/v2/ability/65/'),
            AbilityInfo(
                name: 'chlorophyll',
                url: 'https://pokeapi.co/api/v2/ability/34/')
          ],
          stats: []);

      when(mockPokemonAPIService.fetchPokemonDetail('1'))
          .thenAnswer((_) async => pokemonDetail);

      final result = await repository.getPokemonDetail('1');

      expect(result, isA<PokemonDetail>());
      expect(result.name, equals('Bulbasaur'));
      expect(
          result.imageUrl, equals('https://pokeapi.co/api/v2/pokemon/1/image'));
      expect(result.height, equals(7));
      expect(result.weight, equals(69));
      expect(result.types, containsAll(['Grass', 'Poison']));
      expect(result.abilities.map((a) => a.name),
          containsAll(['overgrow', 'chlorophyll']));

      verify(mockPokemonAPIService.fetchPokemonDetail('1')).called(1);
    });
  });
}
