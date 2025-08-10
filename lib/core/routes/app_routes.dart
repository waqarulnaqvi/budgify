import 'package:budgify/core/routes/paths.dart';
import 'package:budgify/features/expense_tracker/view/pages/all_transaction_page.dart';
import 'package:budgify/features/expense_tracker/view/pages/expense_management_page.dart';
import 'package:flutter/material.dart';
import '../../features/expense_tracker/model/tracker_model.dart';
import '../../features/expense_tracker/view/pages/investment_tax_history_page.dart';
import '../../features/expense_tracker/view/pages/more_apps_page.dart';
import '../../features/expense_tracker/view/widgets/google_forms_in_app_web_view.dart';
import '../../features/my_budget/model/my_budget_model.dart';
import '../../features/my_budget/view/pages/budget_management_page.dart';
import '../../shared/view/widgets/bottom_nav_bar/bottom_nav_bar.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Paths.initial:
        return MaterialPageRoute(builder: (context) => BottomNavBar());

      case Paths.moreAppsPage:
        return MaterialPageRoute(builder: (context) => MoreAppsPage());

      case Paths.expenseManagementPage:
        return MaterialPageRoute(builder: (context) {
          final tracker = settings.arguments as TrackerModel?;
          return ExpenseManagementPage(
            trackerModel: tracker,
          );
        });

      case Paths.allTransactionPage:
        return MaterialPageRoute(
            builder: (context) => const AllTransactionPage());

      case Paths.investmentTaxHistoryPage:
        final isTaxPage = settings.arguments as bool?;

        return MaterialPageRoute(
            builder: (context) => InvestmentTaxHistoryPage(
                  isTaxPage: isTaxPage ?? false,
                ));

      case Paths.googleFormsInAppWebView:
        return MaterialPageRoute(
            builder: (context) => GoogleFormInAppWebView());

      case Paths.budgetManagementPage:
        final myBudgetModel = settings.arguments as MyBudgetModel?;

        return MaterialPageRoute(
            builder: (context) =>  BudgetManagementPage(
                  myBudgetModel: myBudgetModel,
            ));

      default:
        return MaterialPageRoute(builder: (context) => const BottomNavBar());
    }
  }
}
