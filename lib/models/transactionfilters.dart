class TransactionFilters {
  String? _search;
  DateTime? _startDate;
  DateTime? _endDate;
  List<String> _categories = [];
  String? _range;

  TransactionFilters({search, startDate, endDate, categories, range}) : _search = search, _startDate = startDate, _endDate = endDate, _categories = categories, _range = range;
  TransactionFilters.empty();

  String? get searchText => _search;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  List<String> get categories => _categories;
  String? get range => _range;

  void setSearch(String? newText) => _search = newText;
  void setStartDate(DateTime? newDate) => _startDate = newDate;
  void setEndDate(DateTime? newDate) => _endDate = newDate;
  void setCategories(List<String> newCategories) => _categories = newCategories;
  void setRange(String? newRange) => _range = newRange;
}