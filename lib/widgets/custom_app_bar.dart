import 'package:flutter/material.dart';
import 'package:note_app/widgets/custom_icon.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, required this.viewBarIcon, required this.viewBarTitle});
  final String viewBarTitle;
  final IconData viewBarIcon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          viewBarTitle,
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        Spacer(),
        CustomIcon(icon: viewBarIcon),
      ],
    );
  }
}
