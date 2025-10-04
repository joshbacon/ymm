import 'package:flutter/material.dart';
import 'package:ymm/models/state.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction data;

  const TransactionListItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: data.category.icon,
      title: Text(data.name),
      subtitle: Text(data.subcategory.id != -1 ? data.subcategory.title : ""),
      trailing: Text("\$${data.amount.toString()}"),
    );
  }
}