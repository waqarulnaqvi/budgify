part of 'my_budget_notifier.dart';

class MyBudgetState extends Equatable{
  final bool isShowFilter;
  final bool isLoading;
  final Color selectedColor;
  final OrderFilter orderFilter;
  final SortingFilter sortingFilter;
  final StyleFilter styleFilter;
  final String? errorMessage;
  final List<MyBudgetModel> myBudgetList;

  const MyBudgetState({
    this.isShowFilter=false,
    this.isLoading=false,
    this.styleFilter= StyleFilter.staggered,
    this.orderFilter= OrderFilter.descending,
    this.sortingFilter= SortingFilter.datetime,
    this.selectedColor = AppColors.redOrange,
    this.errorMessage,
    this.myBudgetList = const [],
  });

  @override
  List<Object?> get props => [
    isLoading,
    isShowFilter,
    orderFilter,
    styleFilter,
    sortingFilter,
    errorMessage,
    myBudgetList,
    selectedColor,
  ];

  MyBudgetState copyWith({
    bool? isLoading,
    bool? isShowFilter,
    OrderFilter? orderFilter,
    SortingFilter? sortingFilter,
    StyleFilter? styleFilter,
    String? errorMessage,
    List<MyBudgetModel>? myBudgetList,
    Color? selectedColor,
  }) {
    return MyBudgetState(
      isLoading: isLoading?? this.isLoading,
      isShowFilter: isShowFilter ?? this.isShowFilter,
      styleFilter: styleFilter ?? this.styleFilter,
      orderFilter: orderFilter ?? this.orderFilter,
      sortingFilter: sortingFilter ?? this.sortingFilter,
      errorMessage: errorMessage ?? this.errorMessage,
      myBudgetList: List.unmodifiable(myBudgetList ?? this.myBudgetList),
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }
}
