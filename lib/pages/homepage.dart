import 'package:flutter/material.dart';
import 'package:ymm/widgets/settingspanel.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// TODO [HOME] add chart
// - net worth graph from the last month (today to same day of last month inclusive)
// - heat map from the last month (today to same day of last month inclusive)
// https://pub.dev/packages/fl_chart

// TODO [HOME] add visibility toggle to networth (default to hidden)
// - replace dollar characters with * (one to one so you can see the number of digits)
// - hide the chart axis labels

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 50, 15, 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Home",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return SettingsPanel();
                      },
                    );
                  },
                  child: Icon(Icons.more_vert, size: 28.0,)
                ),
              ],
            ),
            Card(
              elevation: 5.0,
              clipBehavior: Clip.hardEdge,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withAlpha(150),
                      Theme.of(context).colorScheme.secondary.withAlpha(150)
                    ]
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Column(
                    children: [
                      Text(
                        "Net Worth",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary
                        ),
                      ),
                      Text(
                        "\$24,000 CAD",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary
                        ),
                      ),
                      Text(
                        "167 Transactions",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}