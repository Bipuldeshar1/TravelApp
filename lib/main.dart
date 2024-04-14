import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:project_3/model/firebasehelper.dart';
import 'package:project_3/model/userModel.dart';

import 'package:project_3/screens/Home/nav.dart';
import 'package:project_3/screens/auth/login.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    // Logged In
    UserModel? thisUserModel =
        await FirebaseHelper.getUserModelById(currentUser.uid);
    if (thisUserModel != null) {
      runApp(
          MyAppLoggedIn(userModel: thisUserModel, firebaseUser: currentUser));
    } else {
      runApp(const MyApp());
    }
  } else {
    // Not logged in
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel userModel;
    final User firebaseUser;
    // Hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return KhaltiScope(
        publicKey: 'xxx',
        builder: (context, navigatorKey) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              home: const Login());
        });
  }
}

// Already Logged In
class MyAppLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  const MyAppLoggedIn(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return KhaltiScope(
        publicKey: 'txxx',
        builder: (context, navigatorKey) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            home: BottomNav(
              firebaseUser: firebaseUser,
              userModel: userModel,
            ),
            // home: AdminHomescreen(),
          );
        });
  }
}
