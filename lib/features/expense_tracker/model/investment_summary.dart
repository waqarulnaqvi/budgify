import 'package:budgify/features/expense_tracker/model/tracker_model.dart';

class InvestmentSummary {
  final List<FilteredExpModel> trackerModel;
  final InvestmentModel investmentModel;

  const InvestmentSummary({
    required this.trackerModel,
    required this.investmentModel,
  });

  // Add this static method
  static InvestmentSummary empty() {
    return InvestmentSummary(
        trackerModel: [],
        investmentModel: InvestmentModel(
            currentAmount: '0.00',
            investedAmount: '0.00',
            totalReturns: '0.00',
            returnsPercentage: '0.00'));
  }
}

class InvestmentModel {
  final String currentAmount;
  final String investedAmount;
  final String totalReturns;
  final String returnsPercentage;

  const InvestmentModel({
    required this.currentAmount,
    required this.investedAmount,
    required this.totalReturns,
    required this.returnsPercentage,
  });
}
