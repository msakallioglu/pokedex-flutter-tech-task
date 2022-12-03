import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../screens/favorite_pokemons/favorite_pokemons_view.dart';
import '../../../screens/pokemon/pokemon_view.dart';
import '../../../screens/pokemon_details/pokemon_details_view.dart';

class RouteGenerator {
  static final RouteGenerator _instance = RouteGenerator._init();

  static RouteGenerator get instance => _instance;

  RouteGenerator._init();

  Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case ('/'):
        return _createRoute(const PokemonView(), settings);
      case ('/FavoritePokemonsView'):
        return _createRoute(const FavoritePokemonsView(), settings);
      case ('/PokemonDetailsView'):
        return _createRoute( PokemonDetailsView(
          pokemonId: settings.arguments as String,
        ), settings);
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text("Hata"),
            ),
            body: const Center(
              child: Text("404 "),
            ),
          ),
        );
    }
  }

  static Route<dynamic>? _createRoute(Widget widget, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(settings: settings, builder: (context) => widget);
    } else {
      return MaterialPageRoute(settings: settings, builder: (context) => widget);
    }
  }
}
