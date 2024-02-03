import 'package:flutter/material.dart';
import 'package:tame_it/values/values.dart';

class AvailableHoursCheckbox extends StatefulWidget {
  const AvailableHoursCheckbox({super.key});

  @override
  State<AvailableHoursCheckbox> createState() => _AvailableHoursCheckboxState();
}

class _AvailableHoursCheckboxState extends State<AvailableHoursCheckbox> {
  final List<String> _selectedItems = [];

  List<String> item = ['9 am-12 pm', '12 pm-3 pm', '3 pm-6 pm', '6 pm-9 pm'];


  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // shrinkWrap: true, // Important to avoid height issues in Column
      children: item.asMap().entries.map((entry) {
        int index = entry.key;
        String item = entry.value;

        return CheckboxListTile(
          contentPadding: const EdgeInsets.only(right: 178),
          title: Row(
            children: [
              Expanded(
                child: Center(
                    child: Text(
                  item,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.deepsea.withOpacity(0.7)),
                )),
              ),
            ],
          ),
          controlAffinity: ListTileControlAffinity.leading,
          value: _selectedItems.contains(item),
          onChanged: (isChecked) => _itemChange(item, isChecked!),
        
        );
      }).toList(),
    );
  }
}
