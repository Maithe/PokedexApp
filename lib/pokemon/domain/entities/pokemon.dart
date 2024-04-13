import 'package:pokedexapp/pokemon/data/models/pokemon_dto.dart';

class Pokemon {
  final int id;
  final String name;
  final String? imageUrl;

  Pokemon({required this.id, required this.name, required this.imageUrl});

  factory Pokemon.fromDTO(PokemonDTO dto) {
    return Pokemon(id: dto.id, name: dto.name, imageUrl: dto.imageUrl);
  }
}
