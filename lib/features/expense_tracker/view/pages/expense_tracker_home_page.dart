import 'package:budgify/features/expense_tracker/model/card_model.dart';
import 'package:budgify/features/expense_tracker/utils/expense_type.dart';
import 'package:budgify/features/expense_tracker/view/widgets/filters/investment_filter.dart';
import 'package:budgify/features/expense_tracker/view/widgets/filters/tax_filter.dart';
import 'package:budgify/features/expense_tracker/view/widgets/reusable_floating_action_button.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/static_assets.dart';
import '../../../../core/routes/paths.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../shared/view/widgets/date_filter.dart';
import '../../../../shared/view/widgets/global_widgets.dart';
import '../../../../shared/view/widgets/theme_controller_widget.dart';
import '../../model/tracker_model.dart';
import '../../viewmodel/riverpod/currency_provider.dart';
import '../../viewmodel/riverpod/expense_tracker_notifier.dart';
import '../../viewmodel/riverpod/investment_provider.dart';
import '../../viewmodel/riverpod/tax_provider.dart';
import '../../viewmodel/riverpod/transaction_provider.dart';
import '../widgets/buttons/filter_button.dart';
import '../widgets/buttons/reusable_outlined_button.dart';
import '../widgets/card/reusable_card_widget.dart';
import '../widgets/drawer/custom_drawer.dart';
import '../widgets/filters/transaction_filter.dart';
import '../widgets/reusable_card_details.dart';
import '../widgets/transaction_history/reusable_info.dart';
import '../widgets/transaction_history/transaction_info.dart';
part 'expense_tracker_page.dart';
part 'investment_page.dart';
part 'tax_page.dart';

class ExpenseTrackerHomePage extends ConsumerStatefulWidget {
  const ExpenseTrackerHomePage({super.key});

  @override
  ConsumerState<ExpenseTrackerHomePage> createState() =>
      _ExpenseTrackerHomePageState();
}

class _ExpenseTrackerHomePageState extends ConsumerState<ExpenseTrackerHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scaffoldKey.currentState?.closeEndDrawer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(h: h, w: w * 0.7),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: AppGradients.skyBlueMyAppGradient,),
              ),
              child: appBar(theme))),
      backgroundColor: theme.surface,
      body: Stack(
        children: [
          Positioned.fill(
              child: Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: AppGradients.skyBlueMyAppGradient),
            ),
          )),


          Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.surface,
                  ),
                  child: Column(
                    children: [
                      TabBar(
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: theme.primary,
                          labelStyle: AppStyles.headingPrimary(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              context: context,
                              color: theme.primary),
                          tabs: [
                            Tab(text: 'All'),
                            Tab(text: 'Investment'),
                            Tab(text: 'Tax'),
                          ]),
                      Expanded(
                          child: TabBarView(controller: _tabController, children: [
                        ExpenseTrackerPage(),
                        InvestmentPage(),
                        TaxPage(),
                      ]))
                    ],
                  ),
                ),
              ),
            ),

        ],
      ),
    );
  }

  ///AppBar
  Widget appBar(final ColorScheme theme) {
    String timeString = DateTime.now().toString().split(" ")[1];
    // Parse the hour part
    int hour = int.parse(timeString.split(":")[0]);

    String greeting;
    if (hour >= 5 && hour < 12) {
      greeting = "Good Morning!";
    } else if (hour >= 12 && hour < 17) {
      greeting = "Good Afternoon!";
    } else {
      greeting = "Good Evening!";
    }
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5,bottom: 15),
      child: SafeArea(
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(StaticAssets.userProfile),
              ),
              spacerW(10),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hi,",
                      style: AppStyles.descriptionPrimary(
                          context: context, fontSize: 14, color: Colors.white)),
                  spacerH(2),
                  Text(greeting,
                      style: AppStyles.headingPrimary(
                          context: context, fontSize: 18, color: Colors.white,fontWeight: FontWeight.w800)),
                ],
              ),
              const Spacer(),
              ThemeControllerWidget(),
              spacerW(8),
              InkWell(
                onTap: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
                child: Icon(
                  FontAwesomeIcons.barsStaggered,
                  color: Colors.white,
                  size: 20,
                ),
              ),


            ]),
      ),
    );
  }
}

// ReusableAppBar(
// text: 'Expense Tracker',
// text: 'Profile',
// isCenterText: false,
// isMenu: true,
// onPressed: () {
// _scaffoldKey.currentState!.openEndDrawer();
// },
// ),

// spacerH(),
// Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 15.0),
//     child: DateFilter()),
// spacerH(10),
// CurrencyPicker(),
// spacerH(10),
