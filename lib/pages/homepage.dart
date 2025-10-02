import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// https://pub.dev/packages/fl_chart

class _HomePageState extends State<HomePage> {
  List<Color> gradientColors = [
    Color.fromARGB(255, 220, 235, 211),
    Color.fromARGB(255, 77, 197, 8),
  ];

  bool showAvg = false;

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
                TextButton(onPressed: () {}, child: Icon(Icons.more_vert, size: 28.0,))
              ],
            ),
            Card(
              elevation: 5.0,
              clipBehavior: Clip.hardEdge,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Theme.of(context).colorScheme.primary.withAlpha(150), Theme.of(context).colorScheme.secondary.withAlpha(150)])
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