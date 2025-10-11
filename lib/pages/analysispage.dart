import 'package:flutter/material.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {

  // TODO [ANALYSIS]
  // make everything below dynamic

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
            ),
            Column(
              children: [
                Text(
                  "\$100.00 (33%)",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "over budget",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: Column(
                      children: [
                        Text("Total Spent"),
                        Text("\$400.00"),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: Column(
                      children: [
                        Text("Budgeted Amount"),
                        Text("\$300.00"),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Text(
              "You can spend",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              "\$127.43 /day",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "before you run out.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              "With average spending, you can last",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              "67 days",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text("radar chart for budgets"),
            Text("show line chart for budgets"),
            Text("show pie chart for budgets"),
            Text("show dollar and percent over/under budget for each one"),
          ],
        ),
      ),
    );
  }
}