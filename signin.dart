import 'package:flutter/material.dart';
import 'auth.dart';

class SignIn extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: email,
              decoration:
                  InputDecoration(icon: Icon(Icons.email), hintText: 'Email'),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: pass,
              decoration:
                  InputDecoration(icon: Icon(Icons.lock), hintText: 'Password'),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  signIn(email.value.text, pass.value.text, context);
                }
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
