import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:testing/component/componentform.dart';
import 'package:testing/component/crud.dart';

import '../constants/linkesapi.dart';
import '../main.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> with Curd {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isloading = false;
  File? file;

  addNote() async {
    if (file == null) {
      return const SnackBar(content: Text('please pickup image'));
    }
    if (formKey.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response = await postRequestFile(
        linkAddNotes,
        {
          "title": titleController.text,
          "content": contentController.text,
          "id": sharedPref.getString("id"),
        },
        file!,
      );
      isloading = false;
      setState(() {});
      if (response['status'] == 'success') {
        Navigator.pushReplacementNamed(context, "home");
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isloading
          ? const LinearProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        defaultFormField(
                          controller: titleController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Title must be not empty';
                            }
                            return null;
                          },
                          label: 'Add title',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: contentController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Content must be not empty';
                            }
                            return null;
                          },
                          label: 'Add content',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.blue,
                          height: 50,
                          child: MaterialButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => SizedBox(
                                  height: 120,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          'Chose Image',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          XFile? xFile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);
                                          file = File(xFile!.path);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: const Text(
                                            'From Camera',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          XFile? xFile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                          file = File(xFile!.path);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: const Text(
                                            'From Gallery',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: const Text('Chose Image'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.blue,
                          height: 50,
                          child: MaterialButton(
                            onPressed: () async {
                              await addNote();
                            },
                            child: const Text('Add note'),
                          ),
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
