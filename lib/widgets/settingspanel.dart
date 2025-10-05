import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/pages/categoriespage.dart';

class SettingsPanel extends StatefulWidget {
  const SettingsPanel({super.key});

  @override
  State<SettingsPanel> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  final TextEditingController _amountController = TextEditingController(text: "");
  
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: 400,
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                spacing: 10.0,
                children: [
                  Text(
                    "Settings",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          appState.changeColor(Color.fromARGB(255, 231, 34, 34));
                        },
                        icon: Icon(
                          appState.seedColor == Color.fromARGB(255, 231, 34, 34) ? Icons.check_circle_outline : Icons.circle_rounded,
                          size: 32.0,
                          color: Color.fromARGB(255, 231, 34, 34),
                        )
                      ),
                      IconButton(
                        onPressed: () {
                          appState.changeColor(Color.fromARGB(255, 231, 178, 34));
                        },
                        icon: Icon(
                          appState.seedColor == Color.fromARGB(255, 231, 178, 34) ? Icons.check_circle_outline : Icons.circle_rounded,
                          size: 32.0,
                          color: Color.fromARGB(255, 231, 178, 34),
                        )
                      ),
                      IconButton(
                        onPressed: () {
                          appState.changeColor(Color.fromARGB(255, 228, 231, 34));
                        },
                        icon: Icon(
                          appState.seedColor == Color.fromARGB(255, 228, 231, 34) ? Icons.check_circle_outline : Icons.circle_rounded,
                          size: 32.0,
                          color: Color.fromARGB(255, 228, 231, 34),
                        )
                      ),
                      IconButton(
                        onPressed: () {
                          appState.changeColor(Color.fromARGB(255, 50, 231, 34));
                        },
                        icon: Icon(
                          appState.seedColor == Color.fromARGB(255, 50, 231, 34) ? Icons.check_circle_outline : Icons.circle_rounded,
                          size: 32.0,
                          color: Color.fromARGB(255, 50, 231, 34),
                        )
                      ),
                      IconButton(
                        onPressed: () {
                          appState.changeColor(Color.fromARGB(255, 34, 47, 231));
                        },
                        icon: Icon(
                          appState.seedColor == Color.fromARGB(255, 34, 47, 231) ? Icons.check_circle_outline : Icons.circle_rounded,
                          size: 32.0,
                          color: Color.fromARGB(255, 34, 47, 231),
                        )
                      ),
                      IconButton(
                        onPressed: () {
                          appState.changeColor(Color.fromARGB(255, 103, 34, 231));
                        },
                        icon: Icon(
                          appState.seedColor == Color.fromARGB(255, 103, 34, 231) ? Icons.check_circle_outline : Icons.circle_rounded,
                          size: 32.0,
                          color: Color.fromARGB(255, 103, 34, 231),
                        )
                      ),
                      IconButton(
                        onPressed: () {
                          appState.changeColor(Color.fromARGB(255, 192, 34, 231));
                        },
                        icon: Icon(
                          appState.seedColor == Color.fromARGB(255, 192, 34, 231) ? Icons.check_circle_outline : Icons.circle_rounded,
                          size: 32.0,
                          color: Color.fromARGB(255, 192, 34, 231),
                        )
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const CategoriesPage(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5.0,
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceBright
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Categories",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Icon(Icons.edit)
                            ],
                          ),
                        )
                      ),
                    ),
                  ),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Account Balancer'),
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
                  Text(
                    "* Set the initial balance of you account to ensure\nnet worth and analysis are accurate",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}