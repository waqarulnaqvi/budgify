import 'package:budgify/features/my_budget/view_model/riverpod/my_budget_notifier.dart';
import 'package:budgify/shared/view/widgets/global_widgets.dart';
import 'package:budgify/shared/view/widgets/reusable_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/routes/paths.dart';
import '../../../../shared/view/widgets/containers/dual_folder_cortner_container.dart';
import '../../model/my_budget_model.dart';
import 'package:budgify/features/my_budget/view/widgets/filters/my_budget_filters.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../utils/budget_filters.dart';

class MyBudgetPage extends ConsumerStatefulWidget {
  const MyBudgetPage({super.key});

  @override
  ConsumerState<MyBudgetPage> createState() => _MyBudgetPageState();
}

class _MyBudgetPageState extends ConsumerState<MyBudgetPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(myBudgetProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myBudgetProvider);
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.surface,
      appBar: ReusableAppBar(text: 'My Budget'),
      body: Stack(
        children: [
          Positioned(child: Container(height: 200, color: theme.primary)),

          Positioned(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(color: theme.surface),
                child: Column(
                  children: [
                    spacerH(),
                    MyBudgetFilters(),
                    spacerH(10),
                    Expanded(
                      child: Center(
                        child:
                            state.isLoading
                                ? CircularProgressIndicator(
                                  color: theme.primary,
                                )
                                : state.myBudgetList.isEmpty
                                ? Text(
                                  'No Budget Found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: theme.onSurface,
                                  ),
                                )
                                : state.styleFilter.value ==
                                    StyleFilter.classic.value
                                ? _buildClassicList(state)
                                : _buildGridList(state),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openBudgetPage(),
        backgroundColor: theme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  /// CLASSIC LIST VIEW
  Widget _buildClassicList(MyBudgetState state) {
    return ListView.builder(
      itemCount: state.myBudgetList.length,
      padding: const EdgeInsets.only(top: 10, bottom: 80),
      itemBuilder: (context, index) {
        final budget = state.myBudgetList[index];
        return Padding(
          padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
          child: DualFoldedCornerContainer(
            id: budget.id!,
            title: budget.title,
            description: budget.description,
            date: budget.date,
            color: budget.color,
            onTap: () => _openBudgetPage(budget: budget),
          ),
        );
      },
    );
  }

  /// MASONRY GRID VIEW
  Widget _buildGridList(MyBudgetState state) {
    return MasonryGridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: state.myBudgetList.length,
      mainAxisSpacing: 10,
      crossAxisSpacing: 20,
      itemBuilder: (context, i) {
        final budget = state.myBudgetList[i];
        final bool isSmall = (i == 0 || i == state.myBudgetList.length - 1);


        return Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: DualFoldedCornerContainer(
            height: isSmall ? 155 : 200,
            specialHeight: !isSmall,
            hideDecoration: true,
            title: budget.title,
            description: budget.description,
            date: budget.date,
            color: budget.color,
            onTap: () => _openBudgetPage(budget: budget),
            id: budget.id!,
          ),
        );
      },
    );
  }

  /// NAVIGATION HANDLER
  void _openBudgetPage({MyBudgetModel? budget}) {
    Navigator.pushNamed(context, Paths.budgetManagementPage, arguments: budget);
  }
}
