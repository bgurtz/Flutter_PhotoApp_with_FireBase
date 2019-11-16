import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

//* The Stream Subscription below is what we are using to connect 
//* to FireBase to call our information from the DataBase and display it.
//* This Subscription is for the Horizontal Scroll at the top of the app.
  StreamSubscription<QuerySnapshot>subscription;
  List<DocumentSnapshot>snapshot;

  CollectionReference collectionReference=Firestore.instance.collection("TopPost");

  //* This Subscription for FireBase connect is for the ' Body '
  //* This will be the Vertical Scroll 
  StreamSubscription<QuerySnapshot>sdSubscription;
  List<DocumentSnapshot>sdSnapshot;

  CollectionReference sdcollectionReference=Firestore.instance.collection("BodyPost");

  @override
  void initState() {
  //* TopPost
    subscription=collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        snapshot=datasnapshot.documents;
          }
        );
      }
    );
//* BodyPost
    sdSubscription=sdcollectionReference.snapshots().listen((sddatasnap) {
      sdSnapshot=sddatasnap.documents;
      }
    );

    super.initState();
  }
  // End of the FireBase connect code for the TopPost


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


//* The code below is the Body of our app
//* This is what we are going to dispaly and
//* This is were the information from FireBase will be called to.
//* We have made a Container with a Card to dispaly our photos and 
//* gave it a Scroll Direction of Horizontal
//* our ClipRRect is being used to call out picture from FireBase

      body:  ListView(
        children: <Widget>[

//* TopPost Container
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: snapshot.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Card(
                  // color: Colors.brown[100],
                  elevation: 10.0,
                  margin: EdgeInsets.all(5.0),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                    children: <Widget>[
                     
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(snapshot[index].data["url"],
                        height: 130.0,
                          width: 130.0,
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(height: 10.0,),
                      Text(snapshot[index].data["title"],
                        style: TextStyle(fontSize: 18.0, color: Colors.blue[600]),
                      ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
//* End of the TopPost Container

          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              // scrollDirection: Axis.vertical,
              itemCount: sdSnapshot.length,
              itemBuilder: (context, index) {
                return Card(
                  // color: Colors.brown[100],
                  elevation: 7.0,
                  margin: EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[

                        Row(
                          children: <Widget>[

                            CircleAvatar(
                              child: Text(sdSnapshot[index].data["title"][0]),
                              backgroundColor: Colors.brown[200],
                              foregroundColor: Colors.white,
                            ),
                            SizedBox(width: 10.0,),
                            Text(sdSnapshot[index].data["title"],
                              style: TextStyle(fontSize: 20.0, color: Colors.blue[600]),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        Column(
                          children: <Widget>[

                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(sdSnapshot[index].data["url"],
                              height: 150.0,
                              width: MediaQuery.of(context).size.width,
                               fit: BoxFit.cover,
                              ),
                            ),
                            

                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.share),
                                Icon(Icons.thumb_up),
                                Icon(Icons.thumb_down),
                                Icon(Icons.favorite),
                              ],
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),

    );
  }
}