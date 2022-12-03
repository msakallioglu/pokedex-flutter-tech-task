import 'package:flutter/material.dart';
import '../core/extension/context_extension.dart';
import '../core/init/navigation/navigation_service.dart';

class CustomBottomNavBar extends StatelessWidget {
  final String pageName;
  const CustomBottomNavBar({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight(0.075),
      child: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: GestureDetector(
              onTap: pageName != "PokemonView"
                  ? () {
                      NavigationService.instance.navigateToPage(path: '/');
                    }
                  : null,
              child: Icon(
                Icons.list,
                color: pageName == "PokemonView" ? Colors.orange : Colors.black,
                size: context.screenHeight(0.05),
              ),
            )),
            Expanded(
              child: GestureDetector(
                  onTap: pageName != "FavoritePokemonsView"
                      ? () {
                          NavigationService.instance.navigateToPage(path: '/FavoritePokemonsView');
                        }
                      : null,
                  child: Icon(
                    Icons.favorite_border,
                    color: pageName == "FavoritePokemonsView" ? Colors.orange : Colors.black,
                    size: context.screenHeight(0.04),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
