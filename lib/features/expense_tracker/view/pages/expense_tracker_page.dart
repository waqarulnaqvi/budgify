part of 'expense_tracker_home_page.dart';

class ExpenseTrackerPage extends ConsumerStatefulWidget {
  const ExpenseTrackerPage({super.key});

  @override
  ConsumerState<ExpenseTrackerPage> createState() => _ExpenseTrackerPageState();
}

class _ExpenseTrackerPageState extends ConsumerState<ExpenseTrackerPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(expenseTrackerProviderOriginal.notifier).init();
    });
        //   Future.microtask(() {
    //     ref.read(expenseTrackerProvider.notifier).init();
    //   });
  }

  double getDoubleValue(String value) {
    return double.tryParse(value) ?? 0.0;
  }

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

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final currency = ref.watch(currencyProvider).value?.symbol ?? '₹';
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spacerH(),
                Row(
                  children: [
                    Expanded(flex: 3, child: TransactionFilter(),),
                    spacerW(10),
                    Expanded(child: FilterButton())
                  ],
                ),
                spacerH(10),
                // CurrencyPicker(),
                // spacerH(10),
                cardSection(w, context, currency,theme),
                spacerH(10),
                DateFilter(),
                spacerH(),
                transactionSection(),
                spacerH(10),
                TransactionInfo(),
              ],
            ),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                          amount: null,
                          chooseCategory: -1,
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
                          chooseCategory: 14,
                          trackerCategory: ExpenseType.income.intValue,
                          percentage: 0));
                },
                icon: Icons.arrow_circle_up_outlined,
                colors: AppGradients.greenGradient),
          ],
        ));
  }

  Widget cardSection(
      final double w, final BuildContext context, final currency,final ColorScheme theme) {
    final transactionInfo =
        ref.watch(filteredTransactionProvider).transactionModel;
    double totalBalance = getDoubleValue(transactionInfo.totalBalance),
        totalIncome = getDoubleValue(transactionInfo.income),
        totalExpense = getDoubleValue(transactionInfo.expense);

    final zeroBalance = totalIncome == 0 && totalExpense == 0;
    final zeroIncome = totalIncome == 0;
    final zeroExpense = totalExpense == 0;
    final positiveBalance = totalBalance >= 0;
    final totalBalanceColor = zeroBalance
        ? Colors.black
        : positiveBalance
            ? Colors.green
            : AppColors.youtubeRed;
    final incomeColor = zeroIncome ? Colors.black : Colors.green;
    final expenseColor = zeroExpense ? Colors.black : AppColors.youtubeRed;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: w,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color:  AppColors.skyBlueLight,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Total Balance",
                        style: AppStyles.descriptionPrimary(
                            context: context, color: totalBalanceColor),
                      ),
                      spacerH(5),
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!zeroBalance)
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Icon(
                                  positiveBalance ? Icons.add : Icons.remove,
                                  color: totalBalanceColor,
                                  size: 20,
                                ),
                              ),
                            spacerW(2),
                            Flexible(
                                child: InkWell(
                              onTap: showCurrencyPickerDialog,
                              child: Text(
                                "$currency${totalBalance.abs()}",
                                style: AppStyles.headingPrimary(
                                    context: context,
                                    fontSize: 30,
                                    color: totalBalanceColor),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                spacerW(15),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(StaticAssets.budgetFlowHomeIcon),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.primary,
                      width: 1,
                    ),
                  ),
                ),
                spacerW(5),

              ],
            ),
            spacerH(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ReusableCardDetails(
                    color: incomeColor,
                    text: "Income",
                    icon: Icons.arrow_circle_up_outlined,
                    amount: "$currency$totalIncome",
                    isShow: !zeroIncome,
                    onTap: showCurrencyPickerDialog,
                  ),
                ),
                spacerW(),
                Expanded(
                  child: ReusableCardDetails(
                    color: expenseColor,
                    text: "Expense",
                    icon: Icons.arrow_circle_down_outlined,
                    amount: "$currency${totalExpense.abs()}",
                    isShow: !zeroExpense,
                    isExpense: true,
                    onTap: showCurrencyPickerDialog,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget transactionSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            "Recent Transactions",
            style: AppStyles.headingPrimary(context: context, fontSize: 19),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        spacerW(),
        ReusableOutlinedButton(onPressed: () {
          Navigator.pushNamed(context, Paths.allTransactionPage);
        })
      ],
    );
  }
}
