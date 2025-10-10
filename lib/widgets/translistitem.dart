import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/models/transactionmodel.dart';
import 'package:ymm/widgets/edittransactionpanel.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction data;

  const TransactionListItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => GestureDetector(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return EditTransactionPanel(data: data, isNew: false);
            },
          );
        },
        child: ListTile(
          tileColor: Theme.of(context).colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          leading: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.square_rounded,
                color: appState.getCategory(data.category).color.withAlpha(50),
                size: 52.0,
              ),
              Icon(
                appState.getCategory(data.category).icon.icon,
                color: appState.getCategory(data.category).color,
                size: 28.0,
              ),
            ],
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: data.category == null ? 13.0 : 0.0),
            child: Text(
              data.name,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          subtitle: data.category != null ?
            Text(
              appState.getCategory(data.category).title,
            ) : null,
          trailing: Text(
            "\$${data.amount.toStringAsFixed(2)}",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}