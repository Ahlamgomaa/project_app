import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:project/widgets/custom_text_form_field.dart';

class UpdateCategory extends StatefulWidget {
  const UpdateCategory({super.key, required this.docId, required this.oldName});
  final String docId;
  final String oldName;

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController name = TextEditingController();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  bool isLoading = false;
  UpdateCategory() async {
    try {
      isLoading = true;
      setState(() {});
      await categories.doc(widget.docId).update({
        "name": name.text,
      });
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
  void initState() {
    super.initState();
    name.text = widget.oldName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Category',
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
                      UpdateCategory();
                    },
                    child: const Text('Edit'),
                  ),
                ],
              ),
      ),
    );
  }
}
