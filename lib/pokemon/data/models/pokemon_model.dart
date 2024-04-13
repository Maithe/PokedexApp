import 'dart:convert';

class PokemonModel {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;

  PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    List<String> types = (json['types'] as List)
        .map((typeInfo) => typeInfo['type']['name'] as String)
        .toList();

    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      types: types,
      height: json['height'],
      weight: json['weight'],
    );
  }

  static List<PokemonModel> fromJsonList(String source) {
    return json
        .decode(source)['results']
        .map<PokemonModel>((json) => PokemonModel.fromJson(json))
        .toList();
  }
}
