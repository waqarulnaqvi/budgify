import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerModel {
  final String title;
  final IconData? icon;
  final FaIconData? faIcon;
  final VoidCallback onTap;

  DrawerModel(
      {required this.title, this.icon, required this.onTap,this.faIcon});
}
