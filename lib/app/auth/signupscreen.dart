import 'package:flutter/material.dart';
import 'package:testing/component/crud.dart';
import 'package:testing/constants/linkesapi.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  Curd crud = Curd();
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  signUp() async {
    // await DioHelper.postData(url: linkSignUp, data: {
    //   'username': usernameController.text,
    //   'email': emailController.text,
    //   'password': passwordController.text,
    // }).then((value) {
    //   print(value.data);
    // });
    try {
      var response = await crud.postRequest(linkSignUp, {
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      });
      if (response['status'] == "success") {
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      }
    } catch (e) {
      print('my error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      appBar: AppBar(),
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
                    'SignUp',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    // onFieldSubmitted: (String value) {
                    //   print(value);
                    // },
                    // onChanged: (String value) {
                    //   print(value);
                    // },
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    // onFieldSubmitted: (String value) {
                    //   print(value);
                    // },
                    // onChanged: (String value) {
                    //   print(value);
                    // },
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    // onFieldSubmitted: (String value) {
                    //   print(value);
                    // },
                    // onChanged: (String value) {
                    //   print(value);
                    // },
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      suffixIcon: Icon(
                        Icons.remove_red_eye,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
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
                        await signUp();
                      },
                      child: const Text(
                        'Sign Up ->',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () async {},
                      child: const Text(
                        'Test',
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
                        'Do you have an account?',
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("login");
                        },
                        child: const Text(
                          'Login Now',
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
