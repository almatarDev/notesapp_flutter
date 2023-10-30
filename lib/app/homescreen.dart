import 'package:flutter/material.dart';
import 'package:testing/component/cardnote.dart';
import 'package:testing/component/models/notemodel.dart';
import 'package:testing/constants/linkesapi.dart';
import 'package:testing/main.dart';
import 'package:testing/notes/editnote.dart';

import '../component/crud.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Curd {
  var titileController = TextEditingController();
  var contentController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  var scaffoldstate = GlobalKey<ScaffoldState>();
  bool isShownBottomSheet = false;
  IconData bsIcon = Icons.edit;
  getNotes() async {
    var response = await postRequest(linkViewNotes, {
      'id': sharedPref.getString('id'),
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldstate,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              sharedPref.clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnote");
        },
        child: Icon(
          bsIcon,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == 'fail') {
                    return const Center(child: Text('not found '));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CardNote(
                        onDelete: () async {
                          var response = await postRequest(linkDeleteNotes, {
                            'id': snapshot.data!['data'][index]['note_id']
                                .toString(),
                          });
                          if (response['status'] == ['success']) {
                            Navigator.of(context).pushReplacementNamed("home");
                          }
                        },
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditNote(
                                  note: snapshot.data!['data'][index],
                                ),
                              ));
                        },
                        noteModel:
                            NoteModel.fromJson(snapshot.data['data'][index]),
                        // title: '${snapshot.data!['data'][index]['note_title']}',
                        // content:
                        //     '${snapshot.data!['data'][index]['note_content']}',
                        // image: '${snapshot.data!['data'][index]['note_image']}',
                      );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Center(
                      child: LinearProgressIndicator(),
                    ),
                  );
                }
                return const Center(
                  child: Text('loading.....'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
