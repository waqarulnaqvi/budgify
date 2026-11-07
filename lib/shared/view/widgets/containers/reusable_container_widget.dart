import 'package:flutter/material.dart';
import '../../../../core/theme/app_styles.dart';
import '../global_widgets.dart';

class ReusableContainerWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final IconData icon;

  const ReusableContainerWidget({super.key, this.onTap, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      height: 55,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: theme.surface,
        border: Border.all(
          width: 1,
          color: theme.onSurface,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            spacerW(10),
            Icon(
              icon,
              color: theme.onSurface,
              size: 20,
            ),
            spacerW(10),
            Text(
              text,
              style: AppStyles.descriptionPrimary(context: context),
            ),
            Spacer(),
            Icon(
              Icons.arrow_drop_down_rounded,
              color: theme.onSurface,
            )
          ],
        ),
      ),
    );
  }
}