class Transaction {
  final String _id;
  String _name;
  DateTime _date;
  double _amount;
  String? _category;

  Transaction(this._id, this._name, this._date, this._amount, this._category);
  Transaction.empty() : _id = DateTime.now().toString(), _name = "", _date = DateTime.now(), _amount = 0.0, _category = null;

  String get id => _id;
  String get name => _name;
  DateTime get date => _date;
  double get amount => _amount;
  String? get category => _category;

  void setName(String newValue) => _name = newValue;
  void setDate(DateTime newValue) => _date = newValue;
  void setAmount(double newValue) => _amount = newValue;
  void setCategory(String newValue) => _category = newValue;

  Transaction copyWith({String? name, DateTime? date, double? amount, String? category}) {
    return Transaction(_id, name ?? _name, date ?? _date, amount ?? _amount, category ?? _category);
  }
}
