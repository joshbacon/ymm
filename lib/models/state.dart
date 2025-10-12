import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:ymm/models/budgetmodel.dart';
import 'package:ymm/models/categorymodel.dart';
import 'package:ymm/models/transactionfilters.dart';
import 'package:ymm/models/transactionmodel.dart';

// TODO [STATE] save to local storage on relevant change
// TODO [STATE] read from local storage on app load

class AppState extends ChangeNotifier {

  /// Internal, private state of the cart.
  final List<Transaction> _transactions = [
    Transaction("4", "Canadian Tire", DateTime.now(), 38.51, "17"),
    Transaction("5", "Dollarama", DateTime.now(), 3.11, "17"),
    Transaction("6", "Kent", DateTime.now(), 250.67, "22"),
    Transaction("7", "Luke", DateTime.now().subtract(Duration(days: 1)), 7.51, "29"),
    Transaction("1", "McDonalds", DateTime.now().subtract(Duration(days: 8)), 11.93, "2"),
    Transaction("2", "Petro Can", DateTime.now().subtract(Duration(days: 12)), 83.72, "41"),
    Transaction("3", "Sobeys", DateTime.now().subtract(Duration(days: 46)), 43.87, "71"),
  ];
  final List<Budget> _budgets = [
    Budget("1", "Food", 300.0, ["71", "2", "11"], false),
    Budget("12", "Car", 200.0, ["41", "21", "20"], false),
    Budget("13", "Living", 800.0, ["24", "243"], false),
    Budget("14", "Income", 260.0, ["22", "28", "29"], false)
  ];
  final List<Category> _categories = [
    Category("71", "Groceries", Icons.local_grocery_store, const Color.fromARGB(255, 54, 108, 224)),
    Category("41", "Gas", Icons.local_gas_station, const Color.fromARGB(255, 204, 31, 103)),
    Category("2", "Takeout", Icons.emoji_food_beverage, const Color.fromARGB(255, 156, 96, 27)),
    Category("11", "Liquor", Icons.liquor, const Color.fromARGB(255, 215, 31, 221)),
    Category("21", "Insurance", Icons.book, const Color.fromARGB(255, 204, 158, 31)),
    Category("12", "Clothes", Icons.woman, const Color.fromARGB(255, 177, 174, 14)),
    Category("22", "Salary", Icons.attach_money, const Color.fromARGB(255, 31, 204, 45)),
    Category("13", "Hobbies", Icons.brush_outlined, const Color.fromARGB(255, 85, 28, 218)),
    Category("24", "Rent", Icons.other_houses, const Color.fromARGB(255, 204, 164, 31)),
    Category("243", "Power", Icons.power, const Color.fromARGB(255, 243, 230, 55)),
    Category("15", "Phone", Icons.phone_android, const Color.fromARGB(255, 100, 134, 143)),
    Category("26", "School", Icons.school, const Color.fromARGB(255, 31, 97, 221)),
    Category("17", "Spending", Icons.theaters, const Color.fromARGB(255, 214, 21, 21)),
    Category("28", "Dividend", Icons.payments, const Color.fromARGB(255, 198, 30, 231)),
    Category("29", "Transfer", Icons.payments, const Color.fromARGB(255, 30, 231, 171)),
    Category("20", "Car Maintenance", Icons.settings_applications, const Color.fromARGB(255, 68, 70, 73))
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

  List<Transaction> filteredTransactions(TransactionFilters filters) {
    List<Transaction> temp = [..._transactions];

    if (filters.startDate != null) {
      temp = temp.where((t) => t.date.isAfter(DateTime(filters.startDate!.year, filters.startDate!.month, filters.startDate!.day))).toList();
    }
    if (filters.endDate != null) {
      temp = temp.where((t) => t.date.isBefore(DateTime(filters.endDate!.year, filters.endDate!.month, filters.endDate!.day+1))).toList();
    }

    if (filters.range != null) {
      DateTime startDate = DateTime.now();
      if (filters.range == "week") {
        temp = temp.where((t) => t.date.isAfter(DateTime(startDate.year, startDate.month, startDate.weekday - DateTime.monday +1))).toList();
      } else if (filters.range == "month") {
        temp = temp.where((t) => t.date.isAfter(DateTime(startDate.year, startDate.month, 1))).toList();
      } else if (filters.range == "3m") {
        temp = temp.where((t) => t.date.isAfter(DateTime(startDate.year, startDate.month-3, startDate.day))).toList();
      } else if (filters.range == "6m") {
        temp = temp.where((t) => t.date.isAfter(DateTime(startDate.year, startDate.month-6, startDate.day))).toList();
      } else if (filters.range == "12m") {
        temp = temp.where((t) => t.date.isAfter(DateTime(startDate.year, startDate.month-12, startDate.day))).toList();
      } else if (filters.range == "YTD") {
        temp = temp.where((t) => t.date.isAfter(DateTime(startDate.year, 1, 1))).toList();
      }
    }

    if (filters.categories.isNotEmpty) {
      temp = temp.where((Transaction elem) => filters.categories.contains(elem.category)).toList();
    }

    if (filters.searchText != null) {
      temp = temp.where((Transaction elem) {
        return elem.name.toLowerCase().contains(filters.searchText!.toLowerCase());
      }).toList();
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
    return _categories.firstWhere((elem) => elem.id == id, orElse: () => Category.empty());
  }

  void addCategory(Category item) {
    _categories.add(item);
    notifyListeners();
  }
  
  void removeCategory(Category item) {
    for (Transaction t in _transactions) {
      if (t.category == item.id) t.setCategory(null);
    }
    for (Budget b in _budgets) {
      b.categories.remove(item.id);
    }
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
