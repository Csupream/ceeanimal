import 'package:ceeanimal/utility/my_constant.dart';
import 'package:ceeanimal/utility/normal_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingIn extends StatefulWidget {
  @override
  _SingInState createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
//Field
  String email, password;

//Method
  Widget signInButton() {
    return Container(
      width: 250.0,
      child: OutlineButton.icon(
        onPressed: () {
          if (email == null ||
              email.isEmpty ||
              password == null ||
              password.isEmpty) {
            normalDialog(context, 'Have Space', 'Please Fill Every Blank');
          } else {
            checkAuthenThread();
          }
        },
        icon: Icon(Icons.input),
        label: Text('Sign In'),
      ),
    );
  }

  Future<void> checkAuthenThread() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((response) {
          Navigator.of(context).pop();
        })
        .catchError((response){
          String title = response.code;
          String message = response.message;
          normalDialog(context, title, message);
        });
  }

  Widget emailForm() {
    return Container(
      width: 250.0,
      child: TextField(
        onChanged: (value) {
          email = value.trim();
        },
        keyboardType: TextInputType.emailAddress,
        decoration:
            InputDecoration(prefixIcon: Icon(Icons.email), hintText: 'Email :'),
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      width: 250.0,
      child: TextField(
        onChanged: (value) {
          password = value.trim();
        },
        obscureText: true,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock), hintText: 'Password :'),
      ),
    );
  }

  Widget showAppName() {
    return Text(
      'Cee Animal',
      style: MyConstant().titleH1,
    );
  }

  Widget showLogo() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              showLogo(),
              showAppName(),
              emailForm(),
              passwordForm(),
              MyConstant().mySizebox,
              signInButton(),
            ],
          ),
        ),
      ),
    );
  }
}
