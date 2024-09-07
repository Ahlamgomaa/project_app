import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:project/notes/view.dart';

import 'package:project/widgets/custom_text_form_field.dart';

class EditNote extends StatefulWidget {
  const EditNote(
      {super.key,
      required this.docnoteId,
      required this.catergoryId,
      required this.value});
  final String docnoteId;
  final String catergoryId;
  final String value;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController note = TextEditingController();

  bool isLoading = false;
  editNote() async {
    CollectionReference notes = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.catergoryId)
        .collection('note');
    try {
      isLoading = true;
      setState(() {});
      await notes.doc(widget.docnoteId).update(
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
              categoryId: widget.catergoryId,
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
  void initState() {
    note.text = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Note',
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
                      hinttext: 'Edit your Note',
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
                      editNote();
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
      ),
    );
  }
}
