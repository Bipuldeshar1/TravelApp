import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_input/dropdown_input.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:project_3/fxn/route.dart';
import 'package:project_3/reusableComponent/CustomButton.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_3/screens/auth/login.dart';

// class SingleValueDropDownController {
//   String _selectedValue = '';

//   String get selectedValue => _selectedValue;

//   set selectedValue(String value) {
//     _selectedValue = value;
//   }
// }

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  _RegisterState() {
    _selectedVal = _list[0];
  }
  TextEditingController nameController = TextEditingController();

  TextEditingController EmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obsecureText = true;

  final _list = [
    'user',
    'admin',
  ];
  String? _selectedVal = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'name'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: 'role',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    value: _selectedVal,
                    items: _list
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedVal = value as String;
                      });
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('already have an account !'),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                          child: const Text(
                            'log in',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: 'Register',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                      createAccount(
                          EmailController.text.toString(),
                          passwordController.text.toString(),
                          nameController.text.toString(),
                          _selectedVal.toString(),
                          phoneNumberController.toString());
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
    );
  }

  createAccount(String email, String password, String name, String role,
      String number) async {
    if (email == '' ||
        password == '' ||
        name == '' ||
        role == '' ||
        number == '') {
      final snackbar = SnackBar(
        content: Text('Field cannot be empty'),
        duration: Duration(seconds: 3),
      );
      await ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (password.length < 8) {
      final snackbar = SnackBar(
        content: Text('Password should be at least 8 characters long'),
        duration: Duration(seconds: 3),
      );
      await ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: email,
              password: password,
            )
            .then(
                (value) => PostDetailUser(email, name, role, password, number));
      } on FirebaseAuthException catch (e) {
        final snackbar = SnackBar(
          content: Text(e.code.toString()),
          duration: Duration(seconds: 3),
        );
        await ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }
  }

  PostDetailUser(
      String email, String name, String role, String password, pnum) {
    try {
      Fxn f = new Fxn();
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = FirebaseAuth.instance.currentUser;
      CollectionReference ref = firebaseFirestore.collection('users');
      ref.doc(user!.uid).set({
        'email': email.toString(),
        'role': role.toString(),
        'name': name.toString(),
        'password': password.toString(),
        'profilepic': '',
        'uid': FirebaseAuth.instance.currentUser!.uid,
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } catch (e) {
      print(e);
    }
  }
}
