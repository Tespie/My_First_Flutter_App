// ignore_for_file: prefer_const_constructors

import 'package:My_First_Flutter_App/pages/first_page.dart';
import 'package:My_First_Flutter_App/pages/second_page.dart';
import 'package:My_First_Flutter_App/pages/settings_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:My_First_Flutter_App/auth/auth.dart';
import 'package:My_First_Flutter_App/auth/login_or_register.dart';
import 'package:My_First_Flutter_App/firebase_options.dart';
import 'package:My_First_Flutter_App/pages/home_page.dart';
import 'package:My_First_Flutter_App/pages/practice_page.dart';
import 'package:My_First_Flutter_App/pages/profile_page.dart';
import 'package:My_First_Flutter_App/pages/users_page.dart';
import 'package:My_First_Flutter_App/theme/dark_mode.dart';
import 'package:My_First_Flutter_App/theme/light_mode.dart';
import 'package:flutter/material.dart';

void main() async {
  //IMPORTANT : If you want binding to be initialized before calling [runApp].
  WidgetsFlutterBinding.ensureInitialized();

  // initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        /**
         * HIDE  -- DEBUG -- BANNER FROM TOP RIGHT CORNER
         */
        debugShowCheckedModeBanner: false,
        home: const AuthPage(), // full and final

        // home: PracticePage(),
        // home: HomePage(),

        // home: const LoginOrRegister(),
        // home: ProfilePage(),
        // home: UsersPage(),
        // home: FirstPage(),

        theme: lightMode,
        darkTheme: darkMode,
        title: "Tejas 1st Flutter App",
        themeMode: ThemeMode.system,
        routes: {
          'login_register_page': (context) => const LoginOrRegister(),
          'home_page': (context) => HomePage(),
          'profile_page': (context) => ProfilePage(),
          '/users_page': (context) => const UsersPage(),
          'practice_page': (context) => PracticePage(),
          'first_page': (context) => FirstPage(),
          'second_page': (context) => SecondPage(),
          'settings_page': (context) => SettingsPage(),
        },
      ),
    );
  }
}
