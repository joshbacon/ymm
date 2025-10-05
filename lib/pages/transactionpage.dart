import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/widgets/translistitem.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {

  // TODO: [TRANS] add separators to show the date
  // TODO: [TRANS] sort the transactions by date

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
                  return TransactionListItem(data: appState.transactions[index],);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}