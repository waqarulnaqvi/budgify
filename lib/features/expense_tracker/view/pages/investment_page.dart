part of 'expense_tracker_home_page.dart';

class InvestmentPage extends ConsumerWidget {
  const InvestmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final investmentModel =
        ref.watch(filteredInvestmentProvider).investmentModel;
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                spacerH(),
                Row(
                  children: [
                    Expanded(
                        flex: 3,child: InvestmentFilter()),
                    spacerW(10),
                    Expanded(child: FilterButton())
                  ],
                ),
                spacerH(10),
                ReusableCardWidget(
                  isTaxPage: false,
                  faIcon: FontAwesomeIcons.sackDollar,
                  section1: CardModel(
                      name: "Current Amount",
                      value: investmentModel.currentAmount),
                  section2: CardModel(
                      name: "Invested Amount",
                      value: investmentModel.investedAmount),
                  section3: CardModel(
                      name: "Total Returns",
                      value: investmentModel.totalReturns),
                  section4: CardModel(
                      name: "Returns %",
                      value: investmentModel.returnsPercentage),
                ),
                spacerH(10),
                DateFilter(),
                spacerH(),
                investmentHistory(context),
                spacerH(10),
                ReusableInfo(
                  isTaxPage: false,
                  isScrollable: false,
                )
              ],
            ),
          ),
        ),
        floatingActionButton: ReusableFloatingActionButton(
            onTap: () {
              Navigator.pushNamed(context, Paths.expenseManagementPage,
                  arguments: TrackerModel(
                      chooseCategory: 15,
                      title: '',
                      date: '',
                      amount: null,
                      trackerCategory: ExpenseType.investment.intValue,
                      percentage: 0));
            },
            faIcon: FontAwesomeIcons.sackDollar,
            colors: AppGradients.skyBlueGradient));
  }

  Widget investmentHistory(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            "Investment History",
            style: AppStyles.headingPrimary(context: context, fontSize: 19),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        spacerW(),
        ReusableOutlinedButton(onPressed: () {
          Navigator.pushNamed(context, Paths.investmentTaxHistoryPage,
              arguments: false);
        })
      ],
    );
  }
}
