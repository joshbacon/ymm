import 'package:flutter/material.dart';
import 'package:ymm/models/transactionmodel.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction data;

  const TransactionListItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      leading: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.square_rounded,
            color: data.category?.color.withAlpha(50),
            size: 52.0,
          ),
          Icon(
            data.category?.icon.icon,
            color: data.category?.color,
            size: 28.0,
          ),
        ],
      ),
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: data.subcategory == null ? 13.0 : 0.0),
        child: Text(
          data.name,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      subtitle: data.subcategory != null ?
        Text(
          data.subcategory?.title ?? "",
        ) : null,
      trailing: Text(
        "\$${data.amount.toStringAsFixed(2)}",
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}