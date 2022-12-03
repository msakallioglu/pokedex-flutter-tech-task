

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_tech_task/core/theme/text_style_theme.dart';
import 'package:pokedex_tech_task/custom_widgets/custom_auto_size_text.dart';
import 'package:pokedex_tech_task/screens/pokemon_details/pokemon_details_view_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/base/base_view.dart';
import '../../core/extension/context_extension.dart';
import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_bottom_nav_bar.dart';
import '../../providers/favorite_pokemons_provider.dart';

class PokemonDetailsView extends StatelessWidget {
  final String pokemonId;
  const PokemonDetailsView({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    return BaseView<PokemonDetailsViewModel>(
      onModelReady: ((model) {
        model.init(pokemonId);
      }),
      builder: ((context, model, child) => Scaffold(
            bottomNavigationBar: const CustomBottomNavBar(pageName: 'FavoritePokemonsView'),
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(context.screenHeight(0.07)),
                child: const CustomAppBar(automaticallyImplyLeading: true,)),
            body: model.isBusy
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.screenWidth(0.05)),
                    child: ListView(
                      children: [
                        buildPokemonNameId(model, context),
                        model.imagePath.isNotEmpty
                            ? Column(
                                children: [
                                  buildPokemonImages(model, context),
                                  buildIndicator(context, model),
                                ],
                              )
                            : Container(),
                        buildTab(context, model),
                      ],
                    ),
                  ),
          )),
    );
  }

   CarouselSlider buildPokemonImages(PokemonDetailsViewModel model, BuildContext context) {
    return CarouselSlider.builder(
      itemCount: model.imagePath.length,
      options: CarouselOptions(
          height: context.screenHeight(0.25),
          viewportFraction: 1,
          autoPlay: false,
          autoPlayAnimationDuration: const Duration(microseconds: 5000),
          onPageChanged: (index, reason) {
            model.setIndicator(index);
          }),
      itemBuilder: (context, index, realIndex) {
        var imagePath = model.imagePath[index];
        return buildImage(imagePath, index, model, context);
      },
    );
  }

  Widget buildImage(String imagePath, int index, model, BuildContext context) {
    return Center(
      child: CachedNetworkImage(
        imageUrl: imagePath,
        height: context.screenHeight(0.2),
        errorWidget: (context, error, stackTrace) {
          return const Icon(
            Icons.error,
          );
        },
      ),
    );
  }

  buildIndicator(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.only(left: context.screenWidth(0.02), bottom: context.screenHeight(0.02)),
      child: AnimatedSmoothIndicator(
        activeIndex: model.activeIndex,
        count: model.imagePath.length,
        effect: JumpingDotEffect(
          activeDotColor: Colors.orange,
          dotColor: Colors.grey.shade500,
          dotWidth: context.screenWidth(0.02),
          dotHeight: context.screenHeight(0.01),
          spacing: 2,
        ),
      ),
    );
  }

  Row buildPokemonNameId(PokemonDetailsViewModel model, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomAutoSizeText(
                text: '#${model.selectedPokemon?.id.toString()}',
                maxFontSize: 14,
                minFontSize: 12,
                maxLines: 1,
                textStyle: getTextStyle(Colors.black, FontWeight.w400),
                textScaleFactor: 1.0,
                textAlign: TextAlign.center),
            buildFavoriteButton(context, model),
          ],
        ),
        Column(
          children: [
            CustomAutoSizeText(
                text: '${model.selectedPokemon?.name.toUpperCase()}',
                maxFontSize: 14,
                minFontSize: 12,
                maxLines: 1,
                textStyle: getTextStyle(Colors.black, FontWeight.bold),
                textScaleFactor: 1.0,
                textAlign: TextAlign.center),
            for (int i = 0; i < model.selectedPokemon!.types.length; i++)
              buidType(context, model, i),
          ],
        ),
      ],
    );
  }

  Align buildFavoriteButton(BuildContext context, PokemonDetailsViewModel model) {
    return Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: (() {
            Provider.of<FavoritePokemonsProvider>(context, listen: false)
                .setFavoritePokemonToSharedPref(
                    model.selectedPokemon!.name.toString(), model.selectedPokemon!.id.toString());
          }),
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.favorite,
                color: Provider.of<FavoritePokemonsProvider>(context)
                            .getFavoritePokemonToSharedPref(
                                (model.selectedPokemon!.id).toString()) ==
                        "0"
                    ? Colors.grey.shade300
                    : Colors.redAccent,
                size: context.screenWidth(0.1),
              )),
        ));
  }

  Column buidType(BuildContext context, PokemonDetailsViewModel model, int i) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: context.screenWidth(0.02), vertical: context.screenHeight(0.005)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.amber,
          ),
          child: CustomAutoSizeText(
              text: '${model.selectedPokemon?.types[i].type.name}',
              maxFontSize: 20,
              minFontSize: 18,
              maxLines: 5,
              textStyle: getTextStyle(Colors.black, FontWeight.w400),
              textScaleFactor: 1.0,
              textAlign: TextAlign.start),
        ),
        const Text(
          '\n',
          textScaleFactor: 0.2,
        )
      ],
    );
  }

  DefaultTabController buildTab(BuildContext context, PokemonDetailsViewModel model) {
    return DefaultTabController(
      length: 2, // length of tabs
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const TabBar(
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: 'Features'),
              Tab(text: 'Base Stats'),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.screenWidth(0.0), vertical: context.screenHeight(0.02)),
            height: context.screenHeight(0.4),
            width: context.screenWidth(1),
            child: TabBarView(children: [buildFeatures(model), buildStat(model,context)]),
          )
        ],
      ),
    );
  }

  Column buildStat(PokemonDetailsViewModel model,BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < model.selectedPokemon!.stats.length; i++)
          Row(
            children: [
              CustomAutoSizeText(
                  text:
                      '${model.selectedPokemon?.stats[i].stat.name.toUpperCase()} :   ',
                  maxFontSize: 20,
                  minFontSize: 18,
                  maxLines: 5,
                  textStyle: getTextStyle(Colors.black, FontWeight.w400),
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.start),
             SizedBox(height: context.screenHeight(0.02),width: context.screenWidth(0.3),
              child: LinearProgressIndicator(color:Colors.orange,backgroundColor:Colors.grey.shade300,value: model.selectedPokemon!.stats[i].baseStat.toDouble()/100.toDouble(),))
             ,CustomAutoSizeText(
                  text:
                      ' ${model.selectedPokemon?.stats[i].baseStat}',
                  maxFontSize: 13,
                  minFontSize: 11,
                  maxLines: 1,
                  textStyle: getTextStyle(Colors.black, FontWeight.w400),
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.start),
            ],
          ),
      ],
    );
  }

  Column buildFeatures(PokemonDetailsViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomAutoSizeText(
            text: 'Height : ${model.selectedPokemon?.height.toString()} M',
            maxFontSize: 20,
            minFontSize: 18,
            maxLines: 1,
            textStyle: getTextStyle(Colors.black, FontWeight.w400),
            textScaleFactor: 1.0,
            textAlign: TextAlign.center),
        CustomAutoSizeText(
            text: 'Weight : ${model.selectedPokemon?.weight.toString()} KG',
            maxFontSize: 20,
            minFontSize: 18,
            maxLines: 1,
            textStyle: getTextStyle(Colors.black, FontWeight.w400),
            textScaleFactor: 1.0,
            textAlign: TextAlign.center),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAutoSizeText(
                text: 'Abilities: ',
                maxFontSize: 20,
                minFontSize: 18,
                maxLines: 1,
                textStyle: getTextStyle(Colors.black, FontWeight.w400),
                textScaleFactor: 1.0,
                textAlign: TextAlign.center),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < model.selectedPokemon!.abilities.length; i++)
                  CustomAutoSizeText(
                      text: '${model.selectedPokemon?.abilities[i].ability.name.toUpperCase()} ',
                      maxFontSize: 20,
                      minFontSize: 18,
                      maxLines: 5,
                      textStyle: getTextStyle(Colors.black, FontWeight.w400),
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.start),
              ],
            )
          ],
        ),
        Row(
          children: [
            CustomAutoSizeText(
                text: 'Base Experience : ',
                maxFontSize: 20,
                minFontSize: 18,
                maxLines: 5,
                textStyle: getTextStyle(Colors.black, FontWeight.w400),
                textScaleFactor: 1.0,
                textAlign: TextAlign.start),
            CustomAutoSizeText(
                text: '${model.selectedPokemon?.baseExperience} ',
                maxFontSize: 20,
                minFontSize: 18,
                maxLines: 5,
                textStyle: getTextStyle(Colors.black, FontWeight.w400),
                textScaleFactor: 1.0,
                textAlign: TextAlign.start),
          ],
        ),
      ],
    );
  }
}
