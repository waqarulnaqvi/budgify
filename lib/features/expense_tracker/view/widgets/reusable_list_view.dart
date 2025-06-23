import 'package:budgify/core/constants/static_assets.dart';
import 'package:budgify/core/theme/app_gradients.dart';
import 'package:budgify/features/expense_tracker/viewmodel/riverpod/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/routes/paths.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../shared/view/widgets/global_widgets.dart';
import '../../model/tracker_model.dart';
import '../../utils/expense_type.dart';
import '../../utils/filter_type.dart';
import '../../viewmodel/riverpod/expense_tracker_notifier.dart';
import 'dialog/reusable_dialog_class.dart';

class ReusableListView extends ConsumerWidget {
  final List<FilteredExpModel> filteredExpModel;
  final String currency;
  final bool isScrollable;

  const ReusableListView(
      {super.key,
      required this.filteredExpModel,
      required this.currency,
      required this.isScrollable});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).colorScheme;
    var iShowDate =
        ref.watch(filterProvider) == FilterType.categoryWise.stringValue;

    return ListView.builder(
      shrinkWrap: !isScrollable,
      physics: isScrollable
          ? AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      // reverse: true,
      padding: const EdgeInsets.only(bottom: 100),
      itemBuilder: (context, index) {
        Color color = theme.onSurface;
        var balance = filteredExpModel[index].bal;
        if (balance < 0) {
          color = Colors.red;
        } else if (balance > 0) {
          color = Colors.green;
        }

        return Container(
          margin: EdgeInsets.only(top: 20, bottom: 10),
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
              color: theme.onSecondary,
              border: Border.all(
                color: theme.primary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Row(
                children: [
                  spacerW(10),
                  staticImage(
                      assetName: filteredExpModel[index].image ??
                          StaticAssets.calenderIcon,
                      color: filteredExpModel[index].title ==
                              Constants.mCat[15]["catName"]
                          ? theme.onSurface
                          : null,
                      width: 25,
                      height: 25),
                  spacerW(10),
                  Text(
                    '${filteredExpModel[index].title}',
                    style: AppStyles.headingPrimary(
                      context: context,
                      fontSize: 17,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (balance != 0)
                        Icon(
                          balance > 0 ? Icons.add : Icons.remove,
                          color: color,
                          size: 20,
                        ),
                      spacerW(2),
                      Flexible(
                          child: InkWell(
                        // onTap: showCurrencyPickerDialog,
                        child: Text(
                          "$currency${balance.abs()}",
                          style: AppStyles.headingPrimary(
                              context: context, fontSize: 17, color: color),
                        ),
                      )),
                    ],
                  ),
                  spacerW(10),
                ],
              ),
              spacerH(5),
              Divider(
                color: theme.primary,
              ),
              spacerH(5),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // reverse: true,
                itemBuilder: (context, i) {
                  final TrackerModel tl = filteredExpModel[index].allExp[i];
                  IconData icon = Icons.arrow_circle_up_outlined;
                  List<Color> colors = AppGradients.greenGradient;
                  double totalReturns = 0;
                  double currentAmount = 0;
                  double totalTax = 0;
                  double netAmountAfterTax = 0;

                  bool isTax = tl.trackerCategory == ExpenseType.tax.intValue;
                  // bool isExpense =
                  //     tl.trackerCategory == ExpenseType.expense.intValue;
                  bool isIncome =
                      tl.trackerCategory == ExpenseType.income.intValue;
                  bool isInvestment =
                      tl.trackerCategory == ExpenseType.investment.intValue;

                  if (isInvestment) {
                    totalReturns = tl.amount! * (tl.percentage / 100);
                    currentAmount = tl.amount! + totalReturns;
                  }

                  else if (isTax) {
                    totalTax = tl.amount! * (tl.percentage / 100);
                    netAmountAfterTax = tl.amount! - totalTax;
                  }

                  switch (tl.trackerCategory) {
                    case 0:
                      icon = Icons.arrow_circle_up_outlined;
                      colors = AppGradients.greenGradient;
                      break;
                    case 1:
                      icon = Icons.arrow_circle_down_outlined;
                      colors = AppGradients.youtubeGradient;
                      break;
                    case 3:
                      icon = Icons.receipt_long;
                      colors = AppGradients.youtubeGradient;

                      break;
                    case 2:
                      icon = FontAwesomeIcons.sackDollar;
                      colors = AppGradients.skyBlueGradient;

                      break;
                  }

                  Color detailsColors = isTax
                      ? (tl.percentage > 0 ? Colors.red : theme.onSurface)
                      : (tl.percentage > 0
                          ? Colors.green
                          : (tl.percentage < 0 ? Colors.red : theme.onSurface));

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      (isTax || isInvestment)
                          ? Container(
                              width: w,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // spacerW(),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text("Type: ",
                                                    style: AppStyles
                                                        .descriptionPrimary(
                                                            context: context,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14)),
                                                Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            colors: colors,
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight),
                                                        shape: BoxShape.circle),
                                                    child: Icon(
                                                      icon,
                                                      color: Colors.white,
                                                      size: 15,
                                                    )),
                                                spacerW(3),
                                                Flexible(
                                                  child: Text(
                                                    isInvestment
                                                        ? "Investment"
                                                        : "Tax",
                                                    style: AppStyles
                                                        .descriptionPrimary(
                                                            fontSize: 15,
                                                            context: context),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            spacerH(2),
                                            if (!iShowDate) ...[
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("Category:",
                                                      style: AppStyles
                                                          .descriptionPrimary(
                                                              context: context,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14)),
                                                  spacerW(5),
                                                  CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                      Constants.mCat[
                                                              tl.chooseCategory]
                                                          ["catImage"],
                                                    ),
                                                    backgroundColor: theme
                                                        .primary
                                                        .withValues(alpha: 0.4),
                                                    radius: 10,
                                                  ),
                                                  spacerW(5),
                                                  Flexible(
                                                    child: Text(
                                                      Constants.mCat[
                                                              tl.chooseCategory]
                                                          ["catName"],
                                                      style: AppStyles
                                                          .descriptionPrimary(
                                                              fontSize: 15,
                                                              context: context),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              spacerH(2),
                                            ],
                                            if (tl.title.isNotEmpty ||
                                                tl.title != "") ...[
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("Title: ",
                                                      style: AppStyles
                                                          .descriptionPrimary(
                                                              context: context,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14)),
                                                  Flexible(
                                                    child: Text(
                                                      tl.title,
                                                      style: AppStyles
                                                          .descriptionPrimary(
                                                              fontSize: 15,
                                                              context: context),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              spacerH(2),
                                            ],
                                            transactionsDetails(
                                                title: isTax
                                                    ? "Before Tax:"
                                                    : "Invested Amt:",
                                                value:
                                                    "$currency${tl.amount!.toStringAsFixed(2)}",
                                                context: context,
                                                color: theme.onSurface),
                                            spacerH(2),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  isTax
                                                      ? "After Tax: "
                                                      : "Current Amt: ",
                                                  style: AppStyles
                                                      .descriptionPrimary(
                                                          context: context,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                ),
                                                Flexible(
                                                    child: Text(
                                                  isTax
                                                      ? "$currency${netAmountAfterTax.toStringAsFixed(2)}"
                                                      : "$currency${currentAmount.toStringAsFixed(2)}",
                                                  style:
                                                      AppStyles.headingPrimary(
                                                    context: context,
                                                    fontSize: 14,
                                                    color: isTax
                                                        ? colors[0]
                                                        : totalReturns >= 0
                                                            ? Colors.green
                                                            : Colors.red,
                                                  ),
                                                )),
                                              ],
                                            ),
                                            spacerH(2),
                                            transactionsDetails(
                                                title: (!isTax)
                                                    ? "Total Return:"
                                                    : "Total Tax:",
                                                value: isTax
                                                    ? "$currency${totalTax.toStringAsFixed(2)}"
                                                    : "$currency${totalReturns.toStringAsFixed(2)}",
                                                context: context,
                                                color: detailsColors),
                                            spacerH(2),
                                            transactionsDetails(
                                                title: !isTax
                                                    ? "Return %:"
                                                    : "Tax %:",
                                                value:
                                                    "${tl.percentage.toStringAsFixed(2)}%",
                                                context: context,
                                                color: detailsColors),
                                            spacerH(2),
                                          ],
                                        ),
                                      ),
                                      spacerW(),
                                      reusableTrailingContent(
                                          tl, theme, context, iShowDate),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : Container(
                              width: w,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // spacerW(),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text("Type: ",
                                                    style: AppStyles
                                                        .descriptionPrimary(
                                                            context: context,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14)),
                                                Icon(icon,
                                                    color: colors[0], size: 25),
                                                spacerW(3),
                                                Flexible(
                                                  child: Text(
                                                    isIncome
                                                        ? "Income"
                                                        : "Expense",
                                                    style: AppStyles
                                                        .descriptionPrimary(
                                                            fontSize: 15,
                                                            context: context),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            spacerH(2),
                                            if (!iShowDate) ...[
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("Category:",
                                                      style: AppStyles
                                                          .descriptionPrimary(
                                                              context: context,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14)),
                                                  spacerW(5),
                                                  CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                      Constants.mCat[
                                                              tl.chooseCategory]
                                                          ["catImage"],
                                                    ),
                                                    backgroundColor: theme
                                                        .primary
                                                        .withValues(alpha: 0.4),
                                                    radius: 10,
                                                  ),
                                                  spacerW(5),
                                                  Flexible(
                                                    child: Text(
                                                      Constants.mCat[
                                                              tl.chooseCategory]
                                                          ["catName"],
                                                      style: AppStyles
                                                          .descriptionPrimary(
                                                              fontSize: 15,
                                                              context: context),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              spacerH(2),
                                            ],
                                            if (tl.title.isNotEmpty ||
                                                tl.title != "") ...[
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("Title: ",
                                                      style: AppStyles
                                                          .descriptionPrimary(
                                                              context: context,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14)),
                                                  Flexible(
                                                    child: Text(
                                                      tl.title,
                                                      style: AppStyles
                                                          .descriptionPrimary(
                                                              fontSize: 15,
                                                              context: context),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            spacerH(2),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Amt: ",
                                                  style: AppStyles
                                                      .descriptionPrimary(
                                                          context: context,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      (tl.trackerCategory ==
                                                                  ExpenseType
                                                                      .tax
                                                                      .intValue ||
                                                              tl.trackerCategory ==
                                                                  ExpenseType
                                                                      .expense
                                                                      .intValue)
                                                          ? Icons.remove
                                                          : Icons.add,
                                                      color: colors[0],
                                                      size: 15,
                                                    ),
                                                    spacerW(2),
                                                    Flexible(
                                                        child: Text(
                                                      "$currency${tl.amount}",
                                                      style: AppStyles
                                                          .headingPrimary(
                                                        context: context,
                                                        fontSize: 14,
                                                        color: colors[0],
                                                      ),
                                                    )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            spacerH(2),
                                          ],
                                        ),
                                      ),
                                      spacerW(),
                                      reusableTrailingContent(
                                          tl, theme, context, iShowDate),
                                    ],
                                  )
                                ],
                              ),
                            ),
                      if (i < filteredExpModel[index].allExp.length - 1)
                        Divider(color: theme.primary)
                    ],
                  );
                },

                itemCount: filteredExpModel[index].allExp.length,
              ),
            ],
          ),
        );
      },
      itemCount: filteredExpModel.length,
    );
  }

  Widget transactionsDetails({
    required String title,
    required String value,
    required BuildContext context,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.descriptionPrimary(
              context: context, fontWeight: FontWeight.w600, fontSize: 14),
        ),
        spacerW(5),
        Flexible(
          child: Text(
            value,
            style: AppStyles.descriptionPrimary(
                context: context, color: color, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget reusableTrailingContent(
      var tl, final theme, final context, final bool isShowDate) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isShowDate) ...[
          Text(tl.date,
              style:
                  AppStyles.descriptionPrimary(context: context, fontSize: 13)),
          spacerH(5),
        ],
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Paths.expenseManagementPage,
                    arguments: tl);
              },
              child: Icon(
                Icons.edit,
                color: theme.primary,
                size: 25,
              ),
            ),
            spacerW(10),
            Consumer(
              builder: (context, ref, child) => InkWell(
                onTap: () async {
                  await ReusableDialogClass.deletedEntryDialog(
                      context: context,
                      onClick: () {
                        ref
                            .read(expenseTrackerProviderOriginal.notifier)
                            .deleteData(tl!.id);
                        Navigator.of(context).pop();
                      });
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 25,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

// class ReusableListView extends StatelessWidget {
//   final List<TrackerModel> trackerList;
//   final String currency;
//   final bool isScrollable;
//
//   const ReusableListView(
//       {super.key,
//       required this.trackerList,
//       required this.currency,
//       required this.isScrollable});
//
//   @override
//   Widget build(BuildContext context) {
//     final double w = MediaQuery.of(context).size.width;
//     final theme = Theme.of(context).colorScheme;
//
//     return ListView.builder(
//       shrinkWrap: !isScrollable,
//       physics: isScrollable
//           ? AlwaysScrollableScrollPhysics()
//           : const NeverScrollableScrollPhysics(),
//       // reverse: true,
//       padding: const EdgeInsets.only(bottom: 100),
//       itemBuilder: (context, index) {
//         final TrackerModel tl = trackerList[index];
//         IconData icon = Icons.arrow_circle_up_outlined;
//         List<Color> colors = AppGradients.greenGradient;
//         double totalReturns = 0;
//         double currentAmount = 0;
//         double totalTax = 0;
//         double netAmountAfterTax = 0;
//
//         bool isTax = tl.trackerCategory == ExpenseType.tax.intValue;
//         bool isInvestment =
//             tl.trackerCategory == ExpenseType.investment.intValue;
//
//         if (isInvestment) {
//           totalReturns = tl.amount! * (tl.percentage / 100);
//           currentAmount = tl.amount! + totalReturns;
//         } else if (isTax) {
//           totalTax = tl.amount! * (tl.percentage / 100);
//           netAmountAfterTax = tl.amount! - totalTax;
//         }
//
//         switch (tl.trackerCategory) {
//           case 0:
//             icon = Icons.arrow_circle_up_outlined;
//             colors = AppGradients.greenGradient;
//             break;
//           case 1:
//             icon = Icons.arrow_circle_down_outlined;
//             colors = AppGradients.youtubeGradient;
//             break;
//           case 3:
//             icon = Icons.receipt_long;
//             colors = AppGradients.youtubeGradient;
//
//             break;
//           case 2:
//             icon = FontAwesomeIcons.sackDollar;
//             colors = AppGradients.skyBlueGradient;
//
//             break;
//         }
//
//         Color detailsColors = isTax
//             ? (tl.percentage > 0 ? Colors.red : theme.onSurface)
//             : (tl.percentage > 0
//                 ? Colors.green
//                 : (tl.percentage < 0 ? Colors.red : theme.onSurface));
//
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             (isTax || isInvestment)
//                 ? Container(
//                     width: w,
//                     margin: const EdgeInsets.only(bottom: 5),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                                 width: 42,
//                                 height: 42,
//                                 decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                         colors: colors,
//                                         begin: Alignment.topLeft,
//                                         end: Alignment.bottomRight),
//                                     shape: BoxShape.circle),
//                                 child: Icon(icon, color: Colors.white)),
//                             spacerW(),
//                             SizedBox(
//                               width: w * 0.5,
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   if(tl.title.isNotEmpty ||tl.title !="")
//                                   Text(
//                                     tl.title,
//                                     style: AppStyles.headingPrimary(
//                                         context: context, fontSize: 17),
//                                   ),
//                                   if(tl.title.isNotEmpty ||tl.title !="")
//                                   spacerH(2),
//                                   transactionsDetails(
//                                       title: isTax
//                                           ? "Before Tax:"
//                                           : "Invested Amt:",
//                                       value:
//                                           "$currency${tl.amount!.toStringAsFixed(2)}",
//                                       context: context,
//                                       color: theme.onSurface),
//                                   spacerH(2),
//                                   transactionsDetails(
//                                       title:
//                                           isTax ? "After Tax:" : "Current Amt:",
//                                       value: isTax
//                                           ? "$currency${netAmountAfterTax.toStringAsFixed(2)}"
//                                           : "$currency${currentAmount.toStringAsFixed(2)}",
//                                       context: context,
//                                       color: detailsColors),
//                                   spacerH(2),
//                                   transactionsDetails(
//                                       title: (!isTax)
//                                           ? "Total Return:"
//                                           : "Total Tax:",
//                                       value: isTax
//                                           ? "$currency${totalTax.toStringAsFixed(2)}"
//                                           : "$currency${totalReturns.toStringAsFixed(2)}",
//                                       context: context,
//                                       color: detailsColors),
//                                   spacerH(2),
//                                   transactionsDetails(
//                                       title: !isTax ? "Return %:" : "Tax %:",
//                                       value: tl.percentage.toStringAsFixed(2),
//                                       context: context,
//                                       color: detailsColors),
//                                   spacerH(2),
//                                 ],
//                               ),
//                             ),
//                             Spacer(),
//                             reusableTrailingContent(tl, theme, context),
//                           ],
//                         )
//                       ],
//                     ),
//                   )
//                 : ListTile(
//                     contentPadding: EdgeInsets.zero,
//                     leading: Icon(icon, color: colors[0], size: 40),
//                     title: tl.title.isNotEmpty ||tl.title !="" ? Text(
//                       tl.title,
//                       style: AppStyles.headingPrimary(
//                           context: context, fontSize: 17),
//                     ) : Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 3),
//                           child: Icon(
//                             (tl.trackerCategory == ExpenseType.tax.intValue ||
//                                 tl.trackerCategory ==
//                                     ExpenseType.expense.intValue)
//                                 ? Icons.remove
//                                 : Icons.add,
//                             color: colors[0],
//                             size: 20,
//                           ),
//                         ),
//                         spacerW(2),
//                         Flexible(
//                             child: Text(
//                               "$currency${tl.amount}",
//                               style: AppStyles.headingPrimary(
//                                 context: context,
//                                 fontSize: 17,
//                                 color: colors[0],
//                               ),
//                             )),
//                       ],
//                     ),
//                     subtitle: tl.title.isEmpty ||tl.title =="" ? null : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                        Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                           CircleAvatar(
//                              backgroundImage: AssetImage(
//                                Constants.mCat[tl.chooseCategory]
//                                ["catImage"],
//                              ),
//                              backgroundColor:
//                              theme.primary.withValues(alpha: 0.4),
//                              radius: 10,
//                            ),
//                            spacerW(5),
//                            Text(
//                             Constants.mCat[tl.chooseCategory]["catName"],
//                              style: AppStyles.descriptionPrimary(
//                                  context: context),
//                              overflow: TextOverflow.ellipsis,
//                            ),
//                          ],
//                        ),
//                         spacerH(2),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(top: 3),
//                               child: Icon(
//                                 (tl.trackerCategory == ExpenseType.tax.intValue ||
//                                         tl.trackerCategory ==
//                                             ExpenseType.expense.intValue)
//                                     ? Icons.remove
//                                     : Icons.add,
//                                 color: colors[0],
//                                 size: 20,
//                               ),
//                             ),
//                             spacerW(2),
//                             Flexible(
//                                 child: Text(
//                               "$currency${tl.amount}",
//                               style: AppStyles.headingPrimary(
//                                 context: context,
//                                 fontSize: 17,
//                                 color: colors[0],
//                               ),
//                             )),
//                           ],
//                         ),
//                       ],
//                     ),
//                     trailing: reusableTrailingContent(
//                       tl,
//                       theme,
//                       context,
//                     ),
//                   ),
//             const Divider()
//           ],
//         );
//       },
//       itemCount: trackerList.length,
//     );
//   }
//
//   Widget transactionsDetails({
//     required String title,
//     required String value,
//     required BuildContext context,
//     required Color color,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: AppStyles.descriptionPrimary(
//               context: context, fontWeight: FontWeight.w600, fontSize: 14),
//         ),
//         spacerW(5),
//         Flexible(
//           child: Text(
//             value,
//             style: AppStyles.descriptionPrimary(
//                 context: context, color: color, fontSize: 14),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget reusableTrailingContent(var tl, final theme, final context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(tl.date,
//             style:
//                 AppStyles.descriptionPrimary(context: context, fontSize: 13)),
//         spacerH(5),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.pushNamed(context, Paths.expenseManagementPage,
//                     arguments: tl);
//               },
//               child: Icon(
//                 Icons.edit,
//                 color: theme.primary,
//                 size: 25,
//               ),
//             ),
//             spacerW(10),
//             Consumer(
//               builder: (context, ref, child) => InkWell(
//                 onTap: () async {
//                   await ReusableDialogClass.deletedEntryDialog(context: context, onClick:
//                       () {
//                     ref
//                         .read(expenseTrackerProviderOriginal.notifier)
//                         .deleteData(tl!.id);
//                     Navigator.of(context).pop();
//                   });
//                 },
//                 child: Icon(
//                   Icons.delete,
//                   color: Colors.red,
//                   size: 25,
//                 ),
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

//        final List<TrackerModel> tl = filteredExpModel[index].allExp;
//         IconData icon = Icons.arrow_circle_up_outlined;
//         List<Color> colors = AppGradients.greenGradient;
//         double totalReturns = 0;
//         double currentAmount = 0;
//         double totalTax = 0;
//         double netAmountAfterTax = 0;
//
//         // bool isTax = tl.trackerCategory == ExpenseType.tax.intValue;
//         // bool isInvestment =
//         //     tl.trackerCategory == ExpenseType.investment.intValue;
//         //
//         // if (isInvestment) {
//         //   totalReturns = tl.amount! * (tl.percentage / 100);
//         //   currentAmount = tl.amount! + totalReturns;
//         // } else if (isTax) {
//         //   totalTax = tl.amount! * (tl.percentage / 100);
//         //   netAmountAfterTax = tl.amount! - totalTax;
//         // }
//         //
//         // switch (tl.trackerCategory) {
//         //   case 0:
//         //     icon = Icons.arrow_circle_up_outlined;
//         //     colors = AppGradients.greenGradient;
//         //     break;
//         //   case 1:
//         //     icon = Icons.arrow_circle_down_outlined;
//         //     colors = AppGradients.youtubeGradient;
//         //     break;
//         //   case 3:
//         //     icon = Icons.receipt_long;
//         //     colors = AppGradients.youtubeGradient;
//         //
//         //     break;
//         //   case 2:
//         //     icon = FontAwesomeIcons.sackDollar;
//         //     colors = AppGradients.skyBlueGradient;
//         //
//         //     break;
//         // }
//         //
//         // Color detailsColors = isTax
//         //     ? (tl.percentage > 0 ? Colors.red : theme.onSurface)
//         //     : (tl.percentage > 0
//         //     ? Colors.green
//         //     : (tl.percentage < 0 ? Colors.red : theme.onSurface));
//
//
//
//         // return Column(
//         //   mainAxisSize: MainAxisSize.min,
//         //   children: [
//         //     (isTax || isInvestment)
//         //         ? Container(
//         //       width: w,
//         //       margin: const EdgeInsets.only(bottom: 5),
//         //       child: Column(
//         //         mainAxisSize: MainAxisSize.min,
//         //         crossAxisAlignment: CrossAxisAlignment.start,
//         //         children: [
//         //           Row(
//         //             children: [
//         //               Container(
//         //                   width: 42,
//         //                   height: 42,
//         //                   decoration: BoxDecoration(
//         //                       gradient: LinearGradient(
//         //                           colors: colors,
//         //                           begin: Alignment.topLeft,
//         //                           end: Alignment.bottomRight),
//         //                       shape: BoxShape.circle),
//         //                   child: Icon(icon, color: Colors.white)),
//         //               spacerW(),
//         //               SizedBox(
//         //                 width: w * 0.5,
//         //                 child: Column(
//         //                   mainAxisSize: MainAxisSize.min,
//         //                   crossAxisAlignment: CrossAxisAlignment.start,
//         //                   children: [
//         //                     if(tl.title.isNotEmpty ||tl.title !="")
//         //                       Text(
//         //                         tl.title,
//         //                         style: AppStyles.headingPrimary(
//         //                             context: context, fontSize: 17),
//         //                       ),
//         //                     if(tl.title.isNotEmpty ||tl.title !="")
//         //                       spacerH(2),
//         //                     transactionsDetails(
//         //                         title: isTax
//         //                             ? "Before Tax:"
//         //                             : "Invested Amt:",
//         //                         value:
//         //                         "$currency${tl.amount!.toStringAsFixed(2)}",
//         //                         context: context,
//         //                         color: theme.onSurface),
//         //                     spacerH(2),
//         //                     transactionsDetails(
//         //                         title:
//         //                         isTax ? "After Tax:" : "Current Amt:",
//         //                         value: isTax
//         //                             ? "$currency${netAmountAfterTax.toStringAsFixed(2)}"
//         //                             : "$currency${currentAmount.toStringAsFixed(2)}",
//         //                         context: context,
//         //                         color: detailsColors),
//         //                     spacerH(2),
//         //                     transactionsDetails(
//         //                         title: (!isTax)
//         //                             ? "Total Return:"
//         //                             : "Total Tax:",
//         //                         value: isTax
//         //                             ? "$currency${totalTax.toStringAsFixed(2)}"
//         //                             : "$currency${totalReturns.toStringAsFixed(2)}",
//         //                         context: context,
//         //                         color: detailsColors),
//         //                     spacerH(2),
//         //                     transactionsDetails(
//         //                         title: !isTax ? "Return %:" : "Tax %:",
//         //                         value: tl.percentage.toStringAsFixed(2),
//         //                         context: context,
//         //                         color: detailsColors),
//         //                     spacerH(2),
//         //                   ],
//         //                 ),
//         //               ),
//         //               Spacer(),
//         //               reusableTrailingContent(tl, theme, context),
//         //             ],
//         //           )
//         //         ],
//         //       ),
//         //     )
//         //         : ListTile(
//         //       contentPadding: EdgeInsets.zero,
//         //       leading: Icon(icon, color: colors[0], size: 40),
//         //       title: tl.title.isNotEmpty ||tl.title !="" ? Text(
//         //         tl.title,
//         //         style: AppStyles.headingPrimary(
//         //             context: context, fontSize: 17),
//         //       ) : Row(
//         //         crossAxisAlignment: CrossAxisAlignment.start,
//         //         mainAxisSize: MainAxisSize.min,
//         //         children: [
//         //           Padding(
//         //             padding: const EdgeInsets.only(top: 3),
//         //             child: Icon(
//         //               (tl.trackerCategory == ExpenseType.tax.intValue ||
//         //                   tl.trackerCategory ==
//         //                       ExpenseType.expense.intValue)
//         //                   ? Icons.remove
//         //                   : Icons.add,
//         //               color: colors[0],
//         //               size: 20,
//         //             ),
//         //           ),
//         //           spacerW(2),
//         //           Flexible(
//         //               child: Text(
//         //                 "$currency${tl.amount}",
//         //                 style: AppStyles.headingPrimary(
//         //                   context: context,
//         //                   fontSize: 17,
//         //                   color: colors[0],
//         //                 ),
//         //               )),
//         //         ],
//         //       ),
//         //       subtitle: tl.title.isEmpty ||tl.title =="" ? null : Column(
//         //         crossAxisAlignment: CrossAxisAlignment.start,
//         //         mainAxisSize: MainAxisSize.min,
//         //         children: [
//         //           Row(
//         //             crossAxisAlignment: CrossAxisAlignment.start,
//         //             children: [
//         //               CircleAvatar(
//         //                 backgroundImage: AssetImage(
//         //                   Constants.mCat[tl.chooseCategory]
//         //                   ["catImage"],
//         //                 ),
//         //                 backgroundColor:
//         //                 theme.primary.withValues(alpha: 0.4),
//         //                 radius: 10,
//         //               ),
//         //               spacerW(5),
//         //               Text(
//         //                 Constants.mCat[tl.chooseCategory]["catName"],
//         //                 style: AppStyles.descriptionPrimary(
//         //                     context: context),
//         //                 overflow: TextOverflow.ellipsis,
//         //               ),
//         //             ],
//         //           ),
//         //           spacerH(2),
//         //           Row(
//         //             crossAxisAlignment: CrossAxisAlignment.start,
//         //             mainAxisSize: MainAxisSize.min,
//         //             children: [
//         //               Padding(
//         //                 padding: const EdgeInsets.only(top: 3),
//         //                 child: Icon(
//         //                   (tl.trackerCategory == ExpenseType.tax.intValue ||
//         //                       tl.trackerCategory ==
//         //                           ExpenseType.expense.intValue)
//         //                       ? Icons.remove
//         //                       : Icons.add,
//         //                   color: colors[0],
//         //                   size: 20,
//         //                 ),
//         //               ),
//         //               spacerW(2),
//         //               Flexible(
//         //                   child: Text(
//         //                     "$currency${tl.amount}",
//         //                     style: AppStyles.headingPrimary(
//         //                       context: context,
//         //                       fontSize: 17,
//         //                       color: colors[0],
//         //                     ),
//         //                   )),
//         //             ],
//         //           ),
//         //         ],
//         //       ),
//         //       trailing: reusableTrailingContent(
//         //         tl,
//         //         theme,
//         //         context,
//         //       ),
//         //     ),
//         //     const Divider()
//         //   ],
//         // );
