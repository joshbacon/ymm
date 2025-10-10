import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/budgetmodel.dart';
import 'package:ymm/models/categorymodel.dart';
import 'package:ymm/models/state.dart';

class BudgetEditPanel extends StatefulWidget {
  final Budget data;
  final Function callback;

  const BudgetEditPanel({super.key, required this.data, required this.callback});

  @override
  State<BudgetEditPanel> createState() => _BudgetEditPanelState();
}

class _BudgetEditPanelState extends State<BudgetEditPanel> {

  late Budget updatedBudget = widget.data.copyWith();

  bool weekly = false;

  late final TextEditingController _nameController = TextEditingController(text: widget.data.name);
  late final TextEditingController _limitController = TextEditingController(text: widget.data.limit.toString());

  @override
  Widget build(BuildContext context) {

    return Consumer<AppState>(
      builder: (context, appState, child) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: 500,
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 75.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
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
                    selected: {appState.budgets.firstWhere((elem) => elem.id == widget.data.id, orElse: () => Budget.empty()).weekly},
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SegmentedButton(
                      multiSelectionEnabled: true,
                      emptySelectionAllowed: true,
                      segments: appState.categories.map((cat) => ButtonSegment<Category>(
                        value: cat,
                        label: Text(cat.title, style: TextStyle(color: cat.color)),
                        icon: Icon(cat.icon.icon, color: cat.color),
                      )).toList(),
                      selected: updatedBudget.categories.map((id) => appState.categories.firstWhere((c) => c.id == id)).toSet(),
                      showSelectedIcon: false,
                      onSelectionChanged: (Set<Category> newCategories) {
                        updatedBudget.setCategories(newCategories.map((c) => c.id).toList());
                        widget.callback(updatedBudget);
                        appState.updateBudget(updatedBudget);
                      },
                    ),
                  ),
                  Divider(),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: [BUDGET] deleting does not work, shows an error onscreen
                      Navigator.pop(context);
                      Navigator.pop(context, true);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delete, color: Theme.of(context).colorScheme.primary.withAlpha(150)),
                        SizedBox(width: 5.0),
                        Text(
                          "Delete",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    )
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