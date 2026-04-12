import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movegui/firebase_options.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:movegui/providers/theme_provider.dart';
import 'package:movegui/screens/auth/login_screen.dart';
import 'package:movegui/screens/auth/register_screen.dart';
import 'package:movegui/screens/categories/patisserie_screen.dart';
import 'package:movegui/screens/categories/pressing_screen.dart';
import 'package:movegui/screens/categories/resto_screen.dart';
import 'package:movegui/screens/categories/super_markt_screen.dart';
import 'package:movegui/screens/root_screen.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/widgets/web/web_layout.dart';
import 'package:provider/provider.dart';
import 'consts/theme_data.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: Locale('fr'),
            supportedLocales: const [
              Locale('en'), // English
              Locale('fr'), // French
            ],
            navigatorObservers: [rootObserver],
            title: 'Movegui',
            navigatorKey: rootNavigatorKey,
            theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme,
              context: context,
            ),

            initialRoute: '/',
            onGenerateRoute: (settings) {
              Widget page;
              switch (settings.name) {
                /*
                case '/':
                  page = WebLayout(child: RootScreen());
                  break;
                  */

                case '/pastry':
                  page = WebLayout(
                    child: PatisserieScreen(navigatorKey: rootNavigatorKey),
                  );
                  break;

                case '/restaurant':
                  page = WebLayout(
                    child: RestoScreen(navigatorKey: rootNavigatorKey),
                  );
                  break;

                case '/pressing':
                  page = WebLayout(
                    child: PressingScreen(navigatorKey: rootNavigatorKey),
                  );
                  break;

                case '/super_markt':
                  page = WebLayout(
                    child: SuperMarktScreen(navigatorKey: rootNavigatorKey),
                  );
                  break;

                case '/login':
                  page = WebLayout(
                    child: LoginScreen(
                      onTitleChange: (_) {},
                      navigatorKey: rootNavigatorKey,
                    ),
                  );
                  break;

                case '/register':
                  page = WebLayout(
                    child: RegisterScreenMovgui(
                      onTitleChange: (_) {},
                      navigatorKey: rootNavigatorKey,
                    ),
                  );
                  break;

                default:
                  page = RootScreen();
                /*
                  StartScreen(onTitleChange: (_) {},
                      navigatorKey: rootNavigatorKey,)
                      */ //RootScreen();
              }

              return MaterialPageRoute(
                builder: (_) => page,
                settings: settings,
              );

              /*
              switch (settings.name) {
                case '/':
                  page = RootScreen();
                  break;

                case '/login':
                  page = LoginScreen(
                    onTitleChange: (_) {},
                    navigatorKey: rootNavigatorKey,
                  );
                  break;

                case '/restaurant':
                  page = RestoScreen(navigatorKey: rootNavigatorKey);
                  break;

                default:
                  page = RootScreen();
              }

              return MaterialPageRoute(
                builder: (_) => page,
                settings: settings,
              );
            },
            */

              //     home: RootScreen(),
            },
          );
        },
      ),
    );
  }
}
