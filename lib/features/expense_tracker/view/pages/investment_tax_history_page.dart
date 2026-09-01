import 'package:budgify/shared/view/widgets/global_widgets.dart';
import 'package:budgify/shared/view/widgets/reusable_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/routes/paths.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../shared/view/widgets/currency_picker.dart';
import '../../../../shared/view/widgets/date_filter.dart';
import '../../model/tracker_model.dart';
import '../../utils/expense_type.dart';
import '../widgets/buttons/filter_button.dart';
import '../widgets/filters/investment_filter.dart';
import '../widgets/filters/tax_filter.dart';
import '../widgets/reusable_floating_action_button.dart';
import '../widgets/transaction_history/reusable_info.dart';

class InvestmentTaxHistoryPage extends StatelessWidget {
  final bool isTaxPage;

  const InvestmentTaxHistoryPage({super.key, this.isTaxPage = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReusableAppBar(
          text: isTaxPage ? "Tax History" : "Investment History",
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
                  Expanded(
                    flex: 3,
                    child: isTaxPage ? TaxFilter() : InvestmentFilter(),
                  ),
                  spacerW(10),
                  Expanded(child: FilterButton())
                ],
              ),
              spacerH(10),
              DateFilter(),
              spacerH(10),
              ReusableInfo(
                isTaxPage: isTaxPage,
                isScrollable: true,
              )
            ],
          ),
        ),
        floatingActionButton: isTaxPage
            ? ReusableFloatingActionButton(
                onTap: () {
                  Navigator.pushNamed(context, Paths.expenseManagementPage,
                      arguments: TrackerModel(
                          title: '',
                          chooseCategory: 0,
                          date: '',
                          amount: null,
                          trackerCategory: ExpenseType.tax.intValue,
                          percentage: 0));
                },
                icon: Icons.receipt_long,
                colors: AppGradients.youtubeGradient)
            : ReusableFloatingActionButton(
                onTap: () {
                  Navigator.pushNamed(context, Paths.expenseManagementPage,
                      arguments: TrackerModel(
                          title: '',
                          date: '',
                          amount: null,
                          chooseCategory: 0,
                          trackerCategory: ExpenseType.investment.intValue,
                          percentage: 0));
                },
                faIcon: FontAwesomeIcons.sackDollar,
                colors: AppGradients.skyBlueGradient));
  }
}
