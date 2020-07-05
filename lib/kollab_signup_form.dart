import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupModel {
  String email;
  String password;
}

class SignupForm extends StatefulWidget {
  final String emailLabel;
  final String passwordLabel;
  final String signupLabel;
  final String dataPolicyLabel;
  final String dataPolicyURL;
  final Function(SignupModel, Function()) onCompletion;

  SignupForm(
      {this.emailLabel = 'Email',
      this.passwordLabel = 'Password',
      this.signupLabel = 'Signup',
      this.dataPolicyLabel = 'By signing up you agree to our data policy.',
      this.dataPolicyURL,
      this.onCompletion});

  @override
  State<StatefulWidget> createState() {
    return _SignupFormState();
  }
}

class _SignupFormState extends State<SignupForm> {
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _model = SignupModel();
  final focus = FocusNode();
  bool isLoading = false;

  @override
  void dispose() {
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

  openDataPolicy(BuildContext context) async {
    final url = widget.dataPolicyURL;

    if (await canLaunch(url)) {
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

    return Padding(
      padding: const EdgeInsets.all(12.0),
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
              FlatButton(
                onPressed: () => openDataPolicy(context),
                child: Text(widget.dataPolicyLabel,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.button.copyWith(
                          color: Theme.of(context).textTheme.body1.color,
                        )),
              )
            ],
          )),
    );
  }
}
