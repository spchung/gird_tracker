import 'package:flutter/material.dart';
import 'package:lets_git_it/model/shared.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SDropDownButton extends StatefulWidget {
  const SDropDownButton({
    super.key, 
    required this.options,
    this.isMissing = false, 
    required this.onChanged,
    required this.enabled,
    required this.placeholderText,
    this.missingMsg
  });

  final List<IdNameModel> options;
  final Function(IdNameModel?) onChanged;
  final String placeholderText;
  final bool enabled;
  final bool isMissing;
  final String? missingMsg;

  @override
  State<SDropDownButton> createState() => _SDropDownButtonState();
}

class _SDropDownButtonState extends State<SDropDownButton> {

  // String? selectedValue;
  IdNameModel? selectedValue;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<IdNameModel>(
        isExpanded: true,
        hint: Text(
          widget.isMissing ? widget.missingMsg ?? widget.placeholderText : widget.placeholderText,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: widget.isMissing && widget.missingMsg != null ? const Color.fromRGBO(155, 5, 30, 1) : const Color.fromRGBO(77, 77, 77, 1),
          ),
        ),
        items: widget.options.map((IdNameModel item) => DropdownMenuItem<IdNameModel>(
          value: item,
          enabled: widget.enabled,
          child: Text(
            item.name,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
          ),
        )).toList(),
        onChanged: (IdNameModel? value) {
          setState(() {
            selectedValue = value;
            widget.onChanged(value);
          });
        },
        value: selectedValue,
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(right: 12),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: isExpanded ? const Color.fromRGBO(77, 77, 77, 1) : const Color.fromRGBO(128, 128, 128, 1),
            ),
          ),
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: isExpanded ?const Color.fromRGBO(77, 77, 77, 1) : const Color.fromRGBO(128, 128, 128, 1)
          ),
          iconSize: 22,
          iconEnabledColor:  const Color.fromRGBO(77, 77, 77, 1),
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          // width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          offset: const Offset(0, -5),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all<double>(6),
            thumbVisibility: WidgetStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
        onMenuStateChange: (isOpen) {
          setState(() {
            isExpanded = isOpen;
          });
        },
      )
    );
  }
}