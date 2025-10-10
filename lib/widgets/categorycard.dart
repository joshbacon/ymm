import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/categorymodel.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/widgets/categoryeditpanel.dart';

class CategoryCard extends StatefulWidget {
  final Category data;

  const CategoryCard({super.key, required this.data});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  late Category updatedCategory = widget.data.copyWith();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => GestureDetector(
        onTap: () {
          showModalBottomSheet<Category>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return CategoryEditPanel(data: widget.data, callback: (Category newCategory) => updatedCategory = newCategory);
            },
          );
          // ).then((value) {
          //   for (Budget budget in appState.budgets) {
          //     if (budget.categories.contains(updatedCategory.id)) {
          //       List<Category> updatedCategories = budget.categories.map((c) => c.id == updatedCategory.id ? updatedCategory : c).toList();
          //       Budget updatedBudget = budget.copyWith(categories: updatedCategories);
          //       appState.updateBudget(updatedBudget);
          //     }
          //   }
            
          // });
        },
        child: Card(
          elevation: 8.0,
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.square_rounded,
                    color: widget.data.color.withAlpha(50),
                    size: 52.0,
                  ),
                  Icon(
                    widget.data.icon.icon,
                    color: widget.data.color,
                    size: 28.0,
                  ),
                ],
              ),
              SizedBox(width: 10.0),
              Text(
                widget.data.title,
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}