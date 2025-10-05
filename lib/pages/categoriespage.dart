import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/widgets/categorycard.dart';
import 'package:ymm/widgets/newcategorycard.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(150),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onPrimary)
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Categories",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: appState.categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryCard(data: appState.categories[index]);
                  }
                ),
                AddCategoryCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}