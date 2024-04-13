import 'package:mobx/mobx.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/usecases/fetch_pokemons.dart';
import '../../domain/usecases/get_pokemon_detail.dart';

part 'pokemon_store.g.dart';

class PokemonStore = _PokemonStoreBase with _$PokemonStore;

abstract class _PokemonStoreBase with Store {
  final FetchPokemons fetchPokemonsUseCase;
  final GetPokemonDetail getPokemonDetailUseCase;

  _PokemonStoreBase(this.fetchPokemonsUseCase, this.getPokemonDetailUseCase);

  @observable
  ObservableList<Pokemon> pokemons = ObservableList<Pokemon>();

  @observable
  String searchTerm = '';

  @computed
  List<Pokemon> get filteredPokemons => searchTerm.isEmpty
      ? pokemons
      : pokemons
          .where((pokemon) =>
              pokemon.name.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

  @observable
  PokemonDetail? currentPokemonDetail;

  @observable
  bool isLoading = false;

  @observable
  String errorMessage = '';

  @action
  Future<void> loadPokemons() async {
    if (isLoading) return;
    errorMessage = '';
    isLoading = true;
    try {
      if (pokemons.isEmpty) {
        pokemons.addAll(await fetchPokemonsUseCase.execute());
      }
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadPokemonDetail(String pokemonName) async {
    isLoading = true;
    errorMessage = '';
    try {
      currentPokemonDetail = await getPokemonDetailUseCase.execute(pokemonName);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
    }
  }
}
