import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_detail.dart';

class PokemonAPIService {
  final String baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<Pokemon>> fetchPokemons() async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon?limit=10000'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Pokemon.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

  Future<PokemonDetail> fetchPokemonDetail(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$name'));
    if (response.statusCode == 200) {
      return PokemonDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load pokemon detail');
    }
  }
}
