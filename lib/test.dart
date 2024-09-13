import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('============================');
    print(token);
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('notifications'),
      ),
      body: Container(),
    );
  }
}
