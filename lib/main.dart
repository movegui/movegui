import 'package:flutter/material.dart';
import 'package:movegui/providers/theme_provider.dart';
import 'package:movegui/screens/movegui_screen.dart';
import 'package:movegui/screens/root_screen.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:provider/provider.dart';
import 'consts/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return ThemeProvider();
        })
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'ShopSmart EN',
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
                routes: {
        '/': (context) => RootScreen(currentScreen: 0, title: TitleManager.homeTitle,),
        'reservation': (context) => RootScreen(currentScreen:1, title: TitleManager.reservationTitle,),
        'commande': (context) => RootScreen(currentScreen:2, title: TitleManager.commandTitle,),
        'to_deliver': (context) => RootScreen(currentScreen:3, title: TitleManager.livraisonTitle,),
         'movegui': (context) => MoveguiScreen(),
      },
      
       //  home: const ToggleButtonExample(),
        );
      }),
    );  
  }
}
