import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/budgetmodel.dart';
import 'package:ymm/models/transactionfilters.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/pages/budgetviewpage.dart';

class BudgetCard extends StatelessWidget {
  final Budget data;

  BudgetCard({super.key, required this.data});

  final today = DateTime.now();
  late final thisMonday = DateTime(today.year, today.month, today.day).subtract(Duration(days: DateTime.now().weekday -1));
  late final lastDayOfMonth = DateTime(today.year, today.month + 1, 0).day;
  late final month = DateFormat.MMM().format(today);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        TransactionFilters temp = 
          TransactionFilters(
            range: data.weekly ? "week" : "month",
            categories: data.categories
          );
        double total = appState.filteredTransactions(
          temp
        ).fold({"amount": 0.0}, (a, b) => {"amount": a["amount"]! + b.amount})["amount"]!;

        Color? lerped;
        for (Color c in appState.categories.where((c) => data.categories.contains(c.id)).map((c) => c.color)) {
          lerped = Color.lerp(lerped, c, 0.5);
        }
        
        return GestureDetector(
          onTap: () async {
            final bool? wasDeleted = await Navigator.push(
              context,
              MaterialPageRoute<bool>(
                builder: (context) => BudgetViewPage(data: data),
              ),
            );
            if (wasDeleted != null && wasDeleted) {
              appState.removeBudget(data);
            }
          },
          child: Card(
            clipBehavior: Clip.hardEdge,
            elevation: 8.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: lerped ?? Theme.of(context).colorScheme.primary.withAlpha(175),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            shadows: [
                              Shadow(offset: Offset(2.0, 2.0), blurRadius: 10.0, color: Colors.black)
                            ]
                          ),
                        ),
                        Text(
                          "Limit of \$${data.limit.toStringAsFixed(2)}",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            shadows: [
                              Shadow(offset: Offset(2.0, 2.0), blurRadius: 10.0, color: Colors.black)
                            ]
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
                        "\$${total.toStringAsFixed(2)} so far",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        data.weekly ?
                        "${DateFormat.MMMd().format(thisMonday)} - ${DateFormat.MMMd().format(thisMonday.add(Duration(days: 6)))}" :
                        "$month 1 - $month $lastDayOfMonth"
                      ),
                    ],
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    color: Theme.of(context).colorScheme.surfaceBright,
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: constraints.maxWidth * (data.limit == 0.0 ? 0 : ( 1 - (total / data.limit))),
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
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Center(
                    child: Text(
                      "You can spend \$${(
                        (data.limit - total) / (
                          data.weekly ?
                          (today.weekday - DateTime.monday +1) :
                          (lastDayOfMonth - today.day -1)
                        )
                      ).toStringAsFixed(2)}/day",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}