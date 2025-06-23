import 'package:budgify/core/theme/app_colors.dart';
import 'package:budgify/features/expense_tracker/model/card_model.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/view/widgets/global_widgets.dart';
import '../../../viewmodel/riverpod/currency_provider.dart';
import '../reusable_card_details.dart';

class ReusableCardWidget extends ConsumerWidget {
  final IconData icon;
  final CardModel section1;
  final CardModel section2;
  final CardModel section3;
  final CardModel section4;
  final bool isTaxPage;

  const ReusableCardWidget({
    super.key,
    required this.icon,
    required this.section1,
    required this.section2,
    required this.section3,
    required this.section4,
    this.isTaxPage = true,
  });

  Color getSectionColor(double value) {
    return isTaxPage
        ? (value > 0 ? AppColors.youtubeRed : Colors.black)
        : (value > 0
            ? Colors.green
            : (value < 0 ?
             AppColors.youtubeRed:
             Colors.black));
  }

  double getSectionValue(String value) {
    return double.tryParse(value) ?? 0.0;
  }

  bool isShowCondition(double value) {
    return isTaxPage ? false : (value < 0 || value > 0);
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showCurrencyPickerDialog() {
      showCurrencyPicker(
        context: context,
        showFlag: true,
        showCurrencyName: true,
        showCurrencyCode: true,
        onSelect: (Currency currency) async {

          await ref.read(currencyProvider.notifier).currencyFilter(
                name: currency.name,
                code: currency.code,
                symbol: currency.symbol,
              );


          // ref.read(currencyProvider.notifier).state =
          //     CurrencyModel.fromJson(currency);
        },
      );
    }

    final currency = ref.watch(currencyProvider).value?.symbol ?? '₹';
    final double w = MediaQuery.of(context).size.width;
    final double section1Value = getSectionValue(section1.value);
    final double section2Value = getSectionValue(section2.value);
    final double section3Value = getSectionValue(section3.value);
    final double section4Value = getSectionValue(section4.value);
    final Color section1Color =
        section1Value > 0
            ? Colors.green
            : (section1Value < 0 ? Colors.red : Colors.black);

    // final Color section2Color = getSectionColor(getSectionValue(section2.value));
    final Color section3Color =
        getSectionColor(section3Value);
    final Color section4Color =
        getSectionColor(section3Value);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: w,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            // gradient: LinearGradient(
            //     colors: AppGradients.greenGradient,
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ReusableCardDetails(
                    color: section1Color,
                    text: section1.name,
                    icon: icon,
                    amount: "$currency${section1Value.toStringAsFixed(2)}",
                    isShow: false,
                    // isExpense: section3Value < 0,
                    iconSize: 18,
                    onTap: showCurrencyPickerDialog,
                  ),
                ),
                spacerW(),
                Expanded(
                  child: ReusableCardDetails(
                    text: section2.name,
                    color: Colors.black,
                    icon: icon,
                    amount: "$currency${section2Value.abs()}",
                    isShow: false,
                    iconSize: 18,
                    onTap: showCurrencyPickerDialog,
                  ),
                ),
              ],
            ),
            spacerH(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ReusableCardDetails(
                    text: section3.name,
                    color: section3Color,
                    icon: icon,
                    amount: "$currency${section3Value.abs()}",
                    isShow: isShowCondition(section3Value),
                    isExpense: section3Value < 0,
                    iconSize: 18,
                    onTap: showCurrencyPickerDialog,
                  ),
                ),
                spacerW(),
                Expanded(
                  child: ReusableCardDetails(
                    text: section4.name,
                    color: section4Color,
                    icon: icon,
                    amount: "${section4Value.abs()}%",
                    isShow: isShowCondition(section4Value),
                    isExpense: section3Value < 0,
                    iconSize: 18,
                    onTap: showCurrencyPickerDialog,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// text: 'Current Amount',
// text: isTaxPage ? "Tax Amount" : "Original Amount",
// text: isTaxPage ? "Total Tax" : "Total Returns",

// text: isTaxPage ? "Total Tax %" :"Returns %",

//isTaxPage
//                         ? Icons.receipt_long
//                         : FontAwesomeIcons.sackDollar,

// Text(
// "Current Amount",
// style: AppStyles.descriptionPrimary(
// context: context, color: Colors.white),
// ),
// spacerH(5),
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisSize: MainAxisSize.min,
// children: [
// Padding(
// padding: const EdgeInsets.only(top: 12),
// child: Icon(
// Icons.add,
// color: Colors.white,
// size: 20,
// ),
// ),
// spacerW(2),
// Flexible(
// child: Text(
// "$currency 0.0",
// style: AppStyles.headingPrimary(
// context: context, fontSize: 30, color: Colors.white),
// )),
// ],
// ),

//            spacerH(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: ReusableCardDetails(
//                     color: Colors.white,
//                     text: "Tax Amount",
//                     icon: Icons.receipt_long,
//                     amount: "00",
//                     isShow: true,
//                     isExpense: true,
//                     onTap: () {},
//                   ),
//                 ),
//                 spacerW(),
//                 Expanded(
//                   child: ReusableCardDetails(
//                     color: Colors.white,
//                     text: "Total Tax %",
//                     icon: Icons.receipt_long,
//                     amount: "00",
//                     isShow: true,
//                     isExpense: true,
//                     onTap: () {},
//                   ),
//                 ),
//               ],
//             ),
