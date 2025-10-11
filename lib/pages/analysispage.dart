import 'package:flutter/material.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {

  // TODO [ANALYSIS]
  // - show total spent vs sum of budget amounts in range
  // - show total and average difference to budget as dollar amount and percentage
  // - show how long you can last with no income based on daily average spending history
  // - heat map
  // - radar chart for budgets

  String selectedRange = "3m";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 50, 15, 10),
      child: SingleChildScrollView(
        child: Column(
          spacing: 8.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Analysis",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SegmentedButton(
              multiSelectionEnabled: false,
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                  value: "3m",
                  label: Text("3m"),
                ),
                ButtonSegment(
                  value: "6m",
                  label: Text("6m"),
                ),
                ButtonSegment(
                  value: "12m",
                  label: Text("12m"),
                ),
                ButtonSegment(
                  value: "YTD",
                  label: Text("YTD"),
                ),
              ],
              selected: {selectedRange},
              onSelectionChanged: (newSelection) {
                setState(() {
                  selectedRange = newSelection.first.toString();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}