import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/budgetmodel.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/models/transactionmodel.dart';
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
    final lastDayOfMonth = DateTime(today.year, today.month + 1, 0);
    final thisMonday = DateTime(today.year, today.month, today.day).subtract(Duration(days: DateTime.now().weekday -1));

    return Consumer<AppState>(
      builder: (context, appState, child) {
        // TODO: [BUDGET] also account for if it's weekly or monthly when querying transactions
        List<Transaction> filteredTransactions = appState.transactionsByCategory(updatedBudget.categories);
        double total = filteredTransactions.fold({"amount": 0.0}, (a, b) => {"amount": a["amount"]! + b.amount})["amount"]!;
        
        return Scaffold(
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
                    context: context,
                    isScrollControlled: true,
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
                Text(
                  updatedBudget.weekly ?
                  "${DateFormat.MMMd().format(thisMonday)} - ${DateFormat.MMMd().format(thisMonday.add(Duration(days: 6)))}" :
                  "${DateFormat.MMMd().format(DateTime(today.year, today.month, 1))} - ${DateFormat.MMMd().format(lastDayOfMonth)}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 15.0),
                Card(
                  clipBehavior: Clip.hardEdge,
                  color: Theme.of(context).colorScheme.surfaceBright,
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: constraints.maxWidth * (updatedBudget.limit == 0.0 ? 0 : ( 1 - (total / updatedBudget.limit))),
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
                      "\$${total.toStringAsFixed(2)} spent",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "\$${(
                        (updatedBudget.limit - total) / (
                          updatedBudget.weekly ?
                          (today.weekday - DateTime.monday +1) :
                          (lastDayOfMonth.day - today.day -1)
                        )
                      ).toStringAsFixed(2)}/day remaining",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Divider(),
                Visibility(
                  visible: updatedBudget.categories.isNotEmpty,
                  child: Text(
                    "Categories",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Visibility(
                  visible: updatedBudget.categories.isNotEmpty,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: updatedBudget.categories.map((cat) => Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.square_rounded,
                            color: cat.color.withAlpha(50),
                            size: 52.0,
                          ),
                          Icon(
                            cat.icon.icon,
                            color: cat.color,
                            size: 28.0,
                          ),
                        ],
                      ),).toList(),
                    ),
                  ),
                ),
                Visibility(
                  visible: updatedBudget.categories.isNotEmpty,
                  child: Divider()
                ),
                Visibility(
                  visible: filteredTransactions.isNotEmpty,
                  child: Text(
                    "Transactions",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Visibility(
                  visible: filteredTransactions.isNotEmpty,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 3.0),
                    shrinkWrap: true,
                    itemCount: filteredTransactions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TransactionListItem(data: filteredTransactions[index]); 
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}