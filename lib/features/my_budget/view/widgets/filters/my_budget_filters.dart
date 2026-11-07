import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../shared/view/widgets/global_widgets.dart';
import '../../../utils/budget_filters.dart';
import '../../../view_model/riverpod/my_budget_notifier.dart';


class MyBudgetFilters extends ConsumerStatefulWidget {
  const MyBudgetFilters({super.key});

  @override
  ConsumerState<MyBudgetFilters> createState() => _MyBudgetFiltersState();
}

class _MyBudgetFiltersState extends ConsumerState<MyBudgetFilters> {


  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(myBudgetProvider.notifier);
    final state = ref.watch(myBudgetProvider);
    final double w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: AppStyles.headingPrimary(context: context),
              ),
              spacerW(15),
              InkWell(
                  onTap: notifier.toggleFilter,
                //Method 1:
                // child:Transform.rotate(
                //   angle: isSelected? 3.1416 :0, // 180 degrees in radians
                //   child: Icon(Icons.filter_list),
                // )
                  //Method 2:
                  child: AnimatedRotation(
                    turns: state.isShowFilter ? 0.5 : 0.0, // 0.5 = 180 degrees
                    duration: Duration(milliseconds: 300),
                    child: Icon(Icons.filter_list),
                  )


              ),
            ],
          ),
        ),
        // FILTER CONTENT
        if (state.isShowFilter)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child:  DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children:  SortingFilter.values.map((e) {
                        return reusableRadioButton(
                            w: w,
                            e: e,
                            filter: state.sortingFilter.value,
                          onChanged: (value) {
                            notifier.setSortingFilter(value);
                          },
                        );
                      }).toList(),
                    ),
                    spacerH(4),
                    Row(
                      children: OrderFilter.values.map((e) {
                        return reusableRadioButton(
                            filter: state.orderFilter.value,
                            w: w,
                            e: e,
                            onChanged: (value) {
                              notifier.setOrderFilter(value);
                            });
                      }).toList(),
                    ),
                    spacerH(4),
                    Row(
                      children: StyleFilter.values.map((e) {
                        return reusableRadioButton(
                          filter: state.styleFilter.value,
                          w: w,
                          e: e,
                          onChanged: (value) async {
                            notifier.setStyleFilter(value);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget reusableRadioButton({
    required final double w,
    required final e,
    required final filter,
    required ValueChanged<String> onChanged,
  }) {
    return Flexible(
        child: RadioListTile(
          value: e.value,
          title: Text(
            e.value,
            style: AppStyles.descriptionPrimary(context: context, fontSize: 14),
          ),
          groupValue: filter,
          contentPadding: EdgeInsets.zero,
          // Removes extra padding
          visualDensity: VisualDensity(horizontal: -4.0),
          // Tighten horizontal space
          controlAffinity: ListTileControlAffinity.leading,
          // Radio on the left
          onChanged: (value) => onChanged(value!),
        ));
  }
}
