import 'package:flutter/material.dart';
import 'core/theme/theme.dart';
import 'providers/favorite_pokemons_provider.dart';
import 'package:provider/provider.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/navigation/route_generator.dart';
import 'locator.dart';

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await FavoritePokemonsProvider().createSharedPrefence();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: ((context) => FavoritePokemonsProvider()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Provider.of<FavoritePokemonsProvider>(context).setFavoritePokemons(); //Splash ekranı oluşturulup orada init işlemleri yapılmalı
    return MaterialApp(
      title: "PokeDex",
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: RouteGenerator.instance.routeGenerator,
    );
  }
}
