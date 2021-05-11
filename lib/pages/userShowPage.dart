import 'package:auth/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserShowPage extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(title: Text('List')),
      body: Consumer<UserProvider>(
        builder: (context, itemNotifier, _) {
          print('From Provider ====== ${itemNotifier.userList.length}');
          return ListView.builder(
              itemCount: itemNotifier.userList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: IconButton(
                    splashRadius: 25.0,
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    tooltip: itemNotifier.userList[index].name.toString(),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      itemNotifier.removeUser(itemNotifier.userList[index]);
                    },
                  ),
                  title: Text(itemNotifier.userList[index].name.toString()),
                  subtitle: Text(itemNotifier.userList[index].age.toString()),
                );
              });
        },
      ),
    );
  }
}
