import '../../../../core/constants/constants.dart';
import '../../../../core/constants/static_assets.dart';
import '../../../../core/theme/app_gradients.dart';
import '../model/more_apps_model.dart';

List<MoreAppsModel> moreAppsContentsList=[
  MoreAppsModel(
      title: AppConstants.brainBooster,
      image: StaticAssets.brainBoosterIcon,
      description: AppConstants.brainBoosterDescription,
      colors: AppGradients.blueMyAppGradient,
      url: AppConstants.brainBoosterUrl
  ),
  MoreAppsModel(
      title: AppConstants.classicWingedBird,
      image: StaticAssets.classicWingedBirdIcon,
      description: AppConstants.classicWingedBirdDescription,
      colors: AppGradients.blueMyAppGradient,
      url: AppConstants.classicWingedBirdUrl
  ),
  MoreAppsModel(
      title: AppConstants.hindiShayariHub,
      image: StaticAssets.hindiShayariHubIcon,
      description: AppConstants.hindiShayariHubDescription,
      colors: AppGradients.purpleMyAppGradient,
      url: AppConstants.hindiShayariHubUrl
  ),
  MoreAppsModel(
      title: AppConstants.mazedarHindiJokes,
      image: StaticAssets.mazedarHindiJokesIcon,
      description: AppConstants.mazedarHindiJokesDescription,
      colors: AppGradients.orangeMyAppGradient,
      url: AppConstants.mazedarHindiJokesUrl
  ),
  MoreAppsModel(
      title: AppConstants.noteMaster,
      image: StaticAssets.noteMasterIcon,
      description: AppConstants.noteMasterDescription,
      colors: AppGradients.orangeMyAppGradient,
      url: AppConstants.noteMasterUrl
  ),
  MoreAppsModel(
      title: AppConstants.budgetFlow,
      image: StaticAssets.budgetFlowIcon,
      description: AppConstants.budgetFlowDescription,
      colors: AppGradients.skyBlueMyAppGradient,
      url: AppConstants.budgetFlowUrl
  ),
];