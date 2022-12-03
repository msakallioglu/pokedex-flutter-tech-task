import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import '../core/helpers/api_config.dart';
import '../models/pokemon_data_model.dart';
import 'pokemon_service.dart';

import '../models/pokemon_model.dart';

class RestPokemonService implements PokemonService {
  Dio? dio;

  RestPokemonService() {
    dio = Dio(BaseOptions());
  }

  @override
  Future getPokemons(int limit) async {
    try {
      Response response = await dio!.get("${ApiConfig.baseURL}?offset=0&limit=$limit");
      if (response.statusCode == HttpStatus.ok) {
        return PokemonData.fromJson(response.data);
      } else {}
    } catch (e) {
      
      log(e.toString());
    }
  }

  @override
  Future getPokemonsDetails(String pokemonId) async {
    try {
      Response response = await dio!.get("${ApiConfig.baseURL}/$pokemonId/");
      if (response.statusCode == HttpStatus.ok) {
        return Pokemon.fromJson(response.data);
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }
}
