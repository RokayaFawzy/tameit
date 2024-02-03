import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class ToggleGenderButtons extends StatefulWidget {
  const ToggleGenderButtons({super.key});

  @override
  State<ToggleGenderButtons> createState() => _ToggleGenderButtonsState();
}

class _ToggleGenderButtonsState extends State<ToggleGenderButtons> {
  List<bool> isSelected = [false, false];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderColor: Colors.black26,
      isSelected: isSelected,
      fillColor: AppColors.deepsea,
      color:  AppColors.deepsea,
      selectedColor: Colors.white,
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'MALE',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'FEMALE',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
      onPressed: (int newIndex) {
        setState(() {
          for (int index = 0; index < isSelected.length; index++) {
            if (index == newIndex) {
              isSelected[index] = true;
            } else {
              isSelected[index] = false;
            }
          }
        });
      },
    );
  }
}
