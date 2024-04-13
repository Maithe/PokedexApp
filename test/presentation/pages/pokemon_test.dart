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
            Pokemon(id: 1, name: 'Bulbasaur', imageUrl: null),
            Pokemon(id: 6, name: 'Charizard', imageUrl: null)
          ]);
    });

    tearDown(() {
      searchController.dispose();
    });

    testWidgets('PokemonListPage displays list of pokemons when loaded',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home:
              PokemonListPage(store: store, searchController: searchController),
        ),
      );

      await store.loadPokemons();
      await tester.pumpAndSettle();

      expect(find.text('Bulbasaur'), findsOneWidget);
      expect(find.text('Charizard'), findsOneWidget);
      expect(find.byType(Image), findsNothing);

      verify(mockPokemonRepository.fetchPokemons()).called(1);
    });
  });

  group('PokemonDetailPage Tests', () {
    late PokemonDetail pokemonDetail;

    setUp(() {
      pokemonDetail = PokemonDetail(
          name: 'Bulbasaur',
          imageUrl: null,
          heightM: 0.7,
          weightKg: 0.9,
          types: ['Grass', 'Poison'],
          abilities: ['overgrow', 'chlorophyll']);
    });

    testWidgets('displays all details correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: PokemonDetailPage(pokemonDetail: pokemonDetail),
      ));

      expect(find.text('Bulbasaur'), findsAtLeast(2));
      expect(find.text('0.7 m'), findsOneWidget);
      expect(find.text('0.9 kg'), findsOneWidget);
      expect(find.text('Grass'), findsOneWidget);
      expect(find.text('Poison'), findsOneWidget);
      expect(find.text('overgrow'), findsOneWidget);
      expect(find.text('chlorophyll'), findsOneWidget);
      expect(find.byType(Image), findsNothing);

      expect(find.byIcon(Icons.height), findsOneWidget);
      expect(find.byIcon(Icons.monitor_weight), findsOneWidget);
      expect(find.byIcon(Icons.star), findsAtLeast(1));
    });
  });
}
