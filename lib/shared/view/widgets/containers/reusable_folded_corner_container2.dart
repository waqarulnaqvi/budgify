// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../../../../core/theme/app_styles.dart';
// import '../../../../features/expense_tracker/model/card_model.dart';
// import '../../../../features/expense_tracker/view/widgets/dialog/reusable_dialog_class.dart';
// import '../../../../features/my_budget/view_model/riverpod/my_budget_notifier.dart';
// import '../global_widgets.dart';
// import '../painter/folded_corner_painter.dart';
//
// class ReusableFoldedCornerContainer2 extends ConsumerWidget {
//   final int id;
//   final String title;
//   final String description;
//   final String date;
//   final Color color;
//   final VoidCallback? onTap;
//
//   const ReusableFoldedCornerContainer2({
//     super.key,
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.date,
//     required this.color,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = Theme.of(context).colorScheme;
//
//     return Row(
//       children: [
//         Container(
//           width: 16.0,
//           height: 16.0,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: theme.onSurface,
//               width: 3.0,
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 8,
//           child: Divider(
//             thickness: 2, // Set the thickness of the line
//             color: theme.onSurface, // Set the color of the line
//           ),
//         ),
//         Expanded(
//           child: InkWell(
//             onTap: onTap,
//             child: CustomPaint(
//               painter: FoldedCornerPainter(color: color),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     left: 15, right: 15, top: 20, bottom: 15),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: AppStyles.headingPrimary(
//                             context: context,
//                             fontSize: 18,
//                             color: Colors.black),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//
//                       spacerH(5),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Flexible(
//                             child: Text(
//                               description,
//                               style: AppStyles.descriptionPrimary(
//                                   context: context,
//                                   fontSize: 14,
//                                   color: Colors.black),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           spacerW(10),
//                           InkWell(
//                             onTap: () {
//                               ReusableDialogClass.deletedEntryDialog(
//                                 context: context,
//                                 onClick: () {
//                                   ref.read(myBudgetProvider.notifier).deleteData(id);
//                                   // Call the delete function here
//                                   // deleteData(id);
//                                   Navigator.of(context).pop();
//                                 },
//                                 text: "entry",
//                               );
//                             },
//                             child: Icon(
//                               Icons.delete,
//                               color: Colors.black,
//                               size: 25,
//                             ),
//                           ),
//                         ],
//                       ),
//                       spacerH(10),
//                       Text(
//                         date,
//                         style: AppStyles.descriptionPrimary(
//                             context: context,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black),
//                       ),
//
//                     ]),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 35,
//           child: Divider(
//             thickness: 2, // Set the thickness of the line
//             color: theme.onSurface, // Set the color of the line
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class ReusableFoldedContainerInfo extends StatelessWidget {
//   final bool isTaxPage;
//   final CardModel section;
//
//   const ReusableFoldedContainerInfo(
//       {super.key, required this.isTaxPage, required this.section});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(
//           isTaxPage ? Icons.receipt_long : FontAwesomeIcons.sackDollar,
//           color: Colors.white,
//           size: isTaxPage ? 18 : 15,
//         ),
//         spacerW(5),
//         Text(
//           section.name,
//           style: AppStyles.headingPrimary(
//               context: context, fontSize: 15, color: Colors.white),
//         ),
//         spacerW(5),
//         Text(
//           section.value,
//           style: AppStyles.descriptionPrimary(
//               context: context, fontSize: 14, color: Colors.white),
//         ),
//       ],
//     );
//   }
// }
