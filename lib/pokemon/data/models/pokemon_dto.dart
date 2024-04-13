class PokemonDTO {
  final int id;
  final String name;
  final String url;
  late final String? imageUrl;

  PokemonDTO({required this.id, required this.name, required this.url}) {
    imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }

  factory PokemonDTO.fromJson(Map<String, dynamic> json) {
    String url = json['url'];
    int id = _extractIdFromUrl(url);
    String name = json['name'];

    return PokemonDTO(id: id, name: name, url: url);
  }

  static int _extractIdFromUrl(String url) {
    // URL: "https://pokeapi.co/api/v2/pokemon/1/"
    var uri = Uri.parse(url);
    var segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    return int.parse(segments.last);
  }
}
