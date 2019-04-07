import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:bloodbank/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'dart:async';



class MyHomePage extends StatefulWidget {
  String _BloodGrp, _Qty;

  MyHomePage(this._BloodGrp, this._Qty);

  @override
  _MyHomePageState createState() => new _MyHomePageState(_BloodGrp, _Qty);
}

class _MyHomePageState extends State<MyHomePage> {

Future<void> Func() async {
  final FirebaseApp app = await FirebaseApp.configure(
      name: "Blood Bank",
      options: FirebaseOptions(
          googleAppID: '1:476120663832:android:84e448d6086da5e0',
          apiKey: 'AIzaSyDm5ZBJ0dOX1lgfG7KLKsd-KX1RDhVNyfw' ,
          databaseURL: 'https://bloodbank-abad9.firebaseio.com',
      ));


}
  @override
  void initState() {
    super.initState();

  }
  String _BloodGrp, _Qty,fullname,phoneNum;


  _MyHomePageState(this._BloodGrp, this._Qty);

  final DatabaseReference database = FirebaseDatabase.instance.
  reference().child("RequiredBlood");

  _SavedData(){

    database.push().set({
      'Blood Group' : _BloodGrp,
      'Quantity': '43',
      'Full name' : fullname,
      'Phone num:': '03213700598',
    });
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: Colors.red.withOpacity(0.8)),
              clipper: getClipper(),
            ),
            Positioned(
                width: 350.0,
                top: MediaQuery.of(context).size.height / 10,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ])),
                    SizedBox(height: 90.0),
                    Text(
                      'Zayan Tharani',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 15.0),
                    new Row(
                      children: <Widget>[
                        new Text(
                          "Blood Group",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        new Text(
                          _BloodGrp,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 15.0),
                    new Row(
                      children: <Widget>[
                        new Text(
                          "Quantity",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                        new Text(
                          _Qty.toString(),
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 15.0),
                    new Container(
                      child: new RaisedButton(
                        color: Colors.grey,
                        child: new Text(
                          "Request Blood",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: _SavedData,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 3);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
