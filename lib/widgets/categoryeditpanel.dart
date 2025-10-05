import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/categorymodel.dart';
import 'package:ymm/models/state.dart';

class CategoryEditPanel extends StatefulWidget {
  final Category data;
  final Function callback;

  const CategoryEditPanel({super.key, required this.data, required this.callback});

  @override
  State<CategoryEditPanel> createState() => _CategoryEditPanelState();
}

class _CategoryEditPanelState extends State<CategoryEditPanel> {

  late Category updatedCategory = widget.data.copyWith();

  late final TextEditingController _titleController = TextEditingController(text: widget.data.title);

  // TODO: [BUDGET] : update the segment button to scroll in case there's a lot (fixed sized box)

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: 400,
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 75.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                spacing: 10.0,
                children: [
                  //name
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Name'),
                    onEditingComplete: () {
                      Category temp = updatedCategory.copyWith(title: _titleController.text);
                      widget.callback(temp);
                      appState.updateCategory(temp);
                      updatedCategory = temp;
                    },
                    onTapOutside:(event) {
                      Category temp = updatedCategory.copyWith(title: _titleController.text);
                      widget.callback(temp);
                      appState.updateCategory(temp);
                      updatedCategory = temp;
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                  Divider(),
                  OutlinedButton(
                    onPressed: () {
                      // This throws an error but maay not see in the built apk?
                      Navigator.pop(context);
                      Navigator.pop(context);
                      appState.removeCategory(updatedCategory);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delete, color: Theme.of(context).colorScheme.primary.withAlpha(150)),
                        SizedBox(width: 5.0),
                        Text(
                          "Delete",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}