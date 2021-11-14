import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
    String phoneNr,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _isForgottPsw = false;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _phoneNr = '';

  final _auth = FirebaseAuth.instance;

  void resetPassword() async {
    _formKey.currentState!.save();
    await _auth.sendPasswordResetEmail(email: _userEmail.trim());
    setState(() {
      _isForgottPsw = false;
      _isLogin = true;
    });
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        _phoneNr,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('E-post'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Ange en giltig e -postadress';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'e -postadress Lable',
                    ),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  if (!_isForgottPsw)
                    TextFormField(
                      key: ValueKey('Lösenord'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Lösenordet måste vara minst 7 tecken långt.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Lösenord'),
                      obscureText: true,
                      onSaved: (value) {
                        _userPassword = value!;
                      },
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('Telefon'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 10) {
                          return 'Ange ditt kontaktnummer korrekt.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(labelText: 'Telefon'),
                      onSaved: (value) {
                        _phoneNr = value!;
                      },
                    ),
                  SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    if (!_isForgottPsw)
                      ElevatedButton(
                        child: Text(_isLogin ? 'Logga in' : 'Bli Medlem'),
                        onPressed: _trySubmit,
                      ),
                  if (!widget.isLoading)
                    if (!_isForgottPsw)
                      TextButton(
                        // textColor: Theme.of(context).primaryColor,
                        child: Text(
                          _isLogin ? 'skapa konto' : 'har ett konto',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                            _isForgottPsw = false;
                          });
                        },
                      ),
                  if (!widget.isLoading)
                    if ((_isLogin) && (!_isForgottPsw))
                      TextButton(
                        // textColor: Theme.of(context).primaryColor,
                        child: Text(
                          'glömt lösenordet',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isForgottPsw = !_isForgottPsw;
                          });
                        },
                      ),
                  if (_isForgottPsw)
                    ElevatedButton(
                      child: Text('Återställ lösenord'),
                      onPressed: resetPassword,
                    ),
                  if (_isForgottPsw)
                    TextButton(
                      // textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'tillbaka till login',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _isForgottPsw = !_isForgottPsw;
                          _isLogin = true;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
