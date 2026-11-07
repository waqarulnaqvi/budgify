import 'package:budgify/features/expense_tracker/view/widgets/dialog/reusable_dialog_class.dart';
import 'package:budgify/shared/view/widgets/containers/reusable_container_widget.dart';
import 'package:budgify/shared/view/widgets/reusable_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../../../core/theme/app_styles.dart';
import '../../../../shared/view/widgets/global_widgets.dart';
import '../../../../shared/view/widgets/text_view/reusable_text_field.dart';

class InstallmentDetailsPage extends ConsumerStatefulWidget {
  const InstallmentDetailsPage({super.key});

  @override
  ConsumerState<InstallmentDetailsPage> createState() =>
      _InstallmentDetailsPageState();
}

class _InstallmentDetailsPageState
    extends ConsumerState<InstallmentDetailsPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController totalInstallmentsController = TextEditingController();
  final TextEditingController installmentCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.secondary,
      appBar: ReusableAppBar(
        text: "Add Installment Details",
        isCenterText: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              spacerH(40),
              ReusableTextField(
                maxLines: 5,
                controller: titleController,
                hintText: "Enter Title",
                prefixIcon: Icons.title_outlined,
                keyboardType: TextInputType.multiline,
              ),
              spacerH(),
              ReusableTextField(
                maxLines: 5,
                controller: descriptionController,
                hintText: "Enter Description",
                prefixIcon: Icons.description_outlined,
                keyboardType: TextInputType.multiline,
              ),
              spacerH(),
              ReusableTextField(
                controller: totalInstallmentsController,
                hintText: "Enter Total Installments",
                prefixIcon:  Icons.account_balance,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
              ),
              spacerH(),

              ReusableContainerWidget(
                text: "Date of First Installment",
                icon: Icons.calendar_month_outlined,
                onTap: () async {
                  await ReusableDialogClass.setDateDialog(
                    context,
                    selectedDate: DateTime.now(),
                    onApplyTap: () {},
                    onDateTimeChanged: (DateTime value) {},
                    onTapToday: () {},
                  );
                },
              ),
              spacerH(),
              ReusableContainerWidget(
                text: "Date of Alarm",
                icon: Icons.calendar_month_outlined,
                onTap: () async {
                  await ReusableDialogClass.setDateDialog(
                    context,
                    selectedDate: DateTime.now(),
                    onApplyTap: () {},
                    onDateTimeChanged: (DateTime value) {},
                    onTapToday: () {},
                  );
                },
              ),
              spacerH(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  minimumSize: Size(w, 45),
                  backgroundColor: theme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Add Installment",
                  style: AppStyles.descriptionPrimary(
                    context: context,
                    color: Colors.white,
                  ),
                ),
              ),
              spacerH(100),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectDate(
    double w,
    BuildContext context,
    final theme,
    final String text,
  ) {
    return Container(
      width: w,
      height: 55,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: theme.surface,
        border: Border.all(width: 1, color: theme.onSurface),
      ),
      child: InkWell(
        onTap: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Select Date'),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close, color: Colors.black),
                    ),
                  ],
                ),
                content: Container(
                  decoration: BoxDecoration(
                    color: theme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 200,
                  width: w,
                  child: ScrollDatePicker(
                    // selectedDate: parseDate(dateRef.selectedDate),
                    selectedDate: DateTime.now(),
                    // maximumDate:
                    //     DateTime.now().add(const Duration(days: 365 * 30)),
                    // selectedDate: DateTime.now(),
                    locale: const Locale('en', 'US'),
                    onDateTimeChanged: (DateTime value) async {
                      // await ref
                      //     .read(dateProvider.notifier).selectedDate(formatDate(value));
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
                          // await ref
                          //     .read(dateProvider.notifier)
                          //     .selectedDate(formatDate(DateTime.now()));

                          // ref.read(dateProvider.notifier).state = DateModel(
                          //     selectedDate: formatDate(DateTime.now()));
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
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
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      spacerW(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
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
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
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
              // dateRef.selectedDate,
              text,
              style: AppStyles.descriptionPrimary(context: context),
            ),
            Spacer(),
            Icon(Icons.arrow_drop_down_rounded, color: theme.onSurface),
          ],
        ),
      ),
    );
  }
}
