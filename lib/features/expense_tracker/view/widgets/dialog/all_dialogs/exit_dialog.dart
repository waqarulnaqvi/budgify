import 'package:budgify/shared/view/widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../buttons/dialog_button.dart';
import '../buttons/outlined_dialog_button.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.exit_to_app_rounded,
            size: 38,
            color: colorScheme.primary,
          ),
        ),

        spacerH(),

        Text(
          "Exit App?",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),

        spacerH(10),

        Text(
          "Are you sure you want to exit?",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: colorScheme.onSurface,fontWeight: FontWeight.w500),
        ),

        spacerH(28),

        Row(
          children: [
            Expanded(
              child: OutlinedDialogButton(
                label: "No",
                onPressed: () => Navigator.pop(context, false),
                borderColor: colorScheme.primary,
              ),
            ),
            spacerW(12),
            Expanded(
              child: DialogButton(
                label: "Yes",
                textColor: Colors.white,
                background: colorScheme.primary,
                onPressed: () => SystemNavigator.pop(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}