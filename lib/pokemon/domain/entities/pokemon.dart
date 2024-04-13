class Pokemon {
  final int id;
  final String name;
  final String url;

  Pokemon({required this.id, required this.name, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    String url = json['url'];
    int id = _extractIdFromUrl(url);
    String name = json['name'];

    return Pokemon(id: id, name: name, url: url);
  }

  // Método para extrair o ID da URL
  static int _extractIdFromUrl(String url) {
    // URL: "https://pokeapi.co/api/v2/pokemon/1/"
    var uri = Uri.parse(url);
    var segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    return int.parse(segments.last);
  }
}
