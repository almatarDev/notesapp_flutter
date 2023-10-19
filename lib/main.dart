import 'package:flutter/material.dart';
import 'package:testing/app/auth/loginScreen.dart';
import 'package:testing/app/auth/signupscreen.dart';
import 'package:testing/app/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/notes/addnote.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  //await DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      initialRoute: "login",
      //initialRoute: sharedPref.getString("id") == null ? "login" : "home",
      routes: {
        "login": (context) => const LoginScreen(),
        "signup": (context) => const SignUpScreen(),
        "home": (context) => const HomeScreen(),
        "addnote": (context) => const AddNote(),
        // "home": (context) => const HomeScreen(),
        // "home": (context) => const HomeScreen(),
      },
    );
  }
}
