import 'package:budgify/shared/view/widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../buttons/dialog_button.dart';
import '../buttons/outlined_dialog_button.dart';

class DeleteDialog extends StatelessWidget {
  final VoidCallback onClickYes;
  final String text;
  const DeleteDialog({super.key, required this.onClickYes,required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.redOrange.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.delete_forever_rounded,
            size: 38,
            color: Colors.red,
          ),
        ),

        spacerH(),

        Text(
          "Delete $text?",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),

        spacerH(10),

        Text(
          "Are you sure you want to delete $text?",
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
                borderColor: Colors.redAccent,
              ),
            ),
            spacerW(12),
            Expanded(
              child: DialogButton(
                label: "Yes",
                textColor: Colors.white,
                background: Colors.redAccent,
                onPressed: onClickYes,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
