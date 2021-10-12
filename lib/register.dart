import 'package:flutter/material.dart';
import 'package:steam_wash_i_solna/dialogBox/errorDialog.dart';
import 'package:steam_wash_i_solna/globalVar.dart';
import 'package:steam_wash_i_solna/homeScreen.dart';
import 'package:steam_wash_i_solna/widgets/customTextfiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmfController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(15),
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CostomTextField(
                        _nameController, Icons.person, 'namn', false),
                    CostomTextField(
                        _emailController, Icons.email, 'E-post', false),
                    CostomTextField(
                        _phoneController, Icons.phone, 'Telefon', false),
                    CostomTextField(
                        _passwordController, Icons.lock, 'Lösenord', true),
                    CostomTextField(_passwordConfirmfController, Icons.lock,
                        'Bekräfta lösenord', true),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  elevation: 5,
                  child: MaterialButton(
                    onPressed: () {
                      _register();
                    },
                    minWidth: 250,
                    height: 45,
                    child: Text(
                      'Bli Medlem',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void _register() async {
    User currentUser;
    await _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((auth) {
      currentUser = auth.user!;
      userId = currentUser.uid;
      userEmail = currentUser.email!;
      getUsername = _nameController.text.trim();
      saveUserData();
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return ErrorAlertDialog(error.message.toString());
          });
    });
    // if (currentUser != null) {
    Route newRoute = MaterialPageRoute(builder: (context) => HomeScreen());
    Navigator.pushReplacement(context, newRoute);
    //}
  }

  void saveUserData() async {
    await FirebaseFirestore.instance.collection('user').doc(userId).set({
      'username': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'uId': userId,
      'phone': _phoneController.text.trim(),
      'code': '1',
      'counter': '0',
      'orders': '0',
      'time': DateTime.now()
    });
  }
}
