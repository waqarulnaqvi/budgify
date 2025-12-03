import 'package:budgify/shared/view/widgets/reusable_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/routes/paths.dart';

class EmiAndLoan extends ConsumerWidget {
  const EmiAndLoan({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
     appBar: ReusableAppBar(text: "EMI & Loan",isCenterText: true,),
      body: Center(
        child: Text(
          'No Installment found',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.pushNamed(context, Paths.installmentDetailsPage);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
