import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/budgetmodel.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/pages/budgetviewpage.dart';

class BudgetCard extends StatelessWidget {
  final Budget data;

  BudgetCard({super.key, required this.data});

  final today = DateTime.now();
  late final lastDayOfMonth = DateTime(today.year, today.month + 1, 0).day;
  late final month = DateFormat.MMM().format(today);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => BudgetViewPage(data: data),
            ),
          );
        },
        child: Card(
          clipBehavior: Clip.hardEdge,
          elevation: 8.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withAlpha(150),
                      Theme.of(context).colorScheme.secondary.withAlpha(150)
                    ]
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary
                        ),
                      ),
                      Text(
                        "Limit of \$${data.limit.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${appState.transactionsByCategory(data.categories).fold({"amount": 0.0}, (a, b) => {"amount": a["amount"]! + b.amount})["amount"]!.toStringAsFixed(2)} so far",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "$month 1 - $month $lastDayOfMonth"
                    ),
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: Center(
                  child: Text(
                    "You can spend \$${(
                        ((data.limit - appState.transactionsByCategory(data.categories).fold({"amount": 0.0}, (a, b) => {"amount": a["amount"]! + b.amount})["amount"]!)
                        / (lastDayOfMonth - today.day -1))
                      ).toStringAsFixed(2)}/day",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}