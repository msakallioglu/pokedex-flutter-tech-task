import '../../core/base/base_view_model.dart';
import '../../services/rest_pokemon_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/pokemon_data_model.dart';

class PokemonViewModel extends BaseViewModel {
  bool isBusy = false;
  PokemonData? pokemonData;
  late int limit;
  final RefreshController refreshController = RefreshController();

  init() {
    isBusy = true;
    limit = 20;
    getPokemonsFromServices(limit);
  }

  setlimit() {
    if (pokemonData!.count - limit > 0) {
      limit = limit + 20;
    } else {
      limit = limit - pokemonData!.count;
    }
    return limit;
  }

  initPokemonData(value) {
    pokemonData = value;
    notifyListeners();
  }

  Future<bool> getPokemonsFromServices(int limit) =>
      RestPokemonService().getPokemons(limit).then((value) {
        isBusy = false;
        if (value.runtimeType == PokemonData) {
          initPokemonData(value);
          return true;
        } else {
          return false;
        }
      });
}
