import 'package:flutter/material.dart';
import 'package:project/widgets/custom_button.dart';
import 'package:project/widgets/custom_text_form_field.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController name = TextEditingController();

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
              onPressed: () {},
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
