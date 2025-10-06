import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/categorymodel.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/widgets/categoryeditpanel.dart';

class AddCategoryCard extends StatefulWidget {
  const AddCategoryCard({super.key});

  @override
  State<AddCategoryCard> createState() => _AddCategoryCardState();
}

class _AddCategoryCardState extends State<AddCategoryCard> {
  Category updatedCategory = Category.empty();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => GestureDetector(
        onTap: () {
          appState.addCategory(updatedCategory);
          showModalBottomSheet<Category>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return CategoryEditPanel(data: updatedCategory, callback: (Category newCategory) => updatedCategory = newCategory);
            },
          );
        },
        child: Card(
          clipBehavior: Clip.hardEdge,
          elevation: 8.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}