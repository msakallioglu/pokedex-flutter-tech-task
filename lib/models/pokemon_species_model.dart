import 'dart:convert';

PokemonSpecies speciesFromJson(String str) => PokemonSpecies.fromJson(json.decode(str));

class PokemonSpecies {
  PokemonSpecies({
    required this.baseHappiness,
    required this.captureRate,
    required this.color,
    required this.eggGroups,
  });

  int baseHappiness;
  int captureRate;
  String color;
  List<String> eggGroups;

  factory PokemonSpecies.fromJson(Map<String, dynamic> json) => PokemonSpecies(
        baseHappiness: json["base_happiness"],
        captureRate: json["capture_rate"],
        color: json["color"]["name"],
        eggGroups: List<String>.from(json["egg_groups"]["name"].map((x) => x)),
      );
}
