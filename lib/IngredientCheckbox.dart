import 'package:flutter/material.dart';

class IngredientCheckbox extends StatefulWidget {
  IngredientCheckbox({Key key}) : super(key: key);

  @override
  _IngredientCheckboxState createState() => _IngredientCheckboxState();
}

class _IngredientCheckboxState extends State<IngredientCheckbox> {
  bool isChecked;

  @override
  void initState() {
    isChecked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (bool value) {
        setState(() {
          isChecked = value;
        });
      },
    );
  }
}
