import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../features/expense_tracker/model/card_model.dart';
import '../global_widgets.dart';
import '../painter/folded_corner_painter.dart';

class ReusableFoldedCornerContainer extends StatelessWidget {
  final bool isTaxPage;
  final CardModel section1;
  final CardModel section2;
  final CardModel section3;
  final CardModel section4;

  const ReusableFoldedCornerContainer({
    super.key,
    required this.isTaxPage,
    required this.section1,
    required this.section2,
    required this.section3,
    required this.section4,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 16.0,
          height: 16.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade500,
            shape: BoxShape.circle,
            border: Border.all(color: theme.onSurface, width: 3.0),
          ),
        ),
        SizedBox(
          width: 8,
          child: Divider(
            thickness: 2, // Set the thickness of the line
            color: theme.onSurface, // Set the color of the line
          ),
        ),
        Expanded(
          child: CustomPaint(
            painter: FoldedCornerPainter(color: theme.primary),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      isTaxPage ? "Tax" : "Investment",
                      style: AppStyles.headingPrimary(
                        context: context,
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  spacerH(8),
                  ReusableFoldedContainerInfo(
                    isTaxPage: isTaxPage,
                    section: section1,
                  ),
                  spacerH(5),
                  ReusableFoldedContainerInfo(
                    isTaxPage: isTaxPage,
                    section: section2,
                  ),
                  spacerH(5),
                  ReusableFoldedContainerInfo(
                    isTaxPage: isTaxPage,
                    section: section3,
                  ),
                  spacerH(5),
                  ReusableFoldedContainerInfo(
                    isTaxPage: isTaxPage,
                    section: section4,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 35,
          child: Divider(
            thickness: 2, // Set the thickness of the line
            color: theme.onSurface, // Set the color of the line
          ),
        ),
      ],
    );
  }
}

class ReusableFoldedContainerInfo extends StatelessWidget {
  final bool isTaxPage;
  final CardModel section;

  const ReusableFoldedContainerInfo({
    super.key,
    required this.isTaxPage,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isTaxPage)
          Icon(
            Icons.receipt_long,
            color: Colors.white,
            size: isTaxPage ? 18 : 15,
          )
        else
          FaIcon(
            FontAwesomeIcons.sackDollar,
            color: Colors.white,
            size: isTaxPage ? 18 : 15,
          ),

        spacerW(5),
        Text(
          section.name,
          style: AppStyles.headingPrimary(
            context: context,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        spacerW(5),
        Text(
          section.value,
          style: AppStyles.descriptionPrimary(
            context: context,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
