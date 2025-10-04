import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/budgetmodel.dart';
import 'package:ymm/models/state.dart';

class BudgetEditPanel extends StatefulWidget {
  final Budget data;
  final Function callback;

  const BudgetEditPanel({super.key, required this.data, required this.callback});

  @override
  State<BudgetEditPanel> createState() => _BudgetEditPanelState();
}

class _BudgetEditPanelState extends State<BudgetEditPanel> {

  bool weekly = false;

  late final TextEditingController _nameController = TextEditingController(text: widget.data.name);
  late final TextEditingController _limitController = TextEditingController(text: widget.data.limit.toString());

  late Budget updatedBudget = widget.data.copyWith();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: 400,
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 10.0,
                children: [
                  //name
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Name'),
                    onEditingComplete: () {
                      Budget temp = updatedBudget.copyWith(name: _nameController.text);
                      widget.callback(temp);
                      appState.updateBudget(temp);
                      updatedBudget = temp;
                    },
                    onTapOutside:(event) {
                      Budget temp = updatedBudget.copyWith(name: _nameController.text);
                      widget.callback(temp);
                      appState.updateBudget(temp);
                      updatedBudget = temp;
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                  //limit
                  TextField(
                    controller: _limitController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Limit'),
                    onEditingComplete: () {
                      updatedBudget.setLimit(double.parse(_limitController.text));
                      Budget temp = updatedBudget.copyWith(limit: double.parse(_limitController.text));
                      widget.callback(temp);
                      appState.updateBudget(temp);
                      updatedBudget = temp;
                    },
                    onTapOutside:(event) {
                      Budget temp = updatedBudget.copyWith(limit: double.parse(_limitController.text));
                      widget.callback(temp);
                      appState.updateBudget(temp);
                      updatedBudget = temp;
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    inputFormatters: [
                      TextInputFormatter.withFunction((oldValue, newValue) =>
                        RegExp(r'^[0-9]*\.?[0-9]{0,2}$').hasMatch(newValue.text) ? newValue : oldValue
                      )
                    ],
                  ),
                  //weekly/month
                  SegmentedButton(
                    segments: [
                      ButtonSegment(
                        value: true,
                        label: Text('Weekly'),
                        icon: Icon(Icons.calendar_view_week)
                      ),
                      ButtonSegment(
                        value: false,
                        label: Text('Monthly'),
                        icon: Icon(Icons.calendar_view_month),
                      ),
                    ],
                    selected: {appState.budgets.firstWhere((elem) => elem.id == widget.data.id).weekly},
                    showSelectedIcon: false,
                    onSelectionChanged: (newSelection) {
                      updatedBudget.setWeekly(newSelection.first);
                      widget.callback(updatedBudget);
                      appState.updateBudget(updatedBudget);
                      setState(() {
                        weekly = newSelection.first;
                      });
                    },
                  ),
                  // TODO: [BUDGET] add category inclusion selection
                  // TODO: [BUDGET] add a delete button (with a confirmation popup)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}