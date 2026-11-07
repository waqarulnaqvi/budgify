import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../shared/view/widgets/global_widgets.dart';

class ReusableIconButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final FaIconData? faIconData;
  final String url;
  final double spacerWidth;
  final double socialMediaIconFontSize;
  final double socialIconSize;
  final List<Color> colors;

  const ReusableIconButton(
      {super.key,
        required this.title,
        this.icon,
        this.faIconData,
        required this.colors,
        required this.url,
        this.spacerWidth = 10,
        this.socialMediaIconFontSize = 16,
        this.socialIconSize = 25});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4), // changes position of shadow
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            openUrl(url: url, context: context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(icon!=null)
                Icon(
                  icon,
                  color: Colors.white,
                  size: socialIconSize,
                ),

                if(faIconData!=null)
                FaIcon(
                  faIconData,
                  color: Colors.white,
                  size: socialIconSize,
                ),
                SizedBox(
                  width: spacerWidth,
                ),
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
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