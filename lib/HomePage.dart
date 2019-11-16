import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

//* This is our AppBar
      appBar: AppBar(
        title: Text("Photo App & FireBase"),
        backgroundColor: Colors.orange[300],
        actions: <Widget>[

//* This is the two AppBar Icons
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => print("Search"),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => print("Add"),
          )
        ],
      ),

//* This is the App Drawer ( Side Menu )
      drawer: Drawer(
        child: ListView(
          children: <Widget>[

            UserAccountsDrawerHeader(
              accountName: Text("Brian Gurtz"),
              accountEmail: Text("bgurtz@gmail.com"),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent
              ),
            ),

//* This is our list of Menu options in the Drawer
//* There needs to be a new ListTitle for every Menu itme we create.
            ListTile(
              title: Text("First Page"),
              leading: Icon(Icons.search, color: Colors.green,),
            ),
            
            ListTile(
              title: Text("Second Page"),
              leading: Icon(Icons.add, color: Colors.green),
            ),

            ListTile(
              title: Text("Third Page"),
              leading: Icon(Icons.photo_album, color: Colors.blue),
            ),

//* Here we will add a Divider 
            Divider(
              height: 1.0,
              color: Colors.black,
            ),

//* Now we can add more itmes to our Drawer
//* We will add a Close button
            ListTile(
              title: Text("Close"),
              trailing: Icon(Icons.close, color: Colors.black),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        ),
      ),

    );
  }
}