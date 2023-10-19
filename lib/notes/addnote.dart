import 'package:flutter/material.dart';

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

  addNote() async {
    if (formKey.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response = await postRequest(linkAddNotes, {
        'title': titleController.text,
        'content': contentController.text,
        'id': sharedPref.getString("id"),
      });
      isloading = false;
      setState(() {});
      if (response['status'] == ['success']) {
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
                        SizedBox(
                          height: 40,
                          width: double.infinity,
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
