import 'package:flutter/material.dart';
import 'package:note_app/widgets/custom_icon.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      required this.viewBarIcon,
      required this.viewBarTitle,
      this.onPressed});
  final String viewBarTitle;
  final IconData viewBarIcon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          viewBarTitle,
          style: const TextStyle(
            fontSize: 28,
          ),
        ),
        const Spacer(),
        CustomIcon(
          onPressed: onPressed,
          icon: viewBarIcon,
        ),
      ],
    );
  }
}
