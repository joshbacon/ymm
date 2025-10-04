import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/budgetmodel.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/widgets/budgeteditpanel.dart';
import 'package:ymm/widgets/translistitem.dart';

class BudgetViewPage extends StatefulWidget {
  final Budget data;

  const BudgetViewPage({super.key, required this.data});

  @override
  State<BudgetViewPage> createState() => _BudgetViewPageState();
}

class _BudgetViewPageState extends State<BudgetViewPage> {

  late Budget updatedBudget = widget.data.copyWith();

  @override
  Widget build(BuildContext context) {

    final today = DateTime.now();
    final lastDayOfMonth = DateTime(today.year, today.month + 1, 0).day;

    return Consumer<AppState>(
      builder: (context, appState, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(150),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onPrimary)
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                showModalBottomSheet<Budget>(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return BudgetEditPanel(data: updatedBudget, callback: (Budget newBudget) => updatedBudget = newBudget);
                  },
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                updatedBudget.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "\$${updatedBudget.limit.toStringAsFixed(2)}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                updatedBudget.weekly ? "Weekly" : "Monthly",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 15.0),
              Card(
                clipBehavior: Clip.hardEdge,
                color: Theme.of(context).colorScheme.surfaceBright,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: max(
                          constraints.maxWidth *
                            ( 1 - (
                              appState.transactionsByCategory(widget.data.categories).fold({"amount": 0.0}, (a, b) => {"amount": a["amount"]! + b.amount})["amount"] ?? 0
                              / widget.data.limit
                            )),
                          0
                        ),
                      ),
                      child: Container(
                        constraints: BoxConstraints(minHeight: 10.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withAlpha(200),
                          shape: BoxShape.rectangle
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "\$${appState.transactionsByCategory(widget.data.categories).fold({"amount": 0.0}, (a, b) => {"amount": a["amount"]! + b.amount})["amount"]!.toStringAsFixed(2)} spent",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "\$${(
                      ((widget.data.limit - appState.transactionsByCategory(widget.data.categories).fold({"amount": 0.0}, (a, b) => {"amount": a["amount"]! + b.amount})["amount"]!)
                      / (lastDayOfMonth - today.day -1))
                    ).toStringAsFixed(2)}/day remaining",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Divider(),
              Text(
                "Categories",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // TODO: [BUDGET] double check how this looks once there are categories to populate it
                  children: widget.data.categories.map((cat) => Icon(cat.icon as IconData?, color: cat.color)).toList(),
                ),
              ),
              Divider(),
              Text(
                "Transactions",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: appState.transactionsByCategory(widget.data.categories).length,
                itemBuilder: (BuildContext context, int index) {
                  return TransactionListItem(data: appState.transactionsByCategory(widget.data.categories)[index]); 
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}