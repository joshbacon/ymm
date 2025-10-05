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
  late final thisMonday = DateTime(today.year, today.month, today.day).subtract(Duration(days: DateTime.now().weekday -1));
  late final lastDayOfMonth = DateTime(today.year, today.month + 1, 0).day;
  late final month = DateFormat.MMM().format(today);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        double total = appState.transactionsByCategory(data.categories).fold({"amount": 0.0}, (a, b) => {"amount": a["amount"]! + b.amount})["amount"]!;
        
        return GestureDetector(
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
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, data.categories.isNotEmpty ? 0.0 : 8.0),
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
                // Do we want this?????
                // Visibility(
                //   visible: data.categories.isNotEmpty,
                //   child: SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Row(
                //       children: data.categories.map((cat) => Stack(
                //         alignment: Alignment.center,
                //         children: [
                //           Icon(
                //             Icons.square_rounded,
                //             color: cat.color.withAlpha(50),
                //             size: 52.0,
                //           ),
                //           Icon(
                //             cat.icon.icon,
                //             color: cat.color,
                //             size: 28.0,
                //           ),
                //         ],
                //       ),).toList(),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}