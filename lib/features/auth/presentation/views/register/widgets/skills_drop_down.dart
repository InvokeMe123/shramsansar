import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class SkillsDropDown extends StatefulWidget {
  final List<String> options;

  const SkillsDropDown({super.key, required this.options});
  @override
  _SkillsDropDownState createState() => _SkillsDropDownState();
}

class _SkillsDropDownState extends State<SkillsDropDown> {
  List<String> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MultiSelectDialogField(
                dialogHeight: 400,
                items:
                    widget.options.map((e) => MultiSelectItem(e, e)).toList(),
                listType: MultiSelectListType.LIST,
                onConfirm: (values) {
                  selectedValues = values;
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop<List<String>>(context, []);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop<List<String>>(context, selectedValues);
                },
                child: const Text('Done'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
