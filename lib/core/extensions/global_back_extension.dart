import 'package:budgify/features/expense_tracker/view/widgets/dialog/reusable_dialog_class.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension BackHandlerExtension on Widget {
  Widget withGlobalBackHandler(BuildContext context) {
    /// ✅ Apply ONLY on Android & iOS
    final isMobilePlatform =
        defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;

    if (!isMobilePlatform) {
      return this;
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        final navigator = Navigator.of(context);

        /// ✅ Normal back
        if (navigator.canPop()) {
          navigator.pop();
        } else {
          ReusableDialogClass.showYesNoDialog(context);
        }
      },
      child: this,
    );
  }
}
