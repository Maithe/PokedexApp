class PokemonDetailDTO {
  final String name;
  final List<String> types;
  final int weight;
  final int height;
  final String? imageUrl;
  final List<AbilityInfoDTO> abilities;

  PokemonDetailDTO({
    required this.name,
    required this.types,
    required this.weight,
    required this.height,
    this.imageUrl,
    required this.abilities,
  });

  factory PokemonDetailDTO.fromJson(Map<String, dynamic> json) {
    return PokemonDetailDTO(
      name: json['name'],
      types:
          List<String>.from(json['types'].map((type) => type['type']['name'])),
      weight: json['weight'],
      height: json['height'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      abilities: List<AbilityInfoDTO>.from(json['abilities']
          .map((ability) => AbilityInfoDTO.fromJson(ability['ability']))),
    );
  }
}

class AbilityInfoDTO {
  final String name;
  final String url;

  AbilityInfoDTO({required this.name, required this.url});

  factory AbilityInfoDTO.fromJson(Map<String, dynamic> json) {
    return AbilityInfoDTO(
      name: json['name'],
      url: json['url'],
    );
  }
}
