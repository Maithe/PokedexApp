class PokemonDetail {
  final String name;
  final List<AbilityInfo> abilities;
  final String? imageUrl;
  final List<String> types;
  final List<Stat> stats;
  final int weight;
  final int height;

  PokemonDetail({
    required this.name,
    required this.abilities,
    required this.imageUrl,
    required this.types,
    required this.stats,
    required this.weight,
    required this.height,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      name: json['name'],
      abilities: (json['abilities'] as List)
          .map((item) => AbilityInfo.fromJson(item['ability']))
          .toList(),
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      types: (json['types'] as List)
          .map((item) => item['type']['name'].toString())
          .toList(),
      stats:
          (json['stats'] as List).map((item) => Stat.fromJson(item)).toList(),
      weight: json['weight'],
      height: json['height'],
    );
  }
}

class AbilityInfo {
  final String name;
  final String url;

  AbilityInfo({required this.name, required this.url});

  factory AbilityInfo.fromJson(Map<String, dynamic> json) {
    return AbilityInfo(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Stat {
  final String name;
  final int value;

  Stat({required this.name, required this.value});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      name: json['stat']['name'],
      value: json['base_stat'],
    );
  }
}
