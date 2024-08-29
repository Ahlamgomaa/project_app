import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/auth/register_page.dart';
import 'package:project/home_page.dart';
import 'package:project/widgets/custom_button.dart';
import 'package:project/widgets/custom_image.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/custom_text_form_field.dart';
import 'package:project/widgets/custom_textrich.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomImage(),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Login to continue using the App',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const CustomText(text: 'Email'),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    hinttext: 'Enter your email',
                    controller: email,
                    validator: (val) {
                      if (val == '') {
                        return 'field is required';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomText(text: 'Password'),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    hinttext: 'Enter your password',
                    controller: password,
                    obscureText: true,
                    validator: (val) {
                      if (val == '') {
                        return 'field is required';
                      }
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.topRight,
                    child: const Text(
                      textAlign: TextAlign.right,
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              text: 'Login',
              image: 'images/th (1).jpeg',
              onPressed: () async {
                if (key.currentState!.validate()) {
                  // Validate if email and password fields are not empty
                  if (email.text.isEmpty || password.text.isEmpty) {
                    _showAlertDialog(
                      context,
                      'Error',
                      'Please enter both email and password.',
                    );
                    return; // Stop execution if fields are empty
                  }

                  // Show loading indicator while waiting for Firebase response
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const Center(child: CircularProgressIndicator());
                    },
                  );

                  try {
                    // Try to sign in with the provided email and password
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email.text, password: password.text);

                    // If successful, navigate to the HomePage
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomePage();
                        },
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    Navigator.of(context).pop(); // Close the loading dialog

                    String errorMessage = '';
                    switch (e.code) {
                      case 'wrong-password':
                        errorMessage = 'Wrong password provided for that user.';
                        break;
                      case 'invalid-email':
                        errorMessage = 'The email address is not valid.';
                        break;
                      case 'too-many-requests':
                        errorMessage = 'Too many attempts. Try again later.';
                        break;
                      default:
                        errorMessage =
                            'Something went wrong. Please try again.';
                    }

                    // Show an AlertDialog with the appropriate error message
                    _showAlertDialog(context, 'Error', errorMessage);
                  }
                } else {
                  print('Not Valid');
                }
              },
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'OR Login with',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
              text: 'Login With Google',
              image: 'images/google-icon-1.png',
              onPressed: () {},
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextrich(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return const RegisterPage();
                    },
                  ),
                );
              },
              richText: "Don't have an account? ",
              spanText: 'Register',
            ),
          ],
        ),
      ),
    );
  }

  // Function to show an AlertDialog
  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
