import 'package:pokedex_tech_task/core/base/base_view_model.dart';
import 'package:pokedex_tech_task/services/rest_pokemon_service.dart';

import '../../models/pokemon_model.dart';

class PokemonDetailsViewModel extends BaseViewModel {
  Pokemon? selectedPokemon;
  bool isBusy = false;
  int activeIndex = 0;
  List imagePath = [];
  init(String pokemonId) {
    isBusy = true;

    RestPokemonService().getPokemonsDetails(pokemonId).then((value) {
      if (value.runtimeType == Pokemon) {
        selectedPokemon = value;
        setImagePath();
      } else {
        //isError
      }
      isBusy = false;
      notifyListeners();
    });
  }

  setIndicator(index) {
    activeIndex = index;
    notifyListeners();
  }

  setImagePath() {
    if (selectedPokemon!.sprites.backDefault != "empty") {
      imagePath.add(selectedPokemon!.sprites.backDefault);
    }
    if (selectedPokemon!.sprites.backFemale != "empty") {
      imagePath.add(selectedPokemon!.sprites.backFemale);
    }
    if (selectedPokemon!.sprites.backShiny != "empty") {
      imagePath.add(selectedPokemon!.sprites.backDefault);
    }
    if (selectedPokemon!.sprites.backShinyFemale != "empty") {
      imagePath.add(selectedPokemon!.sprites.backShiny);
    }
    if (selectedPokemon!.sprites.frontDefault != "empty") {
      imagePath.add(selectedPokemon!.sprites.frontDefault);
    }
    if (selectedPokemon!.sprites.frontFemale != "empty") {
      imagePath.add(selectedPokemon!.sprites.frontFemale);
    }
    if (selectedPokemon!.sprites.frontShiny != "empty") {
      imagePath.add(selectedPokemon!.sprites.frontShiny);
    }
    if (selectedPokemon!.sprites.frontShinyFemale != "empty") {
      imagePath.add(selectedPokemon!.sprites.frontShinyFemale);
    }
    notifyListeners();
  }
}
