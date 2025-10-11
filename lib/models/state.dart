import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:ymm/models/budgetmodel.dart';
import 'package:ymm/models/categorymodel.dart';
import 'package:ymm/models/transactionmodel.dart';

// TODO [STATE] save to local storage on change
// TODO [STATE] read from local storage on app load

class AppState extends ChangeNotifier {

  /// Internal, private state of the cart.
  final List<Transaction> _transactions = [
    Transaction("3", "Sobeys", DateTime.now(), 43.87, "71"),
    Transaction("2", "Petro Can", DateTime.now().subtract(Duration(days: 8)), 83.72, "41"),
    Transaction("1", "McDonalds", DateTime.now().subtract(Duration(days: 12)), 11.93, "71"),
  ];
  final List<Budget> _budgets = [
    Budget("1", "Food", 300.0, ["71"], false)
  ];
  final List<Category> _categories = [
    Category("71", "Groceries", Icons.local_grocery_store, const Color.fromARGB(255, 52, 204, 31)),
    Category("41", "Gas", Icons.local_gas_station, const Color.fromARGB(255, 52, 204, 31)),
    Category("2", "Takeout", Icons.local_gas_station, const Color.fromARGB(255, 31, 92, 204)),
    Category("11", "Liquor", Icons.local_grocery_store, const Color.fromARGB(255, 194, 43, 88)),
    Category("21", "Insurance", Icons.local_gas_station, const Color.fromARGB(255, 204, 31, 190)),
    Category("12", "Clothes", Icons.local_grocery_store, const Color.fromARGB(255, 177, 174, 14)),
    Category("22", "Income", Icons.local_gas_station, const Color.fromARGB(255, 204, 164, 31)),
    Category("13", "Hobbies", Icons.local_grocery_store, const Color.fromARGB(255, 52, 204, 31)),
    Category("24", "Rent", Icons.local_gas_station, const Color.fromARGB(255, 31, 92, 204)),
    Category("15", "Phone", Icons.local_grocery_store, const Color.fromARGB(255, 52, 204, 31)),
    Category("26", "School", Icons.local_gas_station, const Color.fromARGB(255, 31, 92, 204)),
    Category("17", "Spending", Icons.local_grocery_store, const Color.fromARGB(255, 52, 204, 31)),
    Category("28", "Dividend", Icons.local_gas_station, const Color.fromARGB(255, 31, 92, 204)),
    Category("20", "Car Maintenance", Icons.local_gas_station, const Color.fromARGB(255, 31, 92, 204))
  ];

  Color _seedColor = Color.fromARGB(255, 192, 34, 231);

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Transaction> get transactions => UnmodifiableListView(_transactions);
  UnmodifiableListView<Budget> get budgets => UnmodifiableListView(_budgets);
  UnmodifiableListView<Category> get categories => UnmodifiableListView(_categories);
  Color get seedColor => _seedColor;

  /// Transaction functions
  void addTransaction(Transaction item) {
    _transactions.add(item);
    notifyListeners();
  }

  void removeTransaction(String id) {
    _transactions.removeWhere((transaction) => transaction.id == id);
    notifyListeners();
  }

  void updateTransaction(Transaction item) {
    _transactions[_transactions.indexWhere((element) => element.id == item.id)] = item;
    notifyListeners();
  }

  void sortTransactions() {
    _transactions.sort((a, b) => b.date.compareTo(a.date));
  }

  List<Transaction> filteredTransactions({String? range, List<String>? categories}) {
    List<Transaction> temp = [..._transactions];

    if (range != null) {
      DateTime startDate = DateTime.now();
      if (range == "week") {
        temp = temp.where((t) => t.date.isAfter(DateTime(startDate.year, startDate.month, startDate.weekday - DateTime.monday +1))).toList();
      } else if (range == "month") {
        temp = temp.where((t) => t.date.isAfter(DateTime(startDate.year, startDate.month, 1))).toList();
      } else if (range == "3m") {
        temp = temp.where((t) => t.date.isAfter(DateTime(startDate.year, startDate.month-3, startDate.day))).toList();
      } else if (range == "6m") {
        temp = temp.where((t) => t.date.isAfter(DateTime(startDate.year, startDate.month-6, startDate.day))).toList();
      } else if (range == "12m") {
        temp = temp.where((t) => t.date.isAfter(DateTime(startDate.year, startDate.month-12, startDate.day))).toList();
      } else if (range == "YTD") {
        temp = temp.where((t) => t.date.isAfter(DateTime(startDate.year, 1, 1))).toList();
      }
    }

    if (categories != null) {
      temp = temp.where((Transaction elem) => categories.contains(elem.category)).toList();
    }

    return temp;
  }
  

  /// Budget functions
  Budget getBudget(String id) {
    return _budgets.firstWhere((elem) => elem.id == id);
  }

  void addBudget(Budget item) {
    _budgets.add(item);
    notifyListeners();
  }
  
  void removeBudget(Budget item) {
    _budgets.removeWhere((budget) => budget.id == item.id);
    notifyListeners();
  }

  void updateBudget(Budget item) {
    _budgets[_budgets.indexWhere((element) => element.id == item.id)] = item;
    notifyListeners();
  }

  /// Category functions
  Category getCategory(String? id) {
    return _categories.firstWhere((elem) => elem.id == id);
  }

  void addCategory(Category item) {
    _categories.add(item);
    notifyListeners();
  }
  
  void removeCategory(Category item) {
    _categories.removeWhere((cat) => cat.id == item.id);
    notifyListeners();
  }

  void updateCategory(Category item) {
    _categories[_categories.indexWhere((element) => element.id == item.id)] = item;
    notifyListeners();
  }

  /// Change the color scheme
  void changeColor(Color newColor) {
    _seedColor = newColor;
    notifyListeners();
  }
}

class Settings {
  Color themeColor = Color.fromARGB(255, 192, 34, 231);
}
