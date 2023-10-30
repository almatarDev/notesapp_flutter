class NoteModel {
  late int noteId;
  late String noteTitle;
  late String noteContent;
  late String noteImage;
  late int noteUser;

  NoteModel({
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
    required this.noteImage,
    required this.noteUser,
  });

  NoteModel.fromJson(Map<String, dynamic> json) {
    noteId = json['note_id'];
    noteTitle = json['note_title'];
    noteContent = json['note_content'];
    noteImage = json['note_image'];
    noteUser = json['note_user'];
  }
}
