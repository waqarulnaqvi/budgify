import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../features/expense_tracker/view/widgets/dialog/reusable_dialog_class.dart';
import '../../../../features/my_budget/view_model/riverpod/my_budget_notifier.dart';
import '../global_widgets.dart';
import '../painter/folded_corner_painter.dart';

class DualFoldedCornerContainer extends ConsumerWidget{
  final int id;
  final String title;
  final String description;
  final String date;
  final Color color;
  final VoidCallback? onTap;
  final bool specialHeight;
  final bool hideDecoration;
  final double? height;

  const DualFoldedCornerContainer({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.color,
    this.onTap,
    this.height,
    this.specialHeight = false,
    this.hideDecoration = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designColor= Theme.of(context).colorScheme.onSurface;
    return SizedBox(
      height: height,
      child: Row(
        children: [

          if(!hideDecoration)...[
            Container(
              width: 16.0,
              height: 16.0,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: designColor, width: 3.0),
              ),
            ),
            SizedBox(
              width: 8,
              child: Divider(
                thickness: 2, // Set the thickness of the line
                color: designColor, // Set the color of the line
              ),
            ),
          ],
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: CustomPaint(
                painter: FoldedCornerPainter(color: color),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 20,
                    bottom: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppStyles.headingPrimary(
                          context: context,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        maxLines: specialHeight? 2 : 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      spacerH(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              description,
                              style: AppStyles.descriptionPrimary(
                                context: context,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              maxLines: specialHeight? 3 : 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          spacerW(10),
                          InkWell(
                            onTap: () {
                              ReusableDialogClass.deletedEntryDialog(
                                context: context,
                                onClick: () {
                                  ref.read(myBudgetProvider.notifier).deleteData(id);
                                  // Call the delete function here
                                  // deleteData(id);
                                  Navigator.of(context).pop();
                                },
                                text: "entry",
                              );
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ],
                      ),

                      if(hideDecoration)
                        Spacer(),

                      spacerH(10),

                      if(hideDecoration)...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date: ${date.split('|')[0]}",
                              style: AppStyles.descriptionPrimary(
                                context: context,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            spacerH(5),

                            Text(
                              "Time: ${date.split('|')[1]}",
                              style: AppStyles.descriptionPrimary(
                                context: context,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),

                          ],
                        )

                      ]
                      else...[
                        Text(
                          date,
                          style: AppStyles.descriptionPrimary(
                            context: context,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ]


                    ],
                  ),
                ),
              ),
            ),
          ),
          if(!hideDecoration)
            SizedBox(
              width: 35,
              child: Divider(
                thickness: 2, // Set the thickness of the line
                color: designColor, // Set the color of the line
              ),
            ),
        ],
      ),
    );
  }
}
