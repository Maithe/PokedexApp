import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedexapp/pokemon/data/models/pokemon_detail_dto.dart';
import 'package:pokedexapp/pokemon/data/models/pokemon_dto.dart';

class PokemonAPIService {
  final String baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<PokemonDTO>> fetchPokemons() async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon?limit=10000'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => PokemonDTO.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

  Future<PokemonDetailDTO> fetchPokemonDetail(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$name'));
    if (response.statusCode == 200) {
      return PokemonDetailDTO.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load pokemon detail');
    }
  }
}
