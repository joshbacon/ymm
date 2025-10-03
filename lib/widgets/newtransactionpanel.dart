import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/state.dart';

class NewTransactionPanel extends StatefulWidget {
  const NewTransactionPanel({super.key});

  @override
  State<NewTransactionPanel> createState() => _NewTransactionPanelState();
}

class _NewTransactionPanelState extends State<NewTransactionPanel> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => SizedBox(
        height: 800,
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10.0,
              children: [
                Text(
                  "New Transaction",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}