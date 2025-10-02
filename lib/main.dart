
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movegui/firebase_options.dart';
import 'package:movegui/providers/theme_provider.dart';
import 'package:movegui/screens/auth/login_screen.dart';
import 'package:movegui/screens/auth/register_screen.dart';
import 'package:movegui/screens/movegui_screen.dart';
import 'package:movegui/screens/root_screen.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:provider/provider.dart';
import 'consts/theme_data.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    
    // ... other providers
  ]);

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
          title: 'Movegui',
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
                routes: {
        '/': (context) => RootScreen(currentScreen: 0, title: TitleManager.homeTitle,),
     //   'reservation': (context) => RootScreen(currentScreen:1, title: TitleManager.reservationTitle,),
        'commande': (context) => RootScreen(currentScreen:1, title: TitleManager.commandTitle,),
        'to_deliver': (context) => RootScreen(currentScreen:2, title: TitleManager.livraisonTitle,),
        'courses': (context) => RootScreen(currentScreen:3, title: TitleManager.courseTitle,),
         'movegui': (context) => MoveguiScreen(),
         'login': (context) => LoginScreen(),
         'enregistrer': (context) => RegisterScreenMovgui()
      },
      
       //  home: const ToggleButtonExample(),
        );
      }),
    );  
  }
}
