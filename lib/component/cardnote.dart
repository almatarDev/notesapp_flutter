import 'package:flutter/material.dart';

import 'models/notemodel.dart';

class CardNote extends StatelessWidget {
  final void Function() onTap;
  final NoteModel noteModel;
  final void Function() onDelete;
  const CardNote({
    Key? key,
    required this.noteModel,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                noteModel.noteImage,
                width: 100,
                height: 100,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text(
                  noteModel.noteTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  noteModel.noteContent,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                    onPressed: onDelete, icon: const Icon(Icons.delete)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
