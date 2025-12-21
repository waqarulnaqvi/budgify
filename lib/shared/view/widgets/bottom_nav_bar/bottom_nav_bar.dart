import 'package:budgify/features/expense_tracker/view/widgets/dialog/reusable_dialog_class.dart';
import 'package:budgify/features/insights/view/pages/insights_page.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../../core/ads/ad_helper.dart';
import '../../../../core/constants/prefs_keys.dart';
import '../../../../core/local/prefs_helper.dart';
import '../../../../features/emi_and_loan/view/pages/emi_and_loan.dart';
import '../../../../features/expense_tracker/view/pages/expense_tracker_home_page.dart';
import '../../../../features/my_budget/view/pages/my_budget_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  String bottomNavFontFamily = 'Poppins';
  int currentPage = 0;
  List<Widget> bottomBarPages = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    bottomBarPages = [
      ExpenseTrackerHomePage(scaffoldKey: _scaffoldKey),
      EmiAndLoan(),
      MyBudgetPage(),
      InsightsPage(),
    ];
    // 🔥 Run after UI is fully rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showOpenAd();
    });
  }

  Future<void> showOpenAd() async {
    PrefsHelper prefs = PrefsHelper();
    int count = await prefs.getIntValue(PrefsKeys.isShowOpenAds) ?? 1;
    if ( count % 6 == 0) {
      AdHelper.createAndShowAppOpenAd();
    } else {
      count++;
      await prefs.setIntValue(PrefsKeys.isShowOpenAds, count);
    }
    debugPrint("It is a count $count");
  }
  void _onItemTapped(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  void dispose() {
    _scaffoldKey.currentState?.closeEndDrawer();
    _scaffoldKey.currentState?.closeDrawer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Important: block auto pop
      onPopInvokedWithResult: (value, result) async {
        final scaffold = _scaffoldKey.currentState;

        // 🔥 Check if ANY drawer is open
        if (scaffold?.isDrawerOpen == true ||
            scaffold?.isEndDrawerOpen == true) {
          scaffold?.closeDrawer();
          scaffold?.closeEndDrawer();
          return; // ⛔ Stop further actions
        }

        bool? shouldExit = await ReusableDialogClass.showYesNoDialog(context);

        if (shouldExit == true) {
          if (context.mounted) {
            Navigator.pop(context); // exit the screen
          }
        }
      },
      child: Scaffold(
        // extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Stack(
          children: [
            IndexedStack(index: currentPage, children: bottomBarPages),
          ],
        ),

        // body: bottomBarPages[currentPage],
        bottomNavigationBar: SalomonBottomBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          items: bottomNavBarItems(context),
          currentIndex: currentPage,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  List<SalomonBottomBarItem> bottomNavBarItems(BuildContext context) => [
    SalomonBottomBarItem(
      selectedColor: Theme.of(context).colorScheme.primary,
      icon: const Icon(Icons.monetization_on_outlined),
      title: Text(
        'Expense Tracker',
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: bottomNavFontFamily),
      ),
    ),
    // SalomonBottomBarItem(
    //   selectedColor: Theme.of(context).colorScheme.primary,
    //   icon: const Icon(Icons.account_balance),
    //   title: Text(
    //     'EMI & Loan',
    //     textAlign: TextAlign.center,
    //     style: TextStyle(fontFamily: bottomNavFontFamily),
    //   ),
    // ),

    SalomonBottomBarItem(
      selectedColor: Theme.of(context).colorScheme.primary,
      icon: const Icon(Icons.account_balance_wallet_outlined),
      title: Text(
        'My Budget',
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: bottomNavFontFamily),
      ),
    ),
    SalomonBottomBarItem(
      selectedColor: Theme.of(context).colorScheme.primary,
      icon: const Icon(Icons.bar_chart),
      title: Text(
        'Insights',
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: bottomNavFontFamily),
      ),
    ),
  ];
}
