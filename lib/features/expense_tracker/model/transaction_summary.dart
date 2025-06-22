import 'package:budgify/features/expense_tracker/model/tracker_model.dart';

class TransactionSummary {
  final List<FilteredExpModel> filteredExpModel;
  final TransactionModel transactionModel;

  TransactionSummary({
    required this.filteredExpModel,
    required this.transactionModel,
  });

  // Add this static method
  static TransactionSummary empty() {
    return TransactionSummary(
      filteredExpModel: [],
      transactionModel: TransactionModel(
        income: '0.00',
        expense: '0.00',
        totalBalance: '0.00',
      ),
    );
  }
}



class TransactionModel {
  final String income;
  final String expense;
  final String totalBalance;

  const TransactionModel({
    required this.income,
    required this.expense,
    required this.totalBalance,
  });
}