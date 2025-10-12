import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/transactionfilters.dart';
import 'package:ymm/models/state.dart';

class FilterPanel extends StatefulWidget {
  final TransactionFilters filters;

  const FilterPanel(this.filters, {super.key});

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {

  late final TextEditingController _searchController = TextEditingController(text: widget.filters.searchText);
  late DateTime startDate = widget.filters.startDate ?? DateTime.now();
  late DateTime endDate = widget.filters.endDate ?? DateTime.now();
  late List<String> categories = widget.filters.categories;

  void clearFilters() {
    Navigator.pop(context, TransactionFilters.empty());
  }

  void applyFilters() {
    Navigator.pop(context, widget.filters);
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
                  onTapOutside:(event) {
                    widget.filters.setSearch(_searchController.text);
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
                            widget.filters.setStartDate(pickedDate);
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
                            widget.filters.setEndDate(pickedDate);
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
                        if (categories.contains(cat.id)) {
                          categories.remove(cat.id);
                        } else {
                          categories.add(cat.id);
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
                        cat.color.withAlpha(categories.contains(cat.id) ? 50 : 0)
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