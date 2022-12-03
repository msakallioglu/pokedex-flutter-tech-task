import 'package:get_it/get_it.dart';
import 'package:pokedex_tech_task/screens/pokemon_details/pokemon_details_view_model.dart';
import 'screens/favorite_pokemons/favorite_pokemons_view_model.dart';
import 'screens/pokemon/pokemon_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<PokemonViewModel>(() => PokemonViewModel());
  locator.registerFactory<FavoritePokemonsViewModel>(() => FavoritePokemonsViewModel());
  locator.registerFactory<PokemonDetailsViewModel>(() => PokemonDetailsViewModel());
}
