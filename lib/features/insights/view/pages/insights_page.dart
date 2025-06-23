import 'package:budgify/core/constants/static_assets.dart';
import 'package:budgify/shared/view/widgets/currency_picker.dart';
import 'package:budgify/shared/view/widgets/global_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:budgify/features/expense_tracker/viewmodel/riverpod/expense_tracker_notifier.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/prefs_keys.dart';
import '../../../../core/local/prefs_helper.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../shared/view/widgets/ads/banner_ads.dart';
import '../../../../shared/view/widgets/buttons/reusable_icon_button.dart';
import '../../../../shared/view/widgets/date_filter.dart';
import '../../../../shared/view/widgets/reusable_app_bar.dart';
import '../../../expense_tracker/view/widgets/more_apps_carousel.dart';
import '../../../expense_tracker/viewmodel/riverpod/currency_provider.dart';
import '../../data/chart_info.dart';
import '../../model/chart_model.dart';
import '../widgets/play_store_rating.dart';
import 'dart:math';

class InsightsPage extends ConsumerStatefulWidget {
  const InsightsPage({super.key});

  @override
  ConsumerState<InsightsPage> createState() => _InsightsPageState();
}

class _InsightsPageState extends ConsumerState<InsightsPage> {
  PrefsHelper? prefsHelper;
  bool isAlreadyRated = false;

  @override
  void initState() {
    super.initState();
    initPreference();
  }

  Future<void> initPreference() async {
    prefsHelper = PrefsHelper();
    isAlreadyRated = await prefsHelper!.getBoolValue(PrefsKeys.alreadyRated);
    setState(() {});
    // print("Already Rated: $isAlreadyRated");
  }

  @override
  Widget build(BuildContext context) {
    final expenseData = ref.watch(expenseTrackerProvider);
    var totalBalance = (expenseData.trackerCategory.totalIncome -
            expenseData.trackerCategory.totalExpense) -
        expenseData.trackerCategory.tax +
        expenseData.trackerCategory.investment;

    final totalIncome = expenseData.trackerCategory.totalIncome;

    totalBalance = totalBalance < 0 ? 0 : totalBalance;
    final totalInvestment = expenseData.trackerCategory.investment < 0
        ? expenseData.trackerCategory.investment * -1
        : expenseData.trackerCategory.investment;

    final totalExpense = expenseData.trackerCategory.totalExpense < 0
        ? expenseData.trackerCategory.totalExpense * -1
        : expenseData.trackerCategory.totalExpense;

    final totalTax = expenseData.trackerCategory.tax < 0
        ? expenseData.trackerCategory.tax * -1
        : expenseData.trackerCategory.tax;

    final currencySymbol = ref.watch(currencyProvider).value?.symbol ?? '₹';
    final theme = Theme.of(context).colorScheme;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const ReusableAppBar(text: 'Insights'),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  spacerH(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: CurrencyPicker(),
                  ),
                  spacerH(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: DateFilter(),
                  ),
                  spacerH(),
                  (expenseData.trackerCategory.investment != 0 ||
                          expenseData.trackerCategory.tax != 0 ||
                          expenseData.trackerCategory.totalIncome != 0 ||
                          expenseData.trackerCategory.totalExpense != 0)
                      ? reportSection(
                          w: w,
                          context: context,
                          currencySymbol: currencySymbol,
                          totalBalance: totalBalance,
                          totalIncome: totalIncome,
                          totalInvestment: totalInvestment,
                          totalExpense: totalExpense,
                          totalTax: totalTax,
                          theme: theme,
                        )
                      : noDataFoundSection(
                          w: w,
                          theme: theme,
                        ),
                  moreAppsCarousel(w: w, context: context, theme: theme),
                  if (!isAlreadyRated) playStoreRating(w, theme, prefsHelper),
                  if (!isAlreadyRated) spacerH(25),
                  socialMediaConnections(w, theme),
                  spacerH(80)
                ],
              ),
            ),
          ),

          Positioned(
              bottom: 0,
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: BannerAdWidget())),
        ],
      ),
    );
  }

  /// Report Section
  Widget reportSection(
      {required double w,
      required BuildContext context,
      required String currencySymbol,
      required double totalBalance,
      required double totalIncome,
      required double totalInvestment,
      required double totalExpense,
      required double totalTax,
      required ColorScheme theme}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SfCircularChart(
                // borderColor: theme.primary,
                backgroundColor: theme.onSecondary,
                borderWidth: 1,
                title: ChartTitle(
                    text: 'Expense Summary',
                    textStyle: AppStyles.headingPrimary(
                      context: context,
                      fontSize: 16,
                    )),
                legend: Legend(isVisible: true),
                series: <CircularSeries>[
                  PieSeries<ChartData, String>(
                    dataSource: [
                      ChartData('$currencySymbol Total Bal', totalBalance),
                      ChartData('Invest', totalInvestment),
                      ChartData('Tax', totalTax),
                      ChartData('Income', totalIncome),
                      ChartData('Expense', totalExpense),
                    ],
                    xValueMapper: (ChartData data, _) => data.category,
                    yValueMapper: (ChartData data, _) => data.amount,
                    pointColorMapper: (ChartData data, _) {
                      if (data.category.contains('Total Bal')) {
                        return AppColors.themeLight;
                      } else if (data.category == 'Income') {
                        return AppColors.lightGreen;
                      } else if (data.category == 'Expense') {
                        return AppColors.lightRed;
                      } else if (data.category == 'Invest') {
                        return AppColors.darkGreen;
                      } else if (data.category == 'Tax') {
                        return Colors.orange.withValues(alpha: 0.5);
                      }
                      return Colors.grey;
                    },
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        spacerH(10),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: w,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: theme.onSecondary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(),
                    title: ChartTitle(
                      text: 'Income, Investment, Expense, Tax & Total Balance',
                      textStyle: AppStyles.headingPrimary(
                        context: context,
                        fontSize: 16,
                      ),
                    ),
                    series: [
                      SplineSeries<ChartData, String>(
                        // LineSeries<ChartData, String>(
                        dataSource: [
                          ChartData('Income', totalIncome),
                          ChartData('Invest', totalInvestment),
                          ChartData('Expense', totalExpense),
                          ChartData('Tax', totalTax),
                          ChartData('Total Bal', totalBalance),
                        ],
                        xValueMapper: (ChartData data, _) => data.category,
                        yValueMapper: (ChartData data, _) => data.amount,
                        color: Colors.blue,
                        name: 'Income/Expense/Investment/Tax/Balance',
                      ),
                    ],
                  ),
                  spacerH(),
                  SizedBox(
                    height: 400,
                    width: w,
                    child: BarChart(
                      BarChartData(
                        maxY: [
                              totalTax,
                              totalIncome,
                              totalInvestment,
                              totalExpense,
                              totalBalance
                            ].map((e) => e < 0 ? -e : e).reduce(max) +
                            500,
                        titlesData: FlTitlesData(show: true),
                        borderData: FlBorderData(show: true),
                        gridData: FlGridData(show: true),
                        barGroups: [
                          BarChartGroupData(
                            x: 0,
                            barRods: [
                              BarChartRodData(
                                toY: totalIncome,
                                color: Colors.greenAccent,
                                width: 20,
                              ),
                            ],
                          ),
                          BarChartGroupData(
                            x: 1,
                            barRods: [
                              BarChartRodData(
                                toY: totalInvestment,
                                color: Colors.green,
                                width: 20,
                              ),
                            ],
                          ),
                          BarChartGroupData(
                            x: 2,
                            barRods: [
                              BarChartRodData(
                                toY: totalExpense,
                                color: Colors.red,
                                width: 20,
                              ),
                            ],
                          ),
                          BarChartGroupData(
                            x: 3,
                            barRods: [
                              BarChartRodData(
                                toY: totalTax,
                                color: Colors.orange,
                                width: 20,
                              ),
                            ],
                          ),
                          BarChartGroupData(
                            x: 4,
                            barRods: [
                              BarChartRodData(
                                toY: totalBalance,
                                color: Colors.blue,
                                width: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  spacerH(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Wrap(
                      runSpacing: 10,
                      spacing: 15,
                      children: chartInfo.map((e) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: e.color,
                              ),
                            ),
                            spacerW(5),
                            Text(
                              e.title,
                              style: AppStyles.descriptionPrimary(
                                context: context,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  spacerH(),
                ],
              ),
            ),
          ),
        ),
        spacerH(30),
      ],
    );
  }

  /// No Data Found Section
  Widget noDataFoundSection({required final double w, required final theme}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 30, top: 5, left: 20, right: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: w,
        height: 280,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(StaticAssets.noDataFoundImage),
            fit: BoxFit.cover,
          ),
          color: theme.onSecondary,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  ///More Apps Carousel
  Widget moreAppsCarousel(
      {required double w, required BuildContext context, required theme}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Text(
            "More Apps",
            style: AppStyles.headingPrimary(
              context: context,
            ),
          ),
        ),
        spacerH(),
        ReusableMoreAppsCarousel(
          w: w,
        ),
      ],
    );
  }

  ///PlayStore rating widget
  Widget playStoreRating([final w, final theme, final prefsHelper]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
            width: w,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: theme.onSecondary,
              borderRadius: BorderRadius.circular(15),
              // border: Border.all(
              //   color: theme.primary,
              //   width: 2,
              // ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Enjoy BudgetFlow?",
                  style: AppStyles.headingPrimary(
                    context: context,
                    fontSize: 26,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                spacerH(15),
                Text(
                  "Take a minute to provide your review and rating on the Play Store.",
                  style: AppStyles.descriptionPrimary(
                      context: context, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                spacerH(15),
                PlatyStoreRating(
                  url: Constants.budgetFlowUrl,
                ),
                spacerH(15),
                InkWell(
                  onTap: () {
                    setState(() {
                      isAlreadyRated = true;
                    });

                    prefsHelper.setBoolValue(PrefsKeys.alreadyRated, true);
                  },
                  child: Text(
                    "I have already rated",
                    style: AppStyles.descriptionPrimary(
                      context: context,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  ///Social media Connection
  Widget socialMediaConnections([final w, final theme]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
            width: w,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: theme.onSecondary,
              borderRadius: BorderRadius.circular(15),
              // border: Border.all(
              //   color: theme.primary,
              //   width: 2,
              // ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We're on Social Media",
                  style: AppStyles.headingPrimary(
                    context: context,
                  ),
                ),
                spacerH(10),
                Text(
                  "Follow us on social media to get the latest updates and offers",
                  style: AppStyles.descriptionPrimary(context: context),
                ),
                spacerH(15),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ReusableIconButton(
                            title: 'Youtube',
                            icon: FontAwesomeIcons.youtube,
                            colors: AppGradients.youtubeGradient,
                            url: Constants.youtubeLink,
                            spacerWidth: 15,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: ReusableIconButton(
                            title: 'Instagram',
                            icon: FontAwesomeIcons.instagram,
                            colors: AppGradients.instagramGradient,
                            url: Constants.instagramLink,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ReusableIconButton(
                            title: 'Facebook',
                            icon: FontAwesomeIcons.facebook,
                            colors: AppGradients.facebookGradient,
                            url: Constants.facebookLink,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: ReusableIconButton(
                            title: 'WhatsApp',
                            icon: FontAwesomeIcons.whatsapp,
                            colors: AppGradients.greenGradient,
                            url: Constants.whatsAppChannelLink,
                            socialIconSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}



