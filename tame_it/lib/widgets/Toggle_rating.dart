import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class ToggleRatingButtons extends StatefulWidget {
  const ToggleRatingButtons({super.key});

  @override
  State<ToggleRatingButtons> createState() => _ToggleRatingButtonsState();
}

class _ToggleRatingButtonsState extends State<ToggleRatingButtons> {
  List<bool> isSelected = [false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderColor: Colors.black26,
      isSelected: isSelected,
      fillColor:  AppColors.deepsea,
      color:  AppColors.deepsea,
      selectedColor: Colors.white,
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.star,
                size: 14,
                color: Colors.amber,
              ),
              Text(
                '  1.0',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.star,
                size: 14,
                color: Colors.amber,
              ),
              Text(
                '  2.0',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.star,
                size: 14,
                color: Colors.amber,
              ),
              Text(
                '  3.0',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.star,
                size: 14,
                color: Colors.amber,
              ),
              Text(
                '  4.0',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.star,
                size: 14,
                color: Colors.amber,
              ),
              Text(
                '  5.0',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
