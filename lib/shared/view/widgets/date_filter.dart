import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_styles.dart';
import '../../../features/expense_tracker/viewmodel/riverpod/expense_tracker_notifier.dart';
import 'custom_date_picker.dart';
import 'global_widgets.dart';

class DateFilter extends ConsumerWidget {
  const DateFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wProvider = ref.watch(dateProvider).value;
    return Row(
      children: [
        Expanded(
            child: ShowDate(
          date: wProvider?.startDateFilter == wProvider?.endDateFilter
              ? "Start Date"
              : wProvider?.startDateFilter?? "Start Date",
          startDate: wProvider?.startDateFilter ?? wProvider?.endDateFilter ?? "Start Date",
          endDate: wProvider?.endDateFilter ?? "End Date",
        )),
        spacerW(8),
        Icon(Icons.remove),
        spacerW(8),
        Expanded(
            child: ShowDate(
          date: wProvider?.endDateFilter ?? "End Date",
          startDate: wProvider?.startDateFilter ?? wProvider?.endDateFilter ?? "Start Date",
          endDate: wProvider?.endDateFilter ?? "End Date",
        )),
      ],
    );
  }
}

// final wDateProvider =ref.watch(dateProvider);

class ShowDate extends StatelessWidget {
  final String date;
  final String startDate;
  final String endDate;

  const ShowDate(
      {super.key,
      required this.date,
      required this.startDate,
      required this.endDate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          height: 45,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: theme.primary,
          ),
          child: InkWell(
            onTap: () {
              showCustomDateRangePicker(
                context,
                dismissible: true,
                minimumDate:
                    DateTime.now().subtract(const Duration(days: 3000)),
                maximumDate: DateTime.now().add(const Duration(days: 0)),
                endDate: parseDate(endDate),
                startDate: parseDate(startDate),
                backgroundColor: theme.surface,
                primaryColor: theme.primary,
                onApplyClick: (start, end) {},
                onCancelClick: () {},
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                spacerW(5),
                Flexible(
                  child: Text(
                    date,
                    style: AppStyles.descriptionPrimary(
                        context: context, color: Colors.white, fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
