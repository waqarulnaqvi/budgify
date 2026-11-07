import 'package:budgify/core/constants/static_assets.dart';
import '../model/onboarding_model.dart';

List<OnboardingModel> onboardingContentsList = [
  OnboardingModel(
    image: StaticAssets.onboard1,
    title: 'Track Expenses &\nInvestments Easily',
    description:
    'Add expenses, investments, and tax entries in seconds.\n'
        'Filter by category or date and stay in full control\n'
        'of your daily financial flow.',
  ),
  OnboardingModel(
    image: StaticAssets.onboard2,
    title: 'Manage EMI & Loans\nEffortlessly',
    description:
    'Add installment amount, notes, and due date.\n'
        'Get quick reminders so you never miss a\n'
        'payment again.',
  ),
  OnboardingModel(
    image: StaticAssets.onboard3,
    title: 'Organize Your Budget\nLike a Pro',
    description:
    'Create monthly budgets with notes and details.\n'
        'Sort by date or title and set fast alerts to\n'
        'avoid unnecessary spending.',
  ),
  OnboardingModel(
    image: StaticAssets.onboard4,
    title: 'View Insights & Smart\nFinancial Summary',
    description:
    'Analyze income, expenses, tax, and investments.\n'
        'Understand trends with clean charts and stay\n'
        'ahead with informed decisions.',
  ),
];
