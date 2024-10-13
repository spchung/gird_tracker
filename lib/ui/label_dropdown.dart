import 'package:flutter/material.dart';
import 'package:lets_git_it/model/shared.dart';
import 'package:lets_git_it/ui/dropdown.dart';


class LabelDropDownButton extends StatelessWidget {
  const LabelDropDownButton({
    super.key, 
    required this.label,
    required this.options,
    this.isMissing = false, 
    required this.onChanged,
    required this.enabled,
    required this.placeholderText,
    this.missingMsg
  });

  final List<IdNameModel> options;
  final Function(String?) onChanged;
  final String placeholderText;
  final String label;
  final bool enabled;
  final bool isMissing;
  final String? missingMsg;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            label, 
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[100],
            ),
          ),
        ),
        const SizedBox(height: 5),
        SDropDownButton(
          options: options, 
          onChanged: onChanged, 
          enabled: enabled,
          placeholderText: placeholderText
        )
      ],
    );
  }
}