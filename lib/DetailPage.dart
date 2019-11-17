import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatefulWidget {
 // DetailPage({Key key}) : super(key: key);

  DocumentSnapshot snapshot;
  DetailPage({this.snapshot});


  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Castle & Town Details"),
        backgroundColor: Colors.green,
      ),

      body: ListView(
        children: <Widget>[

          Container(
            margin: EdgeInsets.all(5.0),
            child: Card(
              elevation: 10.0,
              
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[

                CircleAvatar(
                  child: Text(widget.snapshot.data["title"][0]),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                SizedBox(width: 10.0,),
                Text(widget.snapshot.data["title"],
                style: TextStyle(fontSize: 20.0, color: Colors.green),
                ),
              ],
            ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(10.0),
            child: ClipRRect(

              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(widget.snapshot.data["url"],
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              
              ),
            ),
          ),
          Container(
            child: Card(
              
            ),
          ),
        ],
      ),
    );
  }
}