import 'package:budgify/features/expense_tracker/model/on_changed_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var onChangeValueProvider = StateProvider<OnChangedModel>((ref) {
  return OnChangedModel(
    beforeOperationAmount: "0",
    percentage: "0",
    // afterOperationAmount: "0",
    changedAmount: "0",
    isTaxPage: false,
  );
});

var onChangedInvestmentTaxProvider = StateProvider<OnChangedModel>((ref) {
  final value = ref.watch(onChangeValueProvider);
  final percentage = double.tryParse(value.percentage) ?? 0.0;
  final beforeOperationAmount =
      double.tryParse(value.beforeOperationAmount) ?? 0.0;
  // double afterOperationAmount = 0.0;
  double changedAmount = 0.0;


  changedAmount = beforeOperationAmount * (percentage / 100);
  // if (value.isTaxPage) {
  //   afterOperationAmount = beforeOperationAmount - changedAmount;
  // } else {
  //   afterOperationAmount = beforeOperationAmount + changedAmount;
  // }

  return OnChangedModel(
    beforeOperationAmount: beforeOperationAmount.toStringAsFixed(2),
    percentage: percentage.toStringAsFixed(2),
    // afterOperationAmount: afterOperationAmount.toStringAsFixed(2),
    changedAmount: changedAmount.toStringAsFixed(2),
  );
});
