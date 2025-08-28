import 'package:budgify/core/theme/app_colors.dart';
import '../model/selected_color_model.dart';

List<SelectedColor> selectedColorContents(var rProvider) => [
  SelectedColor(color: AppColors.lightGreen, onTap: () {
    rProvider.state = AppColors.lightGreen;
  }),
  SelectedColor(color: AppColors.redPink, onTap: () {
    rProvider.state = AppColors.redPink;
  }),
  SelectedColor(color: AppColors.lightPurple, onTap: () {
    rProvider.state = AppColors.lightPurple;
  }),
  SelectedColor(color: AppColors.redOrange, onTap: () {
    rProvider.state = AppColors.redOrange;
  }),
  SelectedColor(color: AppColors.violet, onTap: () {
    rProvider.state = AppColors.violet;
  }),
  SelectedColor(color: AppColors.lightGreen2, onTap: () {
    rProvider.state = AppColors.lightGreen2;
  }),
  SelectedColor(color: AppColors.lightBlue, onTap: () {
    rProvider.state = AppColors.lightBlue;
  }),
];
