import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:provider/provider.dart';
import 'package:ymm/models/categorymodel.dart';
import 'package:ymm/models/state.dart';
import 'package:ymm/widgets/colorpickerdialog.dart';

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
                  GestureDetector(
                    onTap: () {
                      showDialog<Color>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return ColorPickerDialog(color: updatedCategory.color);
                        }
                      ).then((newColor) {
                        Category temp = updatedCategory.copyWith(color: newColor);
                        widget.callback(temp);
                        appState.updateCategory(temp);
                        updatedCategory = temp;
                      });
                    },
                    child: Card(
                      color: updatedCategory.color.withAlpha(100),
                      child: Center(
                        heightFactor: 2,
                        child: Icon(
                          Icons.color_lens,
                          color: updatedCategory.color,
                          size: 36.0
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      IconPickerIcon? icon = await showIconPicker(
                        context,
                        configuration: SinglePickerConfiguration(
                          iconPackModes: [IconPack.material]
                        )
                      );
                      Category temp = updatedCategory.copyWith(icon: icon?.data);
                      widget.callback(temp);
                      appState.updateCategory(temp);
                      updatedCategory = temp;
                    },
                    child: Card(
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Icon",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Icon(
                              updatedCategory.icon
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      appState.removeCategory(updatedCategory);
                      // TODO [CATEGORIES] remove category from any transactions and budgets on delete
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