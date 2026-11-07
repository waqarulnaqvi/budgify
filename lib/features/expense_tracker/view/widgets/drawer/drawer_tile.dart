import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/theme/app_styles.dart';

class DrawerTile extends StatefulWidget {
  final IconData? icon;
  final String title;
  final FaIconData? faIcon;
  final VoidCallback onTap;

  const DrawerTile(
      { this.icon,
      required this.title,
      required this.onTap,
        this.faIcon,
      super.key});

  @override
  State<DrawerTile> createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      color: isTap ? theme.primary.withValues(alpha: 0.4) : Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTapUp: (_) {
            setState(() {
              isTap = false;
            });
            widget.onTap();
          },
          onTapDown: (_) {
            setState(() {
              isTap = true;
            });
          },
          onTapCancel: () {
            setState(() {
              isTap = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                if(widget.icon!=null)
                Icon(
                  widget.icon,
                  color: isTap ? Colors.white : Colors.black,
                ),

                if(widget.faIcon != null)
                FaIcon(
                  widget.faIcon,
                  color: isTap ? Colors.white : Colors.black,
                ),

                const SizedBox(width: 15),
                Flexible(
                  child: FittedBox(
                    child: Text(widget.title,
                        style: AppStyles.descriptionPrimary(
                            context: context,
                            color: isTap ? Colors.white : Colors.black)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
