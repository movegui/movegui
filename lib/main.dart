import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movegui/firebase_options.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:movegui/providers/theme_provider.dart';
import 'package:movegui/screens/root_screen.dart';
import 'package:movegui/services/register_services.dart';
import 'package:provider/provider.dart';
import 'consts/theme_data.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),

    // ... other providers
  ]);
  initServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
        final RouteObserver<ModalRoute<void>> rootObserver =
      RouteObserver<ModalRoute<void>>();


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ShoppingProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            navigatorObservers: [rootObserver],
            title: 'Movegui',
             navigatorKey: rootNavigatorKey,
            theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme,
              context: context,
            ),
            
            home: RootScreen(),
          );
        },
      ),
    );
  }
}

