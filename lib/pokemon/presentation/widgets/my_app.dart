import 'package:flutter/material.dart';
import 'package:pokedexapp/pokemon/presentation/mobx/pokemon_store.dart';
import 'package:pokedexapp/pokemon/presentation/pages/pokemon_list_page.dart';
import 'package:pokedexapp/pokemon/presentation/widgets/design_components/button_reload_list.dart';
import 'package:pokedexapp/services/platform_service.dart';

class MyApp extends StatefulWidget {
  final PokemonStore store;

  MyApp({super.key, required this.store});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController searchController = TextEditingController();
  String platformVersion = "Loading...";

  @override
  void initState() {
    super.initState();
    _getPlatformVersion();
  }

  void _getPlatformVersion() async {
    PlatformService platformService = PlatformService();
    String version = await platformService.getPlatformVersion();
    setState(() {
      platformVersion = "Platform Version: $version";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          accentColor: Colors.amber,
        ).copyWith(
          secondary: const Color.fromARGB(255, 255, 215, 94),
          background: Colors.white,
          surface: Colors.grey[50],
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18.0),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pokédex - $platformVersion'),
          backgroundColor: Colors.redAccent,
        ),
        body: PokemonListPage(
            store: widget.store, searchController: searchController),
        floatingActionButton: ReloadButton(
          onReload: () {
            searchController.clear();
            widget.store.searchTerm = '';
            widget.store.loadPokemons();
          },
        ),
      ),
    );
  }
}
