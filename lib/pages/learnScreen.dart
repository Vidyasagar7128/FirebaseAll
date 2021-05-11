import 'package:auth/pages/uploadImage.dart';
import 'package:auth/providers/learnProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LearnScreen extends StatelessWidget {
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
    var provide = Provider.of<LearnProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
                splashRadius: 25.0,
                icon: Icon(Icons.image),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UploadImage()));
                }),
          )
        ],
      ),
      body: StreamBuilder(
          stream: provide.getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    child: ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                      ),
                      title: Text(snapshot.data.docs[index]['name']),
                      trailing: IconButton(
                        splashRadius: 25.0,
                        tooltip: snapshot.data.docs[index]['contact'],
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          provide.deleteData(snapshot.data.docs[index].id);
                          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                        },
                      ),
                    ),
                    background: Container(color: Colors.orange),
                    key: ValueKey('Deleted'),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.delete, color: Colors.white),
                            Text('Move to trash',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
