import 'package:auth/pages/authScreen.dart';
import 'package:auth/pages/fireScree.dart';
import 'package:auth/pages/learnScreen.dart';
import 'package:auth/pages/userPage.dart';
import 'package:auth/providers/fireProvider.dart';
import 'package:auth/providers/learnProvider.dart';
import 'package:auth/providers/userProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return UserProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return FireProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return LearnProvider();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(),
          primarySwatch: Colors.yellow,
          accentColor: Colors.yellow,
        ),
        home: AuthScreen(),
      ),
    );
  }
}
