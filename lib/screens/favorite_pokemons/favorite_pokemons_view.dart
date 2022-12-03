import 'package:flutter/material.dart';
import 'package:pokedex_tech_task/custom_widgets/custom_card.dart';
import 'package:provider/provider.dart';

import '../../core/base/base_view.dart';
import '../../core/extension/context_extension.dart';
import '../../core/theme/text_style_theme.dart';
import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_auto_size_text.dart';
import '../../custom_widgets/custom_bottom_nav_bar.dart';
import '../../providers/favorite_pokemons_provider.dart';
import 'favorite_pokemons_view_model.dart';

class FavoritePokemonsView extends StatelessWidget {
  const FavoritePokemonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<FavoritePokemonsViewModel>(
      onModelReady: ((model) {}),
      builder: ((context, model, child) => Scaffold(
          bottomNavigationBar: const CustomBottomNavBar(pageName: 'FavoritePokemonsView'),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(context.screenHeight(0.07)),
              child: const CustomAppBar(
                automaticallyImplyLeading: false,
              )),
          body: Provider.of<FavoritePokemonsProvider>(context).favoritePokemons.isEmpty
              ? Center(
                  child: CustomAutoSizeText(
                      text: "Favorite Pokemons List is Empty",
                      maxFontSize: 25,
                      minFontSize: 22,
                      maxLines: 2,
                      textStyle: getTextStyle(Colors.black, FontWeight.w400),
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  itemCount: Provider.of<FavoritePokemonsProvider>(context).favoritePokemons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: context.screenHeight(0.20),
                      childAspectRatio: 1,
                      crossAxisSpacing: 0.5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    String pokemonId = Provider.of<FavoritePokemonsProvider>(context)
                        .favoritePokemons
                        .keys
                        .elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/PokemonDetailsView", arguments: pokemonId);
                      },
                      child: CustomCard(
                          pakemoName: Provider.of<FavoritePokemonsProvider>(context)
                              .favoritePokemons[pokemonId]!,
                          pokemonId: pokemonId,
                          onPressed: (() => Provider.of<FavoritePokemonsProvider>(context,listen: false)
                              .removeFavoritePokemonToSharedPref(pokemonId))),
                    );
                  }))),
    );
  }
}
