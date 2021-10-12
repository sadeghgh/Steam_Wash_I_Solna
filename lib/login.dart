import 'package:flutter/material.dart';
import 'package:steam_wash_i_solna/dialogBox/errorDialog.dart';
import 'package:steam_wash_i_solna/dialogBox/loadingDialog.dart';
import 'package:steam_wash_i_solna/homeScreen.dart';
import 'package:steam_wash_i_solna/widgets/customTextfiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenheight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(15),
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CostomTextField(
                        _emailController, Icons.person, 'E-post', false),
                    CostomTextField(
                        _passwordController, Icons.lock, 'Lösenord', true)
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Material(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    elevation: 5,
                    child: MaterialButton(
                      onPressed: () {
                        _emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty
                            ? _login()
                            : showDialog(
                                context: context,
                                builder: (context) {
                                  return ErrorAlertDialog(
                                      'skriv nödvändig information för inloggning');
                                });
                      },
                      minWidth: 250,
                      height: 45,
                      child: Text(
                        'Logga in',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  void _login() async {
    showDialog(
        context: context,
        builder: (context) {
          return LoadingAlertDialog('Vänta');
        });

    User currentUser;
    await _auth
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((auth) {
      currentUser = auth.user!;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return ErrorAlertDialog(error.message.toString());
          });
    });

    //if(currentUser != null){
    Navigator.pop(context);
    Route newRoute = MaterialPageRoute(builder: (context) => HomeScreen());
    Navigator.pushReplacement(context, newRoute);
    //}else {
    // print('error');
    // }
  }
}
