import 'package:auth/pages/userShowPage.dart';
import 'package:auth/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  final UserProvider userProvider = UserProvider();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final SnackBar _snackBar = SnackBar(
    backgroundColor: Colors.teal,
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {},
    ),
    content: const Text('Added Sucessfully'),
    duration: const Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
    width: 300.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _name,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _age,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              SizedBox(height: 20.0),
              MaterialButton(
                onPressed: () async {
                  {
                    if (_formkey.currentState.validate()) {
                      _formkey.currentState.save();
                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      print(_name.text);
                      Provider.of<UserProvider>(context, listen: false)
                          .addUser(_name.text, _age.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserShowPage()));
                    }
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
