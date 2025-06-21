import 'package:budgify/core/theme/app_gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../shared/view/widgets/global_widgets.dart';
import '../../../utils/filter_type.dart';
import '../../../viewmodel/riverpod/filter_provider.dart';

class FilterButton extends ConsumerWidget {

  const FilterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(filterProvider);
    final theme = Theme.of(context).colorScheme;

    // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent, // Disable splash effect
        highlightColor: Colors.transparent, // Disable highlight effect
      ),
      child: PopupMenuButton<String>(
        onSelected: (choice) {
          ref.read(filterProvider.notifier).state = choice;
        },
        itemBuilder: (BuildContext context) {
          return FilterType.values.map((e) => e.stringValue).toList().map((String choice) {
            final isSelected = choice == selectedItem;
            return PopupMenuItem<String>(
              value: choice,
              // onTap: () => onSelected(choice),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: isSelected
                      ? LinearGradient(
                          colors: AppGradients.skyBlueMyAppGradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,

                ),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Text(choice,style: AppStyles.headingPrimary(
                  context: context,
                  fontSize: 14,
                  fontWeight: isSelected? FontWeight.bold : FontWeight.w500,
                  color: isSelected? Colors.white: theme.onSurface,
                ),),
              ),
            );
          }).toList();
        },
        offset: const Offset(0, 50),
        color: theme.surface,
        // enabled: false, // Disable the button's own tap handling
        // enableFeedback: false, // Disable haptic feedback on selection
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color:  theme.onSecondary ,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
            height: 45,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.onSurface, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.filter_list,
                    color: theme.onSurface, size: 20),
                spacerW(5),
                Flexible(
                  child: Text("Filter",
                    style: AppStyles.headingPrimary(
                      context: context,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),overflow: TextOverflow.ellipsis,),
                ),
              ],
            )),
      ),
    );
  }
}


