import 'package:flutter/material.dart';
import 'package:ymm/pages/analysispage.dart';
import 'package:ymm/pages/budgetpage.dart';
import 'package:ymm/pages/homepage.dart';
import 'package:ymm/pages/transactionpage.dart';
import 'package:ymm/widgets/newtransactionpanel.dart';

class YMM extends StatefulWidget {
  const YMM({super.key});

  @override
  State<YMM> createState() => _YMMState();
}

class _YMMState extends State<YMM> {
  int currentPageIndex = 0;

  late var pages = [
    HomePage(),
    TransactionsPage(),
    BudgetPage(),
    AnalysisPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      floatingActionButton: AnimatedScale(
          scale: currentPageIndex != 3 ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return NewTransactionPanel();
                },
              );
            },
            child: Icon(
              Icons.add
            ),
          ),
        ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Transactions',
          ),
          NavigationDestination(
            icon: Icon(Icons.pie_chart_outline),
            label: 'Budgets',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_graph_outlined),
            label: 'Analysis',
          ),
        ],
      ),
    );
  }
}
