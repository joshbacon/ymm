import 'package:flutter/material.dart';
import 'package:ymm/pages/analysispage.dart';
import 'package:ymm/pages/budgetpage.dart';
import 'package:ymm/pages/homepage.dart';
import 'package:ymm/pages/transactionpage.dart';


// https://docs.flutter.dev/ui/widgets/material

void main() {
  runApp(const YMM());
}

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
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 50, 231, 34),
          brightness: Brightness.dark
        ),
        fontFamily: "dubai",
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: "dubai",
            decoration: TextDecoration.none,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontFamily: "dubai",
            decoration: TextDecoration.none,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontFamily: "dubai",
            decoration: TextDecoration.none,
            fontSize: 14,
          ),
        ),
      ),
      home: Scaffold(
        body: pages[currentPageIndex],
        floatingActionButton: AnimatedScale(
            scale: currentPageIndex != 3 ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: FloatingActionButton(
              onPressed: () {},
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
          // indicatorColor: Colors.amber,
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
      ),
    );
  }
}
