import 'package:pokedexapp/pokemon/data/models/pokemon_detail_dto.dart';

class PokemonDetail {
  final String name;
  final List<String> types;
  final double weightKg;
  final double heightM;
  final String? imageUrl;
  final List<String> abilities;

  PokemonDetail({
    required this.name,
    required this.types,
    required this.weightKg,
    required this.heightM,
    this.imageUrl,
    required this.abilities,
  });

  factory PokemonDetail.fromDTO(PokemonDetailDTO dto) {
    return PokemonDetail(
      name: dto.name,
      types: dto.types,
      weightKg: dto.weight / 10.0,
      heightM: dto.height / 10.0,
      imageUrl: dto.imageUrl,
      abilities: dto.abilities.map((a) => a.name).toList(),
    );
  }
}
