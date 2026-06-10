import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/firebase_options.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/providers/appbar_title_provider.dart';
import 'package:movegui/providers/login_mod_provider.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:movegui/providers/theme_provider.dart';
import 'package:movegui/screens/auth/login_screen.dart';
import 'package:movegui/screens/auth/movegui_register_screen.dart';
import 'package:movegui/screens/main/movegui_profile_screen.dart';
import 'package:movegui/screens/modules/patisserie_screen.dart';
import 'package:movegui/screens/modules/pressing_screen.dart';
import 'package:movegui/screens/modules/resto_screen.dart';
import 'package:movegui/screens/modules/super_markt_screen.dart';
import 'package:movegui/services/register_services.dart';
import 'consts/theme_data.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  /*
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),

    // ... other providers
  ]);
  */
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
        ChangeNotifierProvider(create: (_) => AppbarTitleProvider()),
        ChangeNotifierProvider(create: (_) => LoginModProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
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
                    child: PressingScreen(),
                  );
                  break;

                case '/super_markt':
                  page = WebLayout(
                    child: SuperMarktScreen(navigatorKey: rootNavigatorKey),
                  );
                  break;
                case RouteConstants.REGISTER_ROUTE:
                  page = WebLayout(
                    child: MoveguiRegisterScreen(),
                  );
                  break;

                   case RouteConstants.LOGIN_ROUTE:
                  page = WebLayout(
                    child: LoginScreen(),
                  );
                  break;

                   case RouteConstants.PROFILE_ROUTE:
            final args = settings.arguments;
            if (args != null) {
              page = MoveguiProfileScreen(currentUser: args as UserModel);
            } else {
              page = MoveguiProfileScreen();
            }
            break;

                default:
                  page = RootScreen();
              }

              return MaterialPageRoute(
                builder: (_) => page,
                settings: settings,
              );
            },
          );
        },
      ),
    );
  }
}
