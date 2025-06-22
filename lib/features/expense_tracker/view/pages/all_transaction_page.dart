import 'package:budgify/features/expense_tracker/view/widgets/transaction_history/transaction_info.dart';
import 'package:budgify/shared/view/widgets/global_widgets.dart';
import 'package:budgify/shared/view/widgets/reusable_app_bar.dart';
import 'package:flutter/material.dart';
import '../../../../core/routes/paths.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../shared/view/widgets/currency_picker.dart';
import '../../../../shared/view/widgets/date_filter.dart';
import '../../model/tracker_model.dart';
import '../../utils/expense_type.dart';
import '../widgets/buttons/filter_button.dart';
import '../widgets/filters/transaction_filter.dart';
import '../widgets/reusable_floating_action_button.dart';

class AllTransactionPage extends StatelessWidget {
  const AllTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        text: "All Transactions",
        isCenterText: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            spacerH(),
            CurrencyPicker(),
            spacerH(10),
            Row(
              children: [
                Expanded(flex: 3, child: TransactionFilter(),),
                spacerW(10),
                Expanded(child: FilterButton())
              ],
            ),
            spacerH(10),
            DateFilter(),
            spacerH(10),
            TransactionInfo(isScrollable: true,),
          ],
        ),
      ),
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReusableFloatingActionButton(
                iconSize: 30,
                onTap: () {
                  Navigator.pushNamed(context, Paths.expenseManagementPage,
                      arguments: TrackerModel(
                          title: '',
                          date: '',
                          chooseCategory: 0,
                          amount: null,
                          trackerCategory: ExpenseType.expense.intValue,
                          percentage: 0));
                },
                icon: Icons.arrow_circle_down_outlined,
                colors: AppGradients.youtubeGradient),
            spacerW(10),
            ReusableFloatingActionButton(
                iconSize: 30,
                onTap: () {
                  Navigator.pushNamed(context, Paths.expenseManagementPage,
                      arguments: TrackerModel(
                          title: '',
                          date: '',
                          amount: null,
                          chooseCategory: 0,
                          trackerCategory: ExpenseType.income.intValue,
                          percentage: 0));
                },
                icon: Icons.arrow_circle_up_outlined,
                colors: AppGradients.greenGradient),
          ],
        )
    );
  }
}
