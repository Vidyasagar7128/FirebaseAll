import 'package:auth/models/demoUser.dart';
import 'package:auth/providers/fireProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FireScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final SnackBar _snackBar = SnackBar(
    backgroundColor: Colors.teal,
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {},
    ),
    content: const Text('Deleted Sucessfully'),
    duration: const Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
    width: 300.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
  );
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<FireProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
                splashRadius: 25.0,
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateUser()));
                }),
          )
        ],
      ),
      body: StreamBuilder<List<DemoUser>>(
          stream: data.getUser(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                  trailing: IconButton(
                    splashRadius: 25.0,
                    tooltip: snapshot.data[index].contact,
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      print(snapshot.data[index]);
                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                    },
                  ),
                  title: Text(snapshot.data[index].name.toString()),
                  subtitle: Text(snapshot.data[index].demoUserClass.toString()),
                );
              },
            );
          }),
    );
  }
}

class CreateUser extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _class = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  Widget input(control, String label) {
    return TextFormField(
      controller: control,
      decoration: InputDecoration(labelText: label),
    );
  }

  final SnackBar _snackBar = SnackBar(
    backgroundColor: Colors.teal,
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {},
    ),
    content: const Text('Created Sucessfully'),
    duration: const Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
    width: 300.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create User')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  input(_name, 'Name'),
                  SizedBox(height: 20.0),
                  input(_age, 'Age'),
                  SizedBox(height: 20.0),
                  input(_class, 'Class'),
                  SizedBox(height: 20.0),
                  input(_contact, 'Contact'),
                  SizedBox(height: 30.0),
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                        var data =
                            Provider.of<FireProvider>(context, listen: false);
                        data.createUser(
                            _name.text, _age.text, _class.text, _contact.text);
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FireScreen()));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
