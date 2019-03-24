import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';
import 'auth.dart';

class SignUpPage extends StatefulWidget {
  final BaseAuth auth;
  SignUpPage({this.auth});

  @override
  State<StatefulWidget> createState() => new _SignUpPageState();
}

enum FormType {
  login,
  register
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = new GlobalKey<FormState>();
  FirebaseDatabase database = FirebaseDatabase.instance;

  String _fullName;
  String _email;
  String _password;
  String _phoneNumber;
  bool _isBloodBank = false;
  String _bloodGroup;




  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print("Form is valid");
      return true;
    }
    return false;
  }

  Future validateAndSubmit () async {

    if (validateAndSave()){
      try {

        String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
        print("User created " + userId);
        database.reference().child('Users').child(userId).set({
          
          "Full Name": _fullName,
          "Email" : _email,
          "Phone" : _phoneNumber,
          "isBloodBank" : _isBloodBank,
          "BloodGroup" : _bloodGroup
        });
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(auth: new Auth())));
        final scaffold = Scaffold.of(context);
        scaffold.showSnackBar(
            SnackBar(
                content: const Text('User created')
            )
        );

      }
      catch (e){

        print("User not created " + e.toString());
    }
    }

  }


  Future moveToLogin () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(auth: new Auth())));
  }

  void _onChanged1(bool value) => setState(() => _isBloodBank = value);




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.black,
        body: new Stack(fit: StackFit.expand, children: <Widget>[

            new Form(
              key: _formKey,
              child: new Theme(
                data: new ThemeData(
                    brightness: Brightness.dark,
                    primarySwatch: Colors.teal,
                    inputDecorationTheme: new InputDecorationTheme(
                        labelStyle:
                            new TextStyle(color: Colors.teal, fontSize: 20.0))),
                child: new Container(
                  padding: const EdgeInsets.all(40.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Full Name",
                        ),
                        keyboardType: TextInputType.text,
                        validator: (input) => input.isEmpty ? 'Full Name cannot be empty' : null,
                        onSaved: (input) => _fullName = input,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (input) => input.isEmpty ? 'Email cannot be empty' : null,
                        onSaved: (input) => _email= input,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Password",
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        validator: (input) => input.isEmpty ? 'Password cannot be empty' : null,
                        onSaved: (input) => _password = input,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Phone Number",
                        ),
                        keyboardType: TextInputType.text,
                        validator: (input) => input.isEmpty ? 'Phone Number cannot be empty' : null,
                        onSaved: (input) => _phoneNumber = input,
                      ),
                      new Row(
                        children: <Widget>[
                      new Text("Blood Group",style: TextStyle(fontSize: 20.0,fontWeight:  FontWeight.bold, color: Colors.teal)),
                      new Padding(
                          padding: const EdgeInsets.only(right: 100.0)
                      ),
                      DropdownButton<String>(
                          value: _bloodGroup,
                          onChanged: (String newValue) {
                            setState(() {
                              _bloodGroup = newValue;
                            });
                          },
                          items: <String>["A+","A-","B+","B-","O+","O-","AB+","AB-"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      )
                      ]
                      ),

                      new Padding(padding: const EdgeInsets.only(top: 20.0)),
                      new RaisedButton(
                        child: new Text("Register"),
                          onPressed: validateAndSubmit),
                      new FlatButton(
                        child: new Text("Have an account? Login"),
                          onPressed : moveToLogin,
                      )
                    ],
                  ),
                ),
              ),
            )
          ])
        );
  }
}
