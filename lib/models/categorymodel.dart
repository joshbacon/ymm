import 'package:flutter/material.dart';

class Category {
  final String _id;
  String _title;
  IconData _icon;
  Color _color;

  Category(this._id, this._title, this._icon, this._color);
  Category.empty() : _id = DateTime.now().toString(), _title = "", _icon = Icons.cancel, _color = const Color.fromARGB(255, 61, 61, 61);

  String get id => _id;
  String get title => _title;
  IconData get icon => _icon;
  Color get color => _color;

  void setTitle(String newValue) => _title = newValue;
  void setIcon(IconData newValue) => _icon = newValue;
  void setColor(Color newValue) => _color = newValue;

  Category copyWith({String? title, IconData? icon, Color? color}) {
    return Category(_id, title ?? _title, icon ?? _icon, color ?? _color);
  }
}