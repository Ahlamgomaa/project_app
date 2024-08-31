import 'package:cloud_firestore/cloud_firestore.dart';
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
  AddCategory() async {
    try {
      DocumentReference response = await categories.add({'name': name.text});
      Navigator.of(context).pushReplacementNamed('home');
    } catch (e) {
      print('Error $e ');
    }
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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: CustomTextFormField(
                hinttext: 'Enter Nmae',
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
