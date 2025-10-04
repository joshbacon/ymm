import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/widgets/budgetcard.dart';
import 'package:ymm/widgets/newbudgetcard.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => Padding(
        padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Budgets",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: appState.budgets.length,
                itemBuilder: (BuildContext context, int index) {
                  return BudgetCard(data: appState.budgets[index]);
                }
              ),
              AddBudgetCard(),
            ],
          ),
        ),
      ),
    );
  }
}