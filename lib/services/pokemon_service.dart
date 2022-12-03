abstract class PokemonService {
  Future getPokemons(int limit);
  Future getPokemonsDetails(String pokemonId);
}
