import 'dart:convert';

PokemonStat pokemonStatFromJson(String str) => PokemonStat.fromJson(json.decode(str));

String pokemonStatToJson(PokemonStat data) => json.encode(data.toJson());

class PokemonStat {
    PokemonStat({
        required this.baseStat,
        required this.effort,
        required this.stat,
    });

    int baseStat;
    int effort;
    Stat stat;

    factory PokemonStat.fromJson(Map<String, dynamic> json) => PokemonStat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: Stat.fromJson(json["stat"]),
    );

    Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
    };
}

class Stat {
    Stat({
        required this.name,
        required this.url,
    });

    String name;
    String url;

    factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}
