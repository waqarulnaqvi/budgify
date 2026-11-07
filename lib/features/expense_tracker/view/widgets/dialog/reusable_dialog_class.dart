import 'package:budgify/features/expense_tracker/view/widgets/dialog/all_dialogs/exit_dialog.dart';
import 'package:budgify/features/expense_tracker/view/widgets/dialog/all_dialogs/social_media_dialog.dart';
import 'package:budgify/features/expense_tracker/view/widgets/dialog/common_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import '../../../../../shared/view/widgets/global_widgets.dart';
import 'all_dialogs/delete_dialog.dart';

class ReusableDialogClass {
  static Future<bool> showYesNoDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const CommonDialogWidget(child: ExitDialog()),
        ) ??
        false;
  }

  static Future<void> deletedEntryDialog({
    required BuildContext context,
    required VoidCallback onClick,
    String text = "transaction",
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => CommonDialogWidget(
            child: DeleteDialog(onClickYes: onClick, text: text),
          ),
    );
  }

  static Future<void> connectUsDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      // barrierColor: Colors.transparent, // Makes the background fully transparent
      builder: (context) => CommonDialogWidget(child: SocialMediaDialog()),
    );
  }

  static Future<void> setDateDialog(
    BuildContext context, {
    required DateTime selectedDate,
    required VoidCallback onApplyTap,
    required Function(DateTime value) onDateTimeChanged,
    required VoidCallback onTapToday,
  }) async {
    final theme = Theme.of(context).colorScheme;
    final double w=MediaQuery.of(context).size.width;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Select Date'),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close, color: Colors.black),
              ),
            ],
          ),
          content: Container(
            decoration: BoxDecoration(
              color: theme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 200,
            width: w,
            child: ScrollDatePicker(
              selectedDate: selectedDate,
              locale: const Locale('en', 'US'),
              onDateTimeChanged: onDateTimeChanged,
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    onTapToday();
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: theme.primary,
                      ),
                      child: const Center(
                        child: Text(
                          "Today",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                spacerW(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    onApplyTap();
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: theme.primary,
                      ),
                      child: const Center(
                        child: Text(
                          "Apply",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
