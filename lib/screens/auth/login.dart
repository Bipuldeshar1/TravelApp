import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/screens/Admin/adminHOme.dart';

import 'package:project_3/screens/Home/home.dart';
import 'package:project_3/screens/Home/nav.dart';

import '../../reusableComponent/CustomButton.dart';
import 'package:project_3/screens/auth/register.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController EmailController = TextEditingController();

  bool obsecureText = true;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'lib/assets/login.png',
          ),
          fit: BoxFit.fill,
        )),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: SingleChildScrollView(
              child: Center(
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 180,
                      ),
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: EmailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Email'),
                        validator: (value) {
                          const pattern =
                              r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                              r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                              r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                              r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                              r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                              r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                              r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                          final regex = RegExp(pattern);

                          if (value == null || value.isEmpty) {
                            return 'enter email';
                          } else if (!regex.hasMatch(value)) {
                            return 'enter valid email';
                          } else
                            return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: obsecureText,
                        controller: passwordController,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  obsecureText = !obsecureText;
                                });
                              },
                              child: Icon(
                                obsecureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'password'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter psw';
                          } else
                            return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('dont have an account !'),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()),
                                );
                              },
                              child: const Text(
                                'sign up',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        text: 'login',
                        onPress: () {
                          login(EmailController.text.toString(),
                              passwordController.text.toString());
                        },
                        color: Colors.blue,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login(String email, String password) async {
    try {
      UserCredential u = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      print(email);
      print(password);
      if (u.user != null) {
        // Navigator.popUntil(context, (route) => route.isFirst); //close all pages

        route();
      }
    } on FirebaseAuthException catch (e) {
      final snackbar = SnackBar(content: Text(e.code.toString()));
      await ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } catch (e) {
      print(e);
    }
  }

  route() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Users_Details')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot a) {
      if (a.exists) {
        if (a.get('role') == 'admin') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AdminHomescreen()));
          final snackbar = SnackBar(content: Text('successful  loggedin'));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BottomNav()));
          final snackbar = SnackBar(content: Text('successful  loggedin'));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      }
    });
 
  }
}
