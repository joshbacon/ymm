import 'package:flutter/material.dart';

class Category {
  final int _id;
  String _title;
  Icon _icon;
  Color _color;

  Category(this._id, this._title, this._icon, this._color);
  Category.empty() : _id = -1, _title = "", _icon = Icon(Icons.cancel), _color = const Color.fromARGB(255, 61, 61, 61);

  int get id => _id;
  String get title => _title;
  Icon get icon => _icon;
  Color get color => _color;

  void setTitle(String newValue) => _title = newValue;
  void setIcon(Icon newValue) => _icon = newValue;
  void setColor(Color newValue) => _color = newValue;
}