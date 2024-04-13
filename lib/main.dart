import 'package:flutter/material.dart';
import 'package:pokedexapp/pokemon/presentation/mobx/pokemon_store.dart';
import 'package:pokedexapp/pokemon/presentation/widgets/my_app.dart';
import 'package:pokedexapp/pokemon/utils/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();

  runApp(MyApp(store: di.sl<PokemonStore>()));
}
