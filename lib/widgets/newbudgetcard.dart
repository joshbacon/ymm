import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/budgetmodel.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/pages/budgetviewpage.dart';

class AddBudgetCard extends StatelessWidget {
  const AddBudgetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => GestureDetector(
        onTap: () async {
          Budget newBudget = Budget.empty();
          appState.addBudget(newBudget);
          final bool? wasDeleted = await Navigator.push(
            context,
            MaterialPageRoute<bool>(
              builder: (context) => BudgetViewPage(data: newBudget),
            ),
          );
          if (wasDeleted != null && wasDeleted) {
            appState.removeBudget(newBudget);
          }
        },
        child: Card(
          clipBehavior: Clip.hardEdge,
          elevation: 8.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}