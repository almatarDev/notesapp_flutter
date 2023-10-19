import 'package:flutter/material.dart';
import 'package:testing/component/crud.dart';
import 'package:testing/constants/linkesapi.dart';

import '../component/componentform.dart';

class EditNote extends StatefulWidget {
  final note;
  const EditNote({super.key, this.note});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> with Curd {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isloading = false;

  editNote() async {
    if (formKey.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response = await postRequest(linkEditNotes, {
        'title': titleController.text,
        'content': contentController.text,
        'id': widget.note['note_id'].toString(),
      });
      isloading = false;
      setState(() {});
      if (response['status'] == ['success']) {
        Navigator.pushReplacementNamed(context, "home");
      } else {}
    }
  }

  @override
  void initState() {
    titleController = widget.note['note_title'];
    contentController = widget.note['note_content'];
    super.initState();
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
                          label: 'title',
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
                          label: 'content',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () async {
                              await editNote();
                            },
                            child: const Text('Save'),
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
