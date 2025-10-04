import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:ymm/models/budgetmodel.dart';

class AppState extends ChangeNotifier {

  /// Internal, private state of the cart.
  final List<Transaction> _transactions = [
    Transaction()
  ];
  final List<Budget> _budgets = [
    Budget("67", "Food", 300.0, [], false)
  ];
  Color _seedColor = Color.fromARGB(255, 192, 34, 231);

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Transaction> get transactions => UnmodifiableListView(_transactions);
  UnmodifiableListView<Budget> get budgets => UnmodifiableListView(_budgets);
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
    int index = _transactions.indexWhere((element) => element.id == item.id);
    _transactions.replaceRange(index, index, [item]);
    notifyListeners();
  }

  List<Transaction> transactionsByCategory(List<Category> categories) {
    return _transactions.where((Transaction elem) => categories.map((Category cat) => cat.id).contains(elem.category.id)).toList();
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
    int index = _budgets.indexWhere((element) => element.id == item.id);
    _budgets.replaceRange(index, index+1, [item]);
    notifyListeners();
  }

  /// Change the color scheme
  void changeColor(Color newColor) {
    _seedColor = newColor;
    notifyListeners();
  }
}


class Transaction {
  int id = -1;
  String name = "";
  DateTime date = DateTime.now();
  double amount = 0.0;
  Category category = Category();
  Subcategory subcategory = Subcategory();
}

class Category {
  int id = -1;
  String title = "";
  Icon icon = Icon(Icons.block_flipped);
  Color color = Color.fromARGB(255, 54, 54, 54);
}

class Subcategory {
  int id = -1;
  String title = "";
  int parent = -1;
  Icon icon = Icon(Icons.block_flipped);
  Color color = Color.fromARGB(255, 54, 54, 54);
}

class Settings {
  Color themeColor = Color.fromARGB(255, 192, 34, 231);
}
