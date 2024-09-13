import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/notes/add.dart';
import 'package:project/notes/edit.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key, required this.categoryId});
  final String categoryId;

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  List<QueryDocumentSnapshot> data = [];
  bool isLoading = true;

  Future<void> getData() async {
    setState(() => isLoading = true); // Show loading indicator

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .collection('note')
        .get();

    setState(() {
      data = querySnapshot.docs;
      isLoading = false; // Hide loading indicator
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[100],
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddNote(docId: widget.categoryId);
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Note'),
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              await googleSignIn.disconnect();

              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('home', (route) => false);
          return Future.value(false);
        },
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 200,
                ),
                itemBuilder: (BuildContext context, int index) {
                  // Ensure the note data is casted properly
                  Map<String, dynamic> noteData =
                      data[index].data() as Map<String, dynamic>;

                  String note = noteData['note'] ?? 'No content';
                  String? url = noteData['url'] as String?;

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return EditNote(
                              docnoteId: data[index].id,
                              catergoryId: widget.categoryId,
                              value: note,
                            );
                          },
                        ),
                      );
                    },
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Delete !',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: const Text(
                              'Are you sure you want to delete ?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('categories')
                                      .doc(widget.categoryId)
                                      .collection('note')
                                      .doc(data[index].id)
                                      .delete();
                                  if (url != null && url != 'none') {
                                    await FirebaseStorage.instance
                                        .refFromURL(url)
                                        .delete();
                                  }

                                  // Refresh the list after deletion
                                  getData();
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              note,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 15),
                            if (url != null && url != 'none')
                              Image.network(
                                url,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
