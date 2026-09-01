import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/theme/app_styles.dart';

class ReusableHeading extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? color;
  final double? fontSize;
  const ReusableHeading({super.key, required this.text, this.icon, this.color, this.fontSize});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,style: AppStyles.headingPrimary(context: context,color:color?? theme.onSurface,fontWeight: FontWeight.bold,fontSize: fontSize),),
        if(icon!=null)
        FaIcon(FontAwesomeIcons.music,color: color?? theme.surface)
        else  
        Icon(icon,color: color?? theme.onSurface,)
      ],
    );
  }
}