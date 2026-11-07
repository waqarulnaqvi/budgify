import 'package:flutter/material.dart';
import '../../../core/theme/app_styles.dart';

class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isCenterText;
  final String text;
  final VoidCallback? onPressed;
  final bool isMenu;
  final PreferredSizeWidget? bottom;
  final VoidCallback? onPressedBackButton;

  const ReusableAppBar({
    super.key,
    this.isCenterText = true,
    required this.text,
    this.onPressed,
    this.isMenu = false, this.bottom,
    this.onPressedBackButton,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final Color foregroundColor = Colors.white;
    // final bool canPop = Navigator.canPop(context);
    //    final bool canPop = Navigator.of(context).canPop();
    // final Color foregroundColor = theme.surface;
    return AppBar(
      titleSpacing: 0, //This removes the unnecessary space between the title and back button if the appbar can be pop
      // leading: canPop
      //     ? IconButton(
      //   icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
      //   color: foregroundColor,
      //   onPressed: onPressedBackButton ?? () => Navigator.of(context).pop(),
      // )
      //     : null,
      backgroundColor: theme.primary,
      centerTitle: isCenterText,
      foregroundColor: foregroundColor,
      title: Text(
        text,
        style: AppStyles.headingPrimary(context: context,color: foregroundColor),
      ),
      actions: [
        if (isMenu)
          IconButton(
            icon: Icon(
              Icons.menu,
              color: foregroundColor,
            ),
            onPressed: onPressed,
          ),
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
