import 'package:budgify/core/theme/app_colors.dart';
import '../model/selected_color_model.dart';

List<SelectedColor> selectedColorContents(var rProvider) => [
  SelectedColor(color: AppColors.redOrange, onTap: () {
    rProvider.setSelectedColor(AppColors.redOrange);
  }),
  SelectedColor(color: AppColors.lightGreen, onTap: () {
    rProvider.setSelectedColor(AppColors.lightGreen);
  }),
  SelectedColor(color: AppColors.redPink, onTap: () {
    rProvider.setSelectedColor(AppColors.redPink);
  }),
  SelectedColor(color: AppColors.lightPurple, onTap: () {
    rProvider.setSelectedColor(AppColors.lightPurple);
  }),
  SelectedColor(color: AppColors.redOrange, onTap: () {
    rProvider.setSelectedColor(AppColors.redOrange);
  }),
  SelectedColor(color: AppColors.violet, onTap: () {
    rProvider.setSelectedColor(AppColors.violet);
  }),
  SelectedColor(color: AppColors.lightGreen2, onTap: () {
    rProvider.setSelectedColor(AppColors.lightGreen2);
  }),
  SelectedColor(color: AppColors.lightBlue, onTap: () {
    rProvider.setSelectedColor(AppColors.lightBlue);
  }),
];
