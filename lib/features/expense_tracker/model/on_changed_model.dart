class OnChangedModel {
  final String beforeOperationAmount;
  final String percentage;
  // final String afterOperationAmount;
  final String changedAmount;
  final bool isTaxPage;

  const OnChangedModel({
    required this.beforeOperationAmount,
    required this.percentage,
    // this.afterOperationAmount="0.0",
    this.changedAmount="0.0",
    this.isTaxPage = false,
  });

  copyWith({
    String? beforeOperationAmount,
    String? percentage,
    // String? afterOperationAmount,
    String? changedAmount,
    bool? isTaxPage,
  }) {
    return OnChangedModel(
      beforeOperationAmount: beforeOperationAmount ?? this.beforeOperationAmount,
      percentage: percentage ?? this.percentage,
      // afterOperationAmount: afterOperationAmount ?? this.afterOperationAmount,
      changedAmount: changedAmount ?? this.changedAmount,
      isTaxPage: isTaxPage ?? this.isTaxPage,
    );
  }
}
