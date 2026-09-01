import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReusableFloatingActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData?icon;
  final FaIconData? faIcon;
  final List<Color> colors;
  final double iconSize;

  const ReusableFloatingActionButton(
      {super.key,
      required this.onTap,
      this.icon,
        this.faIcon,
      this.iconSize = 25,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: faIcon!=null? FaIcon(faIcon,
          size: iconSize,
          color: Colors.white,
        ): Icon(
          icon,
          size: iconSize,
          color: Colors.white,
        ),
      ),
    );
  }
}
