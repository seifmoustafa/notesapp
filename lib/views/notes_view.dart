import 'package:flutter/material.dart';
import 'package:note_app/widgets/notes_view_body.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Color(0xff53EAD5),
        foregroundColor: Colors.black,
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
      body: const NotesViewBody(),
    );
  }
}
