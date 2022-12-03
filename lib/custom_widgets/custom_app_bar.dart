import 'package:flutter/material.dart';
import '../core/extension/context_extension.dart';
import '../providers/favorite_pokemons_provider.dart';
import 'package:provider/provider.dart';

import '../core/theme/text_style_theme.dart';
import 'custom_auto_size_text.dart';

class CustomAppBar extends StatelessWidget {
  final bool automaticallyImplyLeading ;
  const CustomAppBar({super.key,  this.automaticallyImplyLeading=false,});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: CustomAutoSizeText(
          text: "PokeDex",
          maxFontSize: 20,
          minFontSize: 18,
          maxLines: 1,
          textAlign: TextAlign.center,
          textScaleFactor: 1.0,
          textStyle: getTextStyle(Colors.orange, FontWeight.w400)),
      actions: [
        Padding(
          padding: context.paddingAll(context.screenHeight(0.01)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAutoSizeText(
                  text: Provider.of<FavoritePokemonsProvider>(context)
                      .favoritePokemons
                      .length
                      .toString(),
                  maxFontSize: 20,
                  minFontSize: 18,
                  maxLines: 1,
                  textStyle: getTextStyle(Colors.black, FontWeight.w400),
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.center),
              context.customSizeBoxWidgetWidth(context.screenWidth(0.01)),
              Icon(
                Icons.favorite,
                color: Colors.redAccent,
                size: context.screenWidth(0.1),
              )
            ],
          ),
        )
      ],
    );
  }
}
