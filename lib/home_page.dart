import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[100],
        onPressed: () {
          Navigator.of(context).pushNamed('AddCategory');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Project'),
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();

              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 200,
        ),
        children: [
          Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    'images/note.jpeg',
                    height: 130,
                  ),
                  const Text(
                    'Company',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
