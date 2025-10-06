import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:ymm/models/budgetmodel.dart';
import 'package:ymm/models/categorymodel.dart';
import 'package:ymm/models/transactionmodel.dart';

class AppState extends ChangeNotifier {

  /// Internal, private state of the cart.
  final List<Transaction> _transactions = [
    Transaction(1, "McDonalds", DateTime.now(), 11.93, Category("1", "Food", Icon(Icons.local_grocery_store), const Color.fromARGB(255, 52, 204, 31)), null),
    Transaction(2, "Sobeys", DateTime.now(), 43.87, Category("1", "Food", Icon(Icons.local_grocery_store), const Color.fromARGB(255, 52, 204, 31)), Subcategory()),
  ];
  final List<Budget> _budgets = [];
  final List<Category> _categories = [
    Category("1", "Food", Icon(Icons.local_grocery_store), const Color.fromARGB(255, 52, 204, 31)),
    Category("2", "Gas", Icon(Icons.local_gas_station), const Color.fromARGB(255, 31, 92, 204))
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

  void removeTransaction(Transaction item) {
    _transactions.removeWhere((transaction) => transaction.id == item.id);
    notifyListeners();
  }

  void updateTransaction(Transaction item) {
    _transactions[_transactions.indexWhere((element) => element.id == item.id)] = item;
    notifyListeners();
  }

  List<Transaction> transactionsByCategory(List<Category> categories) {
    return _transactions.where((Transaction elem) => categories.map((Category cat) => cat.id).contains(elem.category?.id)).toList();
  }

  // TODO: [STATE] need a way to filter for dates as weel (need weekly and monthly for budgets, but also 3/6/12/YTD months for the analysis page)
  

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




class Subcategory {
  int id = -1;
  String title = "Groceries";
  int parent = -1;
  Icon icon = Icon(Icons.block_flipped);
  Color color = Color.fromARGB(255, 54, 54, 54);
}

class Settings {
  Color themeColor = Color.fromARGB(255, 192, 34, 231);
}
