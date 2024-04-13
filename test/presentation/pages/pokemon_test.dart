import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedexapp/pokemon/domain/entities/pokemon.dart';
import 'package:pokedexapp/pokemon/domain/entities/pokemon_detail.dart';
import 'package:pokedexapp/pokemon/domain/usecases/fetch_pokemons.dart';
import 'package:pokedexapp/pokemon/domain/usecases/get_pokemon_detail.dart';
import 'package:pokedexapp/pokemon/presentation/mobx/pokemon_store.dart';
import 'package:pokedexapp/pokemon/presentation/pages/pokemon_detail_page.dart';
import 'package:pokedexapp/pokemon/presentation/pages/pokemon_list_page.dart';
import '../../mocks.mocks.dart';

void main() {
  group('PokemonListPage Tests', () {
    late PokemonStore store;
    late MockPokemonRepository mockPokemonRepository;
    late TextEditingController searchController;

    setUp(() {
      mockPokemonRepository = MockPokemonRepository();
      store = PokemonStore(FetchPokemons(repository: mockPokemonRepository),
          GetPokemonDetail(mockPokemonRepository));
      searchController = TextEditingController();

      when(mockPokemonRepository.fetchPokemons()).thenAnswer((_) async => [
            Pokemon(
                id: 1,
                name: 'Bulbasaur',
                url: 'https://pokeapi.co/api/v2/pokemon/1/'),
            Pokemon(
                id: 6,
                name: 'Charizard',
                url: 'https://pokeapi.co/api/v2/pokemon/6/')
          ]);
    });

    tearDown(() {
      searchController.dispose();
    });

    testWidgets('PokemonListPage displays list of pokemons when loaded',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: PokemonListPage(
              store: store, searchController: searchController)));

      await store.loadPokemons();
      await tester.pumpAndSettle();

      // Verifica os itens da lista
      expect(find.text('Bulbasaur'), findsOneWidget);
      expect(find.text('Charizard'), findsOneWidget);
    });
  });

  group('PokemonDetailPage Tests', () {
    late PokemonDetail pokemonDetail;

    setUp(() {
      pokemonDetail = PokemonDetail(
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
    });

    testWidgets('displays all details correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: PokemonDetailPage(pokemonDetail: pokemonDetail),
      ));

      // Verificando todos os detalhes que estão sendo mostrados
      expect(find.text('Bulbasaur'), findsAtLeast(2));
      expect(find.text('7'), findsOneWidget);
      expect(find.text('9'), findsOneWidget);
      expect(find.text('Grass'), findsOneWidget);
      expect(find.text('Poison'), findsOneWidget);
      expect(find.text('overgrow'), findsOneWidget);
      expect(find.text('chlorophyll'), findsOneWidget);
      expect(find.byType(Image), findsNothing);

      // Verificando os ícones
      expect(find.byIcon(Icons.height), findsOneWidget);
      expect(find.byIcon(Icons.monitor_weight), findsOneWidget);
      expect(find.byIcon(Icons.star), findsAtLeast(1));
    });
  });
}
