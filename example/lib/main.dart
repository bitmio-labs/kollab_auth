import 'package:flutter/material.dart';
import 'package:kollab_auth/kollab_auth.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final background = Image.asset(
      'assets/background.png',
      fit: BoxFit.cover,
    );

    final logoImage = Image.asset('assets/logo.png');

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Widgets(),
        '/welcome': (context) => WelcomeWidget(
              backgroundImage: background,
              logo: logoImage,
            ),
        '/login': (context) => HeaderDetailWidget(
            detail: MyLogin(), background: background, logo: logoImage),
        '/signup': (context) => HeaderDetailWidget(
            detail: MySignup(), background: background, logo: logoImage),
      },
    );
  }
}

class Widgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Card(
              child: ListTile(
            title: Text('Welcome'),
            onTap: () => {Navigator.pushNamed(context, '/welcome')},
          )),
          Card(
              child: ListTile(
            title: Text('Login'),
            onTap: () => {Navigator.pushNamed(context, '/login')},
          )),
          Card(
              child: ListTile(
            title: Text('Signup'),
            onTap: () => {Navigator.pushNamed(context, '/signup')},
          ))
        ],
      ),
    );
  }
}

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() {
    return _MyLoginState();
  }
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    return LoginForm(
        forgotLoginUrl: 'https://bitmio.com/demo/forgot-login',
        onCompletion: (model, callback) {
          print('Login ${model.email} - ${model.password}');

          Future.delayed(const Duration(milliseconds: 1000), () {
            callback();
          });
        });
  }
}

class MySignup extends StatefulWidget {
  @override
  _MySignupState createState() {
    return _MySignupState();
  }
}

class _MySignupState extends State<MySignup> {
  @override
  Widget build(BuildContext context) {
    return SignupForm(onCompletion: (model, callback) {
      print('Signup ${model.email} - ${model.password}');

      Future.delayed(const Duration(milliseconds: 1000), () {
        callback();
      });
    });
  }
}
