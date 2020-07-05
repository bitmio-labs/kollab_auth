import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomeWidget extends StatelessWidget {
  final String loginLabel;
  final String discoverLabel;
  final String heroText;
  final String registerLabel;
  final Image backgroundImage;
  final Image logo;

  WelcomeWidget(
      {this.heroText = "Build more with Bitmio.",
      this.loginLabel = "Login",
      this.discoverLabel = "Explore",
      this.registerLabel = "No account yet? Register",
      this.backgroundImage,
      this.logo});

  @override
  Widget build(BuildContext context) {
    final heroLabel = Text(
      heroText.toUpperCase(),
      style: Theme.of(context)
          .textTheme
          .headline4
          .copyWith(color: Colors.white, shadows: [
        Shadow(
          offset: Offset(0, 0),
          blurRadius: 10.0,
          color: Colors.black.withOpacity(0.9),
        )
      ]),
    );

    final discoverButton = FlatButton(
      color: Theme.of(context).colorScheme.onSecondary,
      textColor: Theme.of(context).textTheme.button.color,
      onPressed: () => explore(context),
      child: FittedBox(fit: BoxFit.fitWidth, child: Text(discoverLabel)),
    );

    final loginButton = RaisedButton(
      onPressed: () => login(context),
      child: FittedBox(fit: BoxFit.fitWidth, child: Text(loginLabel)),
    );

    final registerButton = FlatButton(
      onPressed: () => signup(context),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(registerLabel,
            style: Theme.of(context).textTheme.button.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                )),
      ),
    );

    return Stack(children: <Widget>[
      BackgroundImage(image: backgroundImage),
      if (logo != null)
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            child: Align(
              alignment: Alignment.topCenter,
              child: AspectRatio(
                aspectRatio: 8 / 11,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  color: Colors.white,
                  padding: EdgeInsets.all(7),
                  child: logo,
                ),
              ),
            ),
          ),
        ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: heroLabel,
                        ),
                        Container(height: 20),
                        Container(width: double.infinity, child: loginButton),
                        Container(height: 10),
                        Container(
                            width: double.infinity, child: discoverButton),
                        Container(height: 20),
                        Container(
                            width: double.infinity, child: registerButton),
                      ],
                    )))
          ],
        ),
      )
    ]);
  }

  login(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }

  explore(BuildContext context) {
    Navigator.pushNamed(context, '/explore');
  }

  signup(BuildContext context) {
    Navigator.pushNamed(context, '/signup');
  }
}

class BackgroundImage extends StatelessWidget {
  final Image image;

  BackgroundImage({this.image});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
            image: DecorationImage(image: image.image, fit: BoxFit.cover)),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
            )));
  }
}
