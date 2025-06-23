import 'package:budgify/core/constants/constants.dart';
import 'package:budgify/features/expense_tracker/model/card_model.dart';
import 'package:budgify/features/expense_tracker/viewmodel/riverpod/on_changed_value_provider.dart';
import 'package:budgify/shared/view/widgets/ads/banner_ads.dart';
import 'package:budgify/shared/view/widgets/containers/reusable_folded_corner_container.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:budgify/core/theme/app_styles.dart';
import 'package:budgify/shared/view/widgets/global_widgets.dart';
import 'package:budgify/shared/view/widgets/reusable_app_bar.dart';
import 'package:budgify/shared/view/widgets/text_view/reusable_text_field.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/tracker_model.dart';
import '../../utils/expense_type.dart';
import '../../viewmodel/riverpod/currency_provider.dart';
import '../../viewmodel/riverpod/expense_tracker_notifier.dart';
import '../../viewmodel/riverpod/selected_value_provider.dart';
import '../widgets/custom_drop_down.dart';

class ExpenseManagementPage extends ConsumerStatefulWidget {
  final TrackerModel? trackerModel;

  const ExpenseManagementPage({this.trackerModel, super.key});

  @override
  ConsumerState<ExpenseManagementPage> createState() =>
      _ExpenseManagementPageState();
}

class _ExpenseManagementPageState extends ConsumerState<ExpenseManagementPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateValues();
    });
  }

  void updateValues() {
    if (widget.trackerModel != null) {
      // final dateRef = ref.watch(dateProvider);

      titleController.text = widget.trackerModel!.title;

      if (widget.trackerModel!.amount != null) {
        amountController.text = widget.trackerModel!.amount.toString();
      }

      ref.read(selectedValueProvider.notifier).state =
          ExpenseType.investment.value;

      final selectedExpenseType = ExpenseType.values
          .firstWhere(
            (e) => e.intValue == widget.trackerModel!.trackerCategory,
            orElse: () => ExpenseType.expense, // Default fallback if not found
          )
          .value;

      // print("Selected Expense Type: ${selectedExpenseType}");

      ref.read(selectedValueProvider.notifier).state = selectedExpenseType;
      ref.read(chooseCategoryProvider.notifier).state = widget.trackerModel!.chooseCategory;
      if (widget.trackerModel!.percentage != 0.0) {
        percentageController.text = widget.trackerModel!.percentage.toString();
      }
    }
  }

  void chooseCategoryBottomSheet(
      {required final double w,
      required final chooseCategory,
      required final ColorScheme theme}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(15),
            width: w,
            child: Column(
              children: [
                spacerH(10),
                Text("Choose Category",
                    style: AppStyles.headingPrimary(
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                spacerH(10),
                Expanded(
                  child: GridView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: Constants.mCat.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            ref.read(chooseCategoryProvider.notifier).state =
                                index;
                            // setState(() {
                            //   selectedCatIndex = index;
                            // });
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: chooseCategory == index
                                  ? theme.primary.withValues(alpha: 0.05)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              // shape: BoxShape.circle,
                              border: Border.all(
                                width: 1.5,
                                color: chooseCategory == index
                                    ? theme.primary
                                    : Colors.transparent,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                      Constants.mCat[index]["catImage"],
                                    ),
                                    backgroundColor:
                                        theme.primary.withValues(alpha: 0.4),
                                    radius: 22,
                                  ),
                                  spacerH(5),
                                  Text(
                                    Constants.mCat[index]["catName"],
                                    style: AppStyles.descriptionPrimary(
                                        context: context, fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    percentageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedValue = ref.watch(selectedValueProvider);
    final rProvider = ref.read(currencyProvider.notifier);
    final currency = ref.watch(currencyProvider).value?.symbol ?? '₹';
    final dateRef = ref.watch(dateProvider).value;
    final isTaxPage = selectedValue == ExpenseType.tax.value;
    final isShowReturn = selectedValue == ExpenseType.investment.value ||
        selectedValue == ExpenseType.tax.value;
    var percentageValue = double.tryParse(percentageController.text) ?? 0.0;

    final chooseCategory = ref.watch(chooseCategoryProvider);

    final String selectedText;
    if (selectedValue == ExpenseType.income.value) {
      selectedText = "Add Income";
    } else if (selectedValue == ExpenseType.expense.value) {
      selectedText = "Add Expense";
    } else if (selectedValue == ExpenseType.investment.value) {
      selectedText = "Add Investment";
    } else {
      selectedText = "Add Tax";
    }
    final trackerRProvider = ref.read(expenseTrackerProviderOriginal.notifier);
    final double w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).colorScheme;
    final onChangedValue = ref.read(onChangeValueProvider);
    final onChangedProvider = ref.read(onChangedInvestmentTaxProvider);


    var beforeOperationAmount = double.parse(onChangedProvider.beforeOperationAmount);
    var changedAmount = double.parse(onChangedProvider.changedAmount);
    String afterOperationAmount = "0.0";

    /// This is the logic to calculate the after operation amount based on whether it's a tax page or investment page.
    if (isTaxPage) {
      afterOperationAmount = (beforeOperationAmount - changedAmount).toStringAsFixed(2);
    } else {
      afterOperationAmount = (beforeOperationAmount + changedAmount).toStringAsFixed(2);
    }
    // final isDarkTheme = MediaQuery.of(context).platformBrightness ==
    //     Brightness.dark;

    return Scaffold(
      backgroundColor: theme.secondary,
      appBar: ReusableAppBar(
        text: selectedText,
        isCenterText: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isShowReturn ? spacerH(40) : spacerH(),
            Visibility(
                visible: isShowReturn,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: ReusableFoldedCornerContainer(
                    isTaxPage: isTaxPage,
                    section1: CardModel(
                        name: isTaxPage ? "After Tax:" : "Current Amount:",
                        value:
                            "$currency$afterOperationAmount"),
                    section2: CardModel(
                        name: isTaxPage ? "Before Tax:" : "Invested Amount:",
                        value:
                            "$currency${onChangedProvider.beforeOperationAmount}"),
                    section3: CardModel(
                        name: isTaxPage ? "Total Tax:" : "Total Returns:",
                        value: "$currency${onChangedProvider.changedAmount}"),
                    section4: CardModel(
                      name: isTaxPage ? "Tax %:" : "Returns %:",
                      value: onChangedValue.percentage == "0" ||
                              onChangedValue.percentage == ""
                          ? "0.0%"
                          : "${onChangedValue.percentage}%",
                    ),
                  ),
                )),
            spacerH(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ReusableTextField(
                    maxLines: 5,
                    controller: titleController,
                    hintText: "Enter Title",
                    prefixIcon: Icons.title_outlined,
                    keyboardType: TextInputType.multiline,
                  ),
                  spacerH(),
                  ReusableTextField(
                    prefixText: currency,
                    onTapPrefix: () {
                      showCurrencyPicker(
                        context: context,
                        showFlag: true,
                        showCurrencyName: true,
                        showCurrencyCode: true,
                        onSelect: (Currency currency) async {
                          await rProvider.currencyFilter(
                            name: currency.name,
                            code: currency.code,
                            symbol: currency.symbol,
                          );

                          // rProvider.state = CurrencyModel.fromJson(currency);
                          // print(currency.name);
                        },
                      );
                    },
                    controller: amountController,
                    hintText: "Enter Amount",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                      // FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      ref.read(onChangeValueProvider.notifier).state =
                          onChangedValue.copyWith(
                        beforeOperationAmount: value,
                        percentage: percentageController.text,
                        isTaxPage: isTaxPage,
                      );
                    },
                  ),
                  spacerH(),
                  SizedBox(
                    height: 55,
                    // height: 40,
                    child: CustomDropDown(
                        icon: Icons.arrow_drop_down_rounded,
                        categories:
                            ExpenseType.values.map((e) => e.value).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            ref.read(selectedValueProvider.notifier).state =
                                newValue;
                          }
                        },
                        selectedValue: selectedValue),
                  ),

                  spacerH(),
                  InkWell(
                    onTap: () => chooseCategoryBottomSheet(
                        w: w, chooseCategory: chooseCategory, theme: theme),
                    child: Container(
                      width: w,
                      height: 55,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: theme.surface,
                        border: Border.all(
                          width: 1,
                          color: theme.onSurface,
                        ),
                      ),
                      child: AbsorbPointer(
                        child: Row(children: [
                          Row(
                            children: [
                              chooseCategory != -1
                                  ? CircleAvatar(
                                      backgroundImage: AssetImage(
                                        Constants.mCat[chooseCategory]
                                            ["catImage"],
                                      ),
                                      backgroundColor:
                                          theme.primary.withValues(alpha: 0.4),
                                      radius: 22,
                                    )
                                  : staticImage(
                                      assetName: "assets/icons/categories.png",
                                      width: 25,
                                      height: 25),
                              spacerW(10),
                              Text(
                                chooseCategory != -1
                                    ? Constants.mCat[chooseCategory]["catName"]
                                    : "Choose Category",
                                style: AppStyles.descriptionPrimary(
                                    context: context),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            color: theme.onSurface,
                          ),
                        ]),
                      ),
                    ),
                  ),

                  spacerH(),
                  if (isShowReturn)
                    ReusableTextField(
                      prefixIcon: Icons.percent,
                      controller: percentageController,
                      hintText: "0",
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^-?\d*\.?\d*'),
                        ),
                        // FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        ref.read(onChangeValueProvider.notifier).state =
                            onChangedValue.copyWith(
                          percentage: percentageController.text,
                          isTaxPage: isTaxPage,
                        );
                      },
                    ),
                  if (isShowReturn) spacerH(),
                  selectDate(w, context, theme, dateRef),
                  spacerH(),
                  ElevatedButton(
                      onPressed: () {
                        if (amountController.text.isEmpty) {
                          IconSnackBar.show(
                            context,
                            label: "Please enter amount!",
                            snackBarType: SnackBarType.alert,
                          );
                          return;
                        }

                        if (isTaxPage && percentageValue < 0.0) {
                          IconSnackBar.show(
                            context,
                            label: "Tax cannot be negative!",
                            snackBarType: SnackBarType.alert,
                          );
                          return;
                        }

                        if (chooseCategory == -1) {
                          IconSnackBar.show(
                            context,
                            label: "Please choose a category!",
                            snackBarType: SnackBarType.alert,
                          );
                          return;
                        }

                        ///It is a special condition because when we add value then while navigating amount will always be null and if we update value then amount can not be possibly null.
                        if (widget.trackerModel!.amount != null &&
                            chooseCategory != -1) {
                          trackerRProvider.updateData(
                            chooseCategory: chooseCategory,
                            // Default value for chooseCategory
                            id: widget.trackerModel!.id ?? 0,
                            title: titleController.text.isEmpty
                                ? ""
                                : titleController.text,
                            percentage: double.parse(
                                percentageController.text.isEmpty
                                    ? "0"
                                    : percentageController.text),
                            date: dateRef!.selectedDate ??
                                formatDate(DateTime.now()),
                            amount: double.parse(amountController.text),
                            trackerCategory: ExpenseType.values
                                .firstWhere((e) => e.value == selectedValue)
                                .intValue,
                          );
                        } else {
                          trackerRProvider.addData(
                            chooseCategory: chooseCategory,
                            // Default value for chooseCategory
                            title: titleController.text.isEmpty
                                ? ""
                                : titleController.text,
                            date: dateRef!.selectedDate ??
                                formatDate(DateTime.now()),
                            percentage: double.parse(
                                percentageController.text.isEmpty
                                    ? "0"
                                    : percentageController.text),
                            amount: double.parse(amountController.text),
                            trackerCategory: ExpenseType.values
                                .firstWhere((e) => e.value == selectedValue)
                                .intValue,
                          );
                        }
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        minimumSize: Size(w, 45),
                        backgroundColor: theme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        selectedText,
                        style: AppStyles.descriptionPrimary(
                            context: context, color: Colors.white),
                      ))
                ],
              ),
            ),
            spacerH(30),
            BannerAdWidget(),
            spacerH(50),
          ],
        ),
      ),
    );
  }

  Widget selectDate(
      double w, BuildContext context, final theme, final dateRef) {
    return Container(
      width: w,
      height: 55,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: theme.surface,
        border: Border.all(
          width: 1,
          color: theme.onSurface,
        ),
      ),
      child: InkWell(
        onTap: () {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Select Date'),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  content: Container(
                    decoration: BoxDecoration(
                        color: theme.surface,
                        borderRadius: BorderRadius.circular(10)),
                    height: 200,
                    width: w,
                    child: ScrollDatePicker(
                      selectedDate: parseDate(dateRef.selectedDate),
                      // maximumDate:
                      //     DateTime.now().add(const Duration(days: 365 * 30)),
                      // selectedDate: DateTime.now(),
                      locale: const Locale('en', 'US'),
                      onDateTimeChanged: (DateTime value) async {
                        await ref
                            .read(dateProvider.notifier).selectedDate(formatDate(value));
                        
                        
                        // ref.read(dateProvider.notifier).state =
                        //     dateRef.copyWith(selectedDate: formatDate(value));
                      },
                    ),
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            Navigator.of(context).pop();
                            await ref
                                .read(dateProvider.notifier)
                                .selectedDate(formatDate(DateTime.now()));


                            // ref.read(dateProvider.notifier).state = DateModel(
                            //     selectedDate: formatDate(DateTime.now()));
                          },
                          child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: theme.primary,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Today",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                              )),
                        ),
                        spacerW(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: theme.primary,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Apply",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                );
              });
        },
        child: Row(
          children: [
            spacerW(10),
            Icon(
              Icons.calendar_month_outlined,
              color: theme.onSurface,
              size: 20,
            ),
            spacerW(10),
            Text(
              dateRef.selectedDate,
              style: AppStyles.descriptionPrimary(context: context),
            ),
            Spacer(),
            Icon(
              Icons.arrow_drop_down_rounded,
              color: theme.onSurface,
            )
          ],
        ),
      ),
    );
  }
}
