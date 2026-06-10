import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movegui/screens/auth/login_screen.dart';

class StartScreen extends StatelessWidget {

   const StartScreen({
    super.key,
    required this.onTitleChange,
    required this.navigatorKey,
  });

    final Function(String) onTitleChange;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          return RootScreen(); // user logged in
        }

        return LoginScreen(
                      onTitleChange: this.onTitleChange,
                      navigatorKey: this.navigatorKey,
                    ); // user not logged in
      },
    );
  }
}