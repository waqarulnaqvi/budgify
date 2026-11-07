import 'package:budgify/features/expense_tracker/utils/expense_type.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_styles.dart';
import '../../../../shared/view/widgets/global_widgets.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown(
      {super.key,
        required this.categories,
        required this.onChanged,
        required this.icon,
        required this.selectedValue,
        this.color,
        this.leadingIcon,
        this.leadingIconSize,
        this.borderColor,
        this.faLeadingIcon
      });

  final List<String> categories;
  final String selectedValue;
  final FaIconData? faLeadingIcon;
  final IconData? icon;
  final void Function(String?)? onChanged;
  final Color? color;
  final IconData? leadingIcon;
  final double? leadingIconSize;
  final Color? borderColor;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final double w = MediaQuery.of(context).size.width;
    final bool isExpense = widget.selectedValue == ExpenseType.expense.value || widget.selectedValue == ExpenseType.tax.value;
    final color = widget.color ?? (isExpense ? Colors.red : Colors.green);
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Container(
            width: w,
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color:widget.borderColor ??color,
                ),
                color: theme.surface,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      spacerW(5),
                      if(widget.faLeadingIcon!=null)
                        FaIcon(widget.faLeadingIcon!, color: color, size: widget.leadingIconSize)
                      else
                      Icon(
                        widget.leadingIcon ??
                            (isExpense
                                ? Icons.arrow_circle_down_outlined
                                : Icons.arrow_circle_up_outlined),
                        color: color,
                        size: widget.leadingIconSize,
                      ),
                      spacerW(10),
                      Flexible(
                        child: Text(widget.selectedValue,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.descriptionPrimary(
                                context: context, color: color)),
                      ),
                      spacerW(10),
                    ],
                  ),
                ),

                Icon(
                  widget.icon,
                )
              ],
            )),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: theme.primary, width: .5),
              color: theme.surface),
        ),
        items: widget.categories
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Text(
              item,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  height: 0,
                  color: theme.onSurface,
                  letterSpacing: 1.5,
                  fontSize: 14,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ))
            .toList(),
        onChanged: widget.onChanged,
      ),
    );
  }
}