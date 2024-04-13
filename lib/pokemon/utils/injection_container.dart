import 'package:get_it/get_it.dart';
import 'package:pokedexapp/pokemon/data/datasources/pokemon_api_service.dart';
import 'package:pokedexapp/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedexapp/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedexapp/pokemon/domain/usecases/fetch_pokemons.dart';
import 'package:pokedexapp/pokemon/domain/usecases/get_pokemon_detail.dart';
import 'package:pokedexapp/pokemon/presentation/mobx/pokemon_store.dart';

final GetIt sl = GetIt.instance;

void init() {
  // Services
  sl.registerLazySingleton<PokemonAPIService>(() => PokemonAPIService());

  // Repositories
  sl.registerLazySingleton<PokemonRepository>(
      () => PokemonRepositoryImpl(sl<PokemonAPIService>()));

  // Use cases
  sl.registerLazySingleton<FetchPokemons>(
      () => FetchPokemons(repository: sl<PokemonRepository>()));
  sl.registerLazySingleton<GetPokemonDetail>(
      () => GetPokemonDetail(sl<PokemonRepository>()));

  // Stores
  sl.registerFactory(
      () => PokemonStore(sl<FetchPokemons>(), sl<GetPokemonDetail>()));
}
