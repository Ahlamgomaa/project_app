import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:project/widgets/custom_text_form_field.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController name = TextEditingController();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  bool isLoading = false;
  addCategory() async {
    try {
      isLoading = true;
      setState(() {});
      DocumentReference response = await categories.add(
        {
          'name': name.text,
          "id": FirebaseAuth.instance.currentUser!.uid,
        },
      );
      isLoading = false;
      // setState(() {});
      Navigator.of(context).pushNamedAndRemoveUntil(
        'home',
        (route) => false,
      );
    } catch (e) {
      isLoading = false;
      setState(() {});
      print('Error $e ');
    }
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Category',
        ),
      ),
      body: Form(
        key: key,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(
                      20,
                    ),
                    child: CustomTextFormField(
                      hinttext: 'Enter Name',
                      controller: name,
                      validator: (val) {
                        if (val == '') {
                          return 'field is required ';
                        }
                      },
                    ),
                  ),
                  MaterialButton(
                    height: 45,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      addCategory();
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
      ),
    );
  }
}
