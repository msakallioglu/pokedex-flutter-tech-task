import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePokemonsProvider extends ChangeNotifier {
  static late SharedPreferences _sharedPrefs;

  late Map<String, String> favoritePokemons;

  void setFavoritePokemons() {
    favoritePokemons = {};
    for (var pokemonId in _sharedPrefs.getKeys().toList()) {
      favoritePokemons.addAll({pokemonId: getFavoritePokemonToSharedPref(pokemonId)});
    }
  }

  Future<void> createSharedPrefence() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  String getFavoritePokemonToSharedPref(String pokemonId) =>
      _sharedPrefs.getString(pokemonId) ?? "0";

  void setFavoritePokemonToSharedPref(String pokemonName, String pokemonId) {
    if (getFavoritePokemonToSharedPref(pokemonId) == "0") {
      addFavoritePokemonToSharedPref(pokemonName, pokemonId);
    } else {
      removeFavoritePokemonToSharedPref(pokemonId);
    }
  }

  void addFavoritePokemonToSharedPref(String pokemonName, String pokemonId) {
    _sharedPrefs.setString(pokemonId, pokemonName);
    setFavoritePokemons();
    notifyListeners();
  }

  void removeFavoritePokemonToSharedPref(String pokemonId) {
    _sharedPrefs.remove(pokemonId);
    setFavoritePokemons();
    notifyListeners();
  }

  void clearSharedPref() {
    _sharedPrefs.clear();
    notifyListeners();
  }
}
