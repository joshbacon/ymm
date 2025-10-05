import 'package:ymm/models/categorymodel.dart';
import 'package:ymm/models/state.dart';

class Transaction {
  final int _id;
  String _name;
  DateTime _date;
  double _amount;
  Category? _category;
  Subcategory? _subcategory;

  Transaction(this._id, this._name, this._date, this._amount, this._category, this._subcategory);

  int get id => _id;
  String get name => _name;
  DateTime get date => _date;
  double get amount => _amount;
  Category? get category => _category;
  Subcategory? get subcategory => _subcategory;

  void setName(String newValue) => _name = newValue;
  void setDate(DateTime newValue) => _date = newValue;
  void setAmount(double newValue) => _amount = newValue;
  void setCategory(Category newValue) => _category = newValue;
  void setSubcategory(Subcategory newValue) => _subcategory = newValue;
}
