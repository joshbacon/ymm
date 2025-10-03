import 'dart:collection';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {

  /// Internal, private state of the cart.
  final List<Transaction> _transactions = [];
  Color _seedColor = Color.fromARGB(255, 50, 231, 34);

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Transaction> get transactions => UnmodifiableListView(_transactions);
  Color get seedColor => _seedColor;

  /// Adds transaction to list.
  void addTransaction(Transaction item) {
    _transactions.add(item);
    notifyListeners();
  }

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
  int category = -1;
  int subcategory = -1;
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
  Color themeColor = Color.fromARGB(255, 50, 231, 34);
}