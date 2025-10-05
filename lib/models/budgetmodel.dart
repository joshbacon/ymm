import 'package:ymm/models/categorymodel.dart';

class Budget {
  final String _id;
  String _name;
  double _limit;
  List<Category> _categories;
  bool _weekly;

  Budget(this._id, this._name, this._limit, this._categories, this._weekly);
  Budget.empty() : _id = DateTime.now().toString(), _name = "New Budget", _limit = 0.0, _categories = [], _weekly = false;

  String get id => _id;
  String get name => _name;
  double get limit => _limit;
  List<Category> get categories => _categories;
  bool get weekly => _weekly;

  void setName(String newValue) => _name = newValue;
  void setLimit(double newValue) => _limit = newValue;
  void setCategories(List<Category> newValue) => _categories = newValue;
  void setWeekly(bool newValue) => _weekly = newValue;

  Budget copyWith({String? name, double? limit, List<Category>? categories, bool? weekly}) {
    return Budget(_id, name ?? _name, limit ?? _limit, categories ?? _categories, weekly ?? _weekly);
  }
}