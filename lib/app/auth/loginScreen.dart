import 'package:flutter/material.dart';
import 'package:testing/component/componentform.dart';
import 'package:testing/main.dart';

import '../../component/crud.dart';
import '../../constants/linkesapi.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final Curd _curd = Curd();

  login() async {
    var response = await _curd.postRequest(linkLogin, {
      'email': emailController.text,
      'password': passwordController.text,
    });
    if (response['status'] == "success") {
      sharedPref.setString("id", response['data']['id'].toString());
      sharedPref.setString("username", response['data']['username']);
      sharedPref.setString("email", response['data']['email']);
      Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Email must be not empty';
                      }
                      return null;
                    },
                    label: 'Email',
                    prefix: Icons.email,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Password must be not empty';
                      }
                      return null;
                    },
                    label: 'Password',
                    prefix: Icons.lock,
                    suffix: Icons.remove_red_eye,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await login();
                        }
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("signup");
                        },
                        child: const Text(
                          'Register Now',
                        ),
                      ),
                    ],
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
