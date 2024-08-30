import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/auth/login_page.dart';

import 'package:project/widgets/custom_button.dart';
import 'package:project/widgets/custom_image.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/custom_text_form_field.dart';
import 'package:project/widgets/custom_textrich.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();

  // Method to show AlertDialog
  void showErrorDialog(String title, String message,
      {bool navigateToLogin = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                if (navigateToLogin) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
                  const SizedBox(height: 30),
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter your Personal Information',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  const CustomText(text: 'Username'),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hinttext: 'Enter your username',
                    controller: username,
                    validator: (val) {
                      if (val == '') {
                        return 'field is required';
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  const CustomText(text: 'Email'),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hinttext: 'Enter your email',
                    controller: email,
                    validator: (val) {
                      if (val == '') {
                        return 'field is required';
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  const CustomText(text: 'Password'),
                  const SizedBox(height: 5),
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
                  const SizedBox(height: 20),
                  const CustomText(text: 'Confirm Password'),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hinttext: 'Confirm password',
                    controller: confirmPassword,
                    obscureText: true,
                    validator: (val) {
                      if (val == '') {
                        return 'field is required';
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Register',
                    image: 'images/th (1).jpeg',
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        if (password.text != confirmPassword.text) {
                          showErrorDialog('Error', 'Passwords do not match.');
                          return;
                        }

                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                          Navigator.of(context).pushReplacementNamed('login');
                        } on FirebaseAuthException catch (e) {
                          Navigator.of(context)
                              .pop(); // Close the loading dialog
                          if (e.code == 'weak-password') {
                            showErrorDialog(
                                'Error', 'The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            showErrorDialog('Error',
                                'The account already exists for that email.',
                                navigateToLogin: true);
                          } else {
                            showErrorDialog('Error',
                                e.message ?? 'An unknown error occurred.');
                          }
                        } catch (e) {
                          showErrorDialog(
                              'Error', 'An unexpected error occurred.');
                        }
                      } else {
                        print('Not Valid');
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomTextrich(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    richText: 'Already have an account?',
                    spanText: 'Login',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
