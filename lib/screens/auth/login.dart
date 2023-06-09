import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/fxn/route.dart';
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
  Fxn f = new Fxn();
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
                        height: 250,
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
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'enter psw';
                        //   }
                        //   return null;
                        // },
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
    if (email == '' || password == '') {
      final snackbar = SnackBar(
        content: Text('field cannot be empty'),
        duration: Duration(seconds: 3),
      );
      await ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      try {
        UserCredential u = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.toString(), password: password.toString());
        print(email);
        print(password);
        if (u.user != null) {
          // Navigator.popUntil(context, (route) => route.isFirst); //close all pages

          f.route(context);
        }
      } on FirebaseAuthException catch (e) {
        final snackbar = SnackBar(
          content: Text(e.code.toString()),
          duration: Duration(seconds: 3),
        );
        await ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } catch (e) {
        print(e);
      }
    }
  }
}
