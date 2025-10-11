import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/state.dart';

class FilterPanel extends StatefulWidget {
  const FilterPanel({super.key});

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  // TODO [TRANS] implement filter functionality
  // - search by name
  // - date range
  // - category
  // - above/below certain amounts

  late final TextEditingController _searchController = TextEditingController(text: "");
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  List<String> selectedCategories = [];

  void clearFilters() {
    _searchController.text = "";
    startDate = DateTime.now();
    endDate = DateTime.now();
    selectedCategories = [];
    Navigator.pop(context);// probably need a toggle in here to indicate a reset
  }

  void applyFilters() {
    // pass the filter values back and requery the app state for filtered transactions on TranstionPage
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: 500.0,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 65.0),
            child: Column(
              spacing: 10.0,
              children: [
                Text(
                  "Filter Transactions",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: clearFilters,
                      child: Text(
                        "clear",
                        style: Theme.of(context).textTheme.titleSmall
                      ),
                    ),
                    ElevatedButton(
                      onPressed: applyFilters,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(150)
                      ),
                      child: Text(
                        "confirm",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'search'),
                  onEditingComplete: () {
      
                  },
                  onTapOutside:(event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton.tonal(
                        onPressed: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2025),
                            lastDate: DateTime(2050),
                          );
                          if (pickedDate != null && (pickedDate.isBefore(endDate) || pickedDate.isAtSameMomentAs(endDate))) {
                            setState(() {
                              startDate = pickedDate;
                            });
                          }
                        },
                        child: Text(
                          DateFormat.MMMd().format(startDate),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      SizedBox(width: 15.0),
                      Icon(Icons.compare_arrows, color: Theme.of(context).colorScheme.primary),
                      SizedBox(width: 15.0), 
                      FilledButton.tonal(
                        onPressed: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2025),
                            lastDate: DateTime(2050),
                          );
                          if (pickedDate != null && (pickedDate.isAfter(startDate) || pickedDate.isAtSameMomentAs(startDate))) {
                            setState(() {
                              endDate = pickedDate;
                            });
                          }
                        },
                        child: Text(
                          DateFormat.MMMd().format(endDate),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                Wrap(
                  spacing: 5.0,
                  alignment: WrapAlignment.center,
                  children: appState.categories.map((cat) => OutlinedButton(
                    onPressed: () {
                      setState(() {
                        if (selectedCategories.contains(cat.id)) {
                          selectedCategories.remove(cat.id);
                        } else {
                          selectedCategories.add(cat.id);
                        }
                      });
                    },
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        cat.color.withAlpha(selectedCategories.contains(cat.id) ? 50 : 0)
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          cat.icon,
                          color: cat.color,
                          size: 24.0,
                          shadows: [
                            Shadow(
                              offset: Offset(3, 3),
                              blurRadius: 6.0,
                              color: Colors.black
                            )
                          ]
                        ),
                        Text(
                          cat.title,
                          style: TextStyle(
                            color: cat.color,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(3, 3),
                                blurRadius: 6.0,
                                color: Colors.black
                              )
                            ]
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}