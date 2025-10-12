import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/transactionfilters.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/models/transactionmodel.dart';
import 'package:ymm/widgets/filterpanel.dart';
import 'package:ymm/widgets/translistitem.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {

  TransactionFilters filters = TransactionFilters.empty();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {

        List<Transaction> filteredTransactions = appState.filteredTransactions(filters);

        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Transactions",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet<TransactionFilters>(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: false,
                          builder: (BuildContext context) {
                            return FilterPanel(filters);
                          },
                        ).then((newFilters) {
                          if (newFilters != null) {
                            setState(() {
                              filters = newFilters;
                            });
                          }
                        });
                      },
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    )
                  ],
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(height: 3.0),
                  itemCount: filteredTransactions.length,
                  itemBuilder: (BuildContext context, int index) {

                    if (index == 0 || 
                      filteredTransactions[index].date.year != filteredTransactions[index-1].date.year ||
                      filteredTransactions[index].date.month != filteredTransactions[index-1].date.month ||
                      filteredTransactions[index].date.day != filteredTransactions[index-1].date.day
                    ) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.0),
                          Text(
                            DateFormat.MMMd().format(filteredTransactions[index].date),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 3.0),
                          TransactionListItem(data: filteredTransactions[index])
                        ],
                      );
                    }
                    return TransactionListItem(data: filteredTransactions[index]);
                  }
                ),
                SizedBox(height: 60.0),
              ],
            ),
          ),
        );
      }
    );
  }
}