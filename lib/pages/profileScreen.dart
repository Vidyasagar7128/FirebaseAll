import 'package:auth/pages/authScreen.dart';
import 'package:auth/providers/learnProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<LearnProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData == null) {
              return AuthScreen();
            } else {
              return User();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AuthScreen()));
          auth.logOut();
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: user == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL),
              ),
              title: Text(user?.email),
              subtitle: Text(user?.displayName),
            ),
    );
  }
}
