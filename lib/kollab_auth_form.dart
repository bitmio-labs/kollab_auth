import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginModel {
  String email;
  String password;
}

class LoginForm extends StatefulWidget {
  final String emailLabel;
  final String passwordLabel;
  final String signupLabel;
  final String forgotLoginLabel;
  final String forgotLoginUrl;
  final Function(LoginModel, Function()) onCompletion;

  LoginForm(
      {this.emailLabel = "Email",
      this.passwordLabel = "Password",
      this.signupLabel = "Login",
      this.forgotLoginLabel = "Forgot login?",
      this.forgotLoginUrl,
      this.onCompletion});

  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _model = LoginModel();
  final focus = FocusNode();
  bool isLoading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  bool canSubmit() {
    return myController.text != "";
  }

  submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        isLoading = true;
      });

      widget.onCompletion(_model, () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  openForgotPassword() async {
    final url = widget.forgotLoginUrl;
    print("Opening url $url");
    if (await canLaunch(url)) {
      print("Can open url $url");
      await launch(url);
    } else {
      print("Cannot open url $url");
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        textInputAction: TextInputAction.next,
        obscureText: false,
        decoration: InputDecoration(hintText: widget.emailLabel),
        validator: (value) {
          if (value.isEmpty) {
            return '';
          }
          return null;
        },
        onChanged: (text) {},
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(focus);
        },
        onSaved: (text) {
          _model.email = text;
        });

    final passwordField = TextFormField(
        textInputAction: TextInputAction.send,
        focusNode: focus,
        obscureText: true,
        decoration: InputDecoration(hintText: widget.passwordLabel),
        validator: (value) {
          if (value.isEmpty) {
            return '';
          }
          return null;
        },
        onFieldSubmitted: (v) {
          submit();
        },
        onSaved: (text) {
          _model.password = text;
        });

    final signupButton = RaisedButton(
      onPressed: () {
        submit();
      },
      child: isLoading
          ? Container(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            )
          : Text(widget.signupLabel),
    );

    final forgotLoginButton = FlatButton(
      onPressed: openForgotPassword,
      child: Text(widget.forgotLoginLabel,
          style: Theme.of(context).textTheme.button.copyWith(
                color: Theme.of(context).textTheme.bodyText2.color,
              )),
    );

    return Padding(
      padding: const EdgeInsets.all(36.0),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              emailField,
              SizedBox(height: 25.0),
              passwordField,
              SizedBox(height: 35.0),
              Container(
                height: 52,
                width: double.infinity,
                child: signupButton,
              ),
              SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                child: forgotLoginButton,
              ),
              SizedBox(height: 15.0)
            ],
          )),
    );
  }
}
