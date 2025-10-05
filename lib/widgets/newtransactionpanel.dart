import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/models/categorymodel.dart';
import 'package:ymm/models/transactionmodel.dart';

class NewTransactionPanel extends StatefulWidget {
  const NewTransactionPanel({super.key});

  @override
  State<NewTransactionPanel> createState() => _NewTransactionPanelState();
}

class _NewTransactionPanelState extends State<NewTransactionPanel> {

  DateTime date = DateTime.now();
  final TextEditingController _nameController = TextEditingController(text: "");
  final TextEditingController _amountController = TextEditingController(text: "");
  Category category = Category.empty();

  @override
  Widget build(BuildContext context) {

    return Consumer<AppState>(
      builder: (context, appState, child) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: 500,
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.0, 18.0, 15.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                spacing: 10.0,
                children: [
                  Text(
                    "New Transaction",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.MMMd().format(date),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        icon: Icon(Icons.calendar_month),
                        onPressed: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2025),
                            lastDate: DateTime(2050),
                          );
        
                          setState(() {
                            date = pickedDate ?? date;
                          });
                        },
                      )
                    ],
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Title'),
                    onEditingComplete: () {
        
                    },
                    onTapOutside:(event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Amount'),
                    onEditingComplete: () {
                      
                    },
                    onTapOutside:(event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    inputFormatters: [
                      TextInputFormatter.withFunction((oldValue, newValue) =>
                        RegExp(r'^[0-9]*\.?[0-9]{0,2}$').hasMatch(newValue.text) ? newValue : oldValue
                      )
                    ],
                  ),
                  SegmentedButton(
                    emptySelectionAllowed: true,
                    segments: appState.categories.map((cat) => ButtonSegment<Category>(
                      value: cat,
                      label: Text(cat.title, style: TextStyle(color: cat.color)),
                      icon: Icon(cat.icon.icon, color: cat.color),
                    )).toList(),
                    selected: appState.categories.where((elem) => elem.id == category.id).isNotEmpty ? {appState.categories.firstWhere((elem) => elem.id == category.id)} : {},
                    showSelectedIcon: false,
                    onSelectionChanged: (newCategory) {
                      setState(() {
                        category = newCategory.first!;
                      });
                    },
                  ),
                  FilledButton(
                    onPressed: () {
                      appState.addTransaction(
                        Transaction(
                          appState.transactions.last.id + 1,
                          _nameController.text,
                          date,
                          double.parse(_amountController.text),
                          category,
                          null
                        )
                      );
                      Navigator.pop(context);
                    },
                    child: Text("Add Transaction"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}