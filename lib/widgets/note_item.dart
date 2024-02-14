// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/constants.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/views/edit_note_view.dart';
import 'package:note_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({super.key, required this.note});
  final NoteModel note;

  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _opacityTween = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EditNoteView(
            note: widget.note,
          );
        }));
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityTween.value,
            child: Container(
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 24,
                left: 14,
              ),
              decoration: BoxDecoration(
                color: Color(widget.note.color),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ListTile(
                    title: Text(
                      widget.note.title,
                      style: const TextStyle(color: Colors.black, fontSize: 26),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Text(
                        widget.note.subTitle.trim(),
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        _controller.forward();
                        _onDeletePressed();
                      },
                      icon: const Icon(
                        FontAwesomeIcons.trash,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Text(
                      widget.note.date,
                      style: TextStyle(
                        color: Colors.black.withOpacity(.4),
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onDeletePressed() async {
    // Perform any logic you need before or after the animation
    await Future.delayed(
        const Duration(milliseconds: 500)); // Delay to wait for animation
    widget.note.delete();
    await Hive.box<NoteModel>(kNotesBox)
        .delete(widget.note.key); // Adjust box name
    BlocProvider.of<NotesCubit>(context).fetchAllNotes();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
