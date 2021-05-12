import 'package:auth/pages/profileScreen.dart';
import 'package:auth/providers/learnProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<LearnProvider>(context, listen: false);
    return Scaffold(
      body: user == null
          ? Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        onPressed: () {
                          Provider.of<LearnProvider>(context, listen: false);
                          auth.signInWithGoogle();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()));
                        },
                        child: Text('Login')),
                  ],
                ),
              ),
            )
          : ProfileScreen(),
    );
  }
}
