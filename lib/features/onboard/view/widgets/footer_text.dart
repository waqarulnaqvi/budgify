import 'package:budgify/shared/view/widgets/global_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

Widget footerText(BuildContext context) {
  final colorScheme=Theme.of(context).colorScheme;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 12.0),
    child: Text.rich(
      TextSpan(
        text: 'By continuing, you agree that you have read and accept our ',
        style: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.7) ,
          fontSize: 10,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'T&Cs',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
              await openUrl(url: Constants.budgetFlowPrivacyPolicy,isExternal: true, context: context);
              },
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style:  TextStyle(
              color: colorScheme.onSurface,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                await openUrl(url: Constants.budgetFlowPrivacyPolicy,isExternal: true, context: context);
              },
          ),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    ),
  );
}