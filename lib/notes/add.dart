import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:flutter/material.dart';
import 'package:project/notes/view.dart';

import 'package:project/widgets/custom_text_form_field.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, required this.docId});
  final String docId;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController note = TextEditingController();

  bool isLoading = false;
  addNote() async {
    CollectionReference notes = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.docId)
        .collection('note');
    try {
      isLoading = true;
      setState(() {});
      DocumentReference response = await notes.add(
        {
          'note': note.text,
        },
      );
      isLoading = false;
      // setState(() {});
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return NotesView(
              categoryId: widget.docId,
            );
          },
        ),
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
    note.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Note',
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
                      hinttext: 'Enter your Note',
                      controller: note,
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
                      addNote();
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
      ),
    );
  }
}
