import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movegui/app_router.dart';
import 'package:movegui/config/env.dart';
import 'package:movegui/config/env_dev.dart';
import 'package:movegui/config/firebase_config.dart';
import 'package:movegui/consts/theme_data.dart';
import 'package:movegui/firebase_options.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/providers/theme_provider.dart';
import 'package:movegui/services/register_services.dart';
import 'package:flutter_riverpod/legacy.dart' show ChangeNotifierProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<UserModel>('user_box');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final env = EnvDev();
  initServices(env);
  await FirebaseConfig.init(env);
  runApp(ProviderScope(child: MoveguiApp(env: env)));
}

class MoveguiApp extends ConsumerWidget {
  final Env env;

  const MoveguiApp({super.key, required this.env});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
final themeProvider = ChangeNotifierProvider<ThemeProvider>((ref) => ThemeProvider());
/*
final shoppingProvider = ChangeNotifierProvider((ref) => ShoppingProvider());
final appbarTitleProvider = ChangeNotifierProvider((ref) => AppbarTitleProvider());
final loginModProvider = ChangeNotifierProvider((ref) => LoginModProvider());
*/

    final router = ref.watch(AppRouter.routerProvider);

    return MaterialApp.router(
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
      title: 'Movegui',
          theme: Styles.themeData(ref.watch(themeProvider), isDarkTheme: false, context: context),
      routerConfig: router,
    );
  }
}


/*

--dart-define=GOOGLE_SIGN_IN_CLIENT_ID=56106440521-sbln1k8002597lnq65vpifniq7o9evga.apps.googleusercontent.com


flutter run --flavor dev -t lib/main_dev.dart --dart-define=GOOGLE_SIGN_IN_CLIENT_ID=56106440521-sbln1k8002597lnq65vpifniq7o9evga.apps.googleusercontent.com --web-hostname localhost --web-port 7555

*/