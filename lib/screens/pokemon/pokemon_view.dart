import 'package:flutter/material.dart';
import 'package:pokedex_tech_task/custom_widgets/custom_card.dart';
import '../../core/base/base_view.dart';
import '../../core/extension/context_extension.dart';
import '../../core/theme/text_style_theme.dart';
import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_auto_size_text.dart';
import '../../custom_widgets/custom_bottom_nav_bar.dart';
import '../../providers/favorite_pokemons_provider.dart';
import 'pokemon_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PokemonView extends StatelessWidget {
  const PokemonView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<PokemonViewModel>(
      onModelReady: ((model) {
        model.init();
      }),
      builder: ((context, model, child) => Scaffold(
          bottomNavigationBar: const CustomBottomNavBar(pageName: 'PokemonView'),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(context.screenHeight(0.07)),
              child: const CustomAppBar()),
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : model.pokemonData != null
                  ? SmartRefresher(
                      controller: model.refreshController,
                      enablePullUp: model.pokemonData!.next != null ? true : false,
                      enablePullDown: false,
                      onLoading: () async {
                        final result = await model.getPokemonsFromServices(model.setlimit());
                        if (result) {
                          model.refreshController.loadComplete();
                        } else {
                          model.refreshController.loadFailed();
                        }
                      },
                      child: buildPokemonList(model, context),
                    )
                  : CustomAutoSizeText(
                      text: "Oh no !",
                      maxFontSize: 15,
                      minFontSize: 12,
                      maxLines: 1,
                      textStyle: getTextStyle(Colors.orange, FontWeight.w400),
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center))),
    );
  }

  GridView buildPokemonList(PokemonViewModel model, BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: model.pokemonData!.results.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: context.screenHeight(0.20),
            childAspectRatio: 1,
            crossAxisSpacing: 0.5,
            mainAxisSpacing: 5,
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: (() {
                Navigator.pushNamed(context, "/PokemonDetailsView",
                    arguments: (index + 1).toString());
              }),
              child: CustomCard(
                  pakemoName: model.pokemonData!.results[index].name,
                  pokemonId: (index + 1).toString(),
                  onPressed: () => Provider.of<FavoritePokemonsProvider>(context, listen: false)
                      .setFavoritePokemonToSharedPref(
                          model.pokemonData!.results[index].name, (index + 1).toString())));
        });
  }
}
