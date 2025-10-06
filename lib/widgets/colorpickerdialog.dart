import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog extends StatefulWidget {
  final Color color;

  const ColorPickerDialog({super.key, required this.color});

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {

  late Color newColor = widget.color;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 8.0,
      insetPadding: EdgeInsets.all(8.0),
      child: Container(
        height: 500.0,
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HueRingPicker(
              pickerColor: newColor,
              enableAlpha: false,
              displayThumbColor: false,
              portraitOnly: true,
              onColorChanged: (Color value) {
                newColor = value;
              },
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, newColor);
              },
              child: Text("ok")
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("cancel"
            ))
          ],
        ),
      ),
    );
  }
}