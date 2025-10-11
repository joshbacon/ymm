import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/widgets/translistitem.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => Padding(
        padding: const EdgeInsets.fromLTRB(15, 50, 15, 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Transactions",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 3.0),
                shrinkWrap: true,
                itemCount: appState.transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0 || 
                    appState.transactions[index].date.year != appState.transactions[index-1].date.year ||
                    appState.transactions[index].date.month != appState.transactions[index-1].date.month ||
                    appState.transactions[index].date.day != appState.transactions[index-1].date.day
                  ) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.MMMd().format(appState.transactions[index].date),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 5.0),
                        TransactionListItem(data: appState.transactions[index])
                      ],
                    );
                  }
                  return TransactionListItem(data: appState.transactions[index]);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}