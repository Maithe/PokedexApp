// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonStore on _PokemonStoreBase, Store {
  Computed<List<Pokemon>>? _$filteredPokemonsComputed;

  @override
  List<Pokemon> get filteredPokemons => (_$filteredPokemonsComputed ??=
          Computed<List<Pokemon>>(() => super.filteredPokemons,
              name: '_PokemonStoreBase.filteredPokemons'))
      .value;

  late final _$pokemonsAtom =
      Atom(name: '_PokemonStoreBase.pokemons', context: context);

  @override
  ObservableList<Pokemon> get pokemons {
    _$pokemonsAtom.reportRead();
    return super.pokemons;
  }

  @override
  set pokemons(ObservableList<Pokemon> value) {
    _$pokemonsAtom.reportWrite(value, super.pokemons, () {
      super.pokemons = value;
    });
  }

  late final _$searchTermAtom =
      Atom(name: '_PokemonStoreBase.searchTerm', context: context);

  @override
  String get searchTerm {
    _$searchTermAtom.reportRead();
    return super.searchTerm;
  }

  @override
  set searchTerm(String value) {
    _$searchTermAtom.reportWrite(value, super.searchTerm, () {
      super.searchTerm = value;
    });
  }

  late final _$currentPokemonDetailAtom =
      Atom(name: '_PokemonStoreBase.currentPokemonDetail', context: context);

  @override
  PokemonDetail? get currentPokemonDetail {
    _$currentPokemonDetailAtom.reportRead();
    return super.currentPokemonDetail;
  }

  @override
  set currentPokemonDetail(PokemonDetail? value) {
    _$currentPokemonDetailAtom.reportWrite(value, super.currentPokemonDetail,
        () {
      super.currentPokemonDetail = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_PokemonStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_PokemonStoreBase.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$loadPokemonsAsyncAction =
      AsyncAction('_PokemonStoreBase.loadPokemons', context: context);

  @override
  Future<void> loadPokemons() {
    return _$loadPokemonsAsyncAction.run(() => super.loadPokemons());
  }

  late final _$loadPokemonDetailAsyncAction =
      AsyncAction('_PokemonStoreBase.loadPokemonDetail', context: context);

  @override
  Future<void> loadPokemonDetail(String pokemonName) {
    return _$loadPokemonDetailAsyncAction
        .run(() => super.loadPokemonDetail(pokemonName));
  }

  @override
  String toString() {
    return '''
pokemons: ${pokemons},
searchTerm: ${searchTerm},
currentPokemonDetail: ${currentPokemonDetail},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
filteredPokemons: ${filteredPokemons}
    ''';
  }
}
