import 'dart:convert';

Sprite spriteFromJson(String str) => Sprite.fromJson(json.decode(str));

String spriteToJson(Sprite data) => json.encode(data.toJson());

class Sprite {
  Sprite({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  String? backDefault;
  String? backFemale;
  String? backShiny;
  String? backShinyFemale;
  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? frontShinyFemale;

  factory Sprite.fromJson(Map<String, dynamic> json) => Sprite(
        backDefault: json["back_default"] ?? "empty",
        backFemale: json["back_female"] ?? "empty",
        backShiny: json["back_shiny"] ?? "empty",
        backShinyFemale: json["back_shiny_female"] ?? "empty",
        frontDefault: json["front_default"] ?? "empty",
        frontFemale: json["front_female"] ?? "empty",
        frontShiny: json["front_shiny"] ?? "empty",
        frontShinyFemale: json["front_shiny_female"] ?? "empty",
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault,
        "back_female": backFemale,
        "back_shiny": backShiny,
        "back_shiny_female": backShinyFemale,
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
      };
}
