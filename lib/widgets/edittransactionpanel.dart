import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/models/categorymodel.dart';
import 'package:ymm/models/transactionmodel.dart';

class EditTransactionPanel extends StatefulWidget {
  final Transaction? data;
  final bool isNew;

  const EditTransactionPanel({super.key, this.data, required this.isNew});

  @override
  State<EditTransactionPanel> createState() => _EditTransactionPanelState();
}

class _EditTransactionPanelState extends State<EditTransactionPanel> {

  late DateTime date = widget.data != null ? widget.data!.date : DateTime.now();
  late final TextEditingController _nameController = TextEditingController(text: widget.data != null ? widget.data!.name : "");
  late final TextEditingController _amountController = TextEditingController(text: widget.data != null ? widget.data!.amount.toStringAsFixed(2): "");
  late String? category = widget.data?.category;

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
                            if (pickedDate != null) date = pickedDate;
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SegmentedButton(
                      emptySelectionAllowed: true,
                      segments: appState.categories.map((cat) => ButtonSegment<Category>(
                        value: cat,
                        label: Text(cat.title, style: TextStyle(color: cat.color)),
                        icon: Icon(cat.icon.icon, color: cat.color),
                      )).toList(),
                      selected: category != null ? {appState.categories.firstWhere((elem) => elem.id == category)} : {},
                      showSelectedIcon: false,
                      onSelectionChanged: (newCategory) {
                        if (newCategory.isNotEmpty) {
                          setState(() {
                            category = newCategory.first.id;
                          });
                        }
                      },
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      if (_nameController.text != "" && _amountController.text != "") {
                        if (widget.isNew) {
                          appState.addTransaction(
                            Transaction(
                              widget.data!.id,
                              _nameController.text,
                              date,
                              double.parse(_amountController.text),
                              category
                            )
                          );
                        } else {
                          appState.updateTransaction(
                            Transaction(
                              widget.data!.id,
                              _nameController.text,
                              date,
                              double.parse(_amountController.text),
                              category
                            )
                          );
                        }
                      }
                      Navigator.pop(context);
                    },
                    child: Text("Confirm"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      if (!widget.isNew) {
                        appState.removeTransaction(widget.data!.id);
                      }
                      appState.sortTransactions();
                      Navigator.pop(context);
                    },
                    child: Text("Delete"),
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