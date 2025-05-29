import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../helper/screen_utils.dart';

class CustomDropDownForTaskCreation extends StatefulWidget {
  final String placeHolderText;
  final Function(String, String) onValueSelected;
  final Map<String, String>? data;
  final bool isDisabled; // Added flag to disable dropdown
  final Color? dropdownContainerColor;

  const CustomDropDownForTaskCreation({
    super.key,
    required this.placeHolderText,
    required this.onValueSelected,
    this.data,
    this.isDisabled = false, this.dropdownContainerColor, // Default to false (enabled)
  });

  @override
  _CustomDropDownForTaskCreationState createState() => _CustomDropDownForTaskCreationState();
}

class _CustomDropDownForTaskCreationState extends State<CustomDropDownForTaskCreation> {
  String? selectedValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final currentYear = DateTime.now().year.toString();
    if (widget.data != null && widget.data!.containsKey(currentYear)) {
      selectedValue = currentYear;

      // Also call the callback to notify the parent widget
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onValueSelected(currentYear, widget.data![currentYear]!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtils().screenWidth(context) * 0.05),
      decoration: BoxDecoration(
        color: widget.isDisabled ? Colors.grey[300] : widget.dropdownContainerColor??Color(0xFFF5F5FA),
        // Change color when disabled
        borderRadius: BorderRadius.circular(
            ScreenUtils().screenWidth(context) * 0.03),
        boxShadow: [
          if (!widget.isDisabled) // Remove shadow when disabled
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 0,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: Text(
            widget.placeHolderText,
            style: TextStyle(
              color: widget.isDisabled ? Colors.grey : AppColors
                  .colorPrimaryText, // Change text color when disabled
              fontSize: ScreenUtils().screenWidth(context) * 0.032,
              fontWeight: FontWeight.w600,

            ),
          ),
          icon: Icon(Icons.keyboard_arrow_down,
              color: widget.isDisabled ? Colors.grey : AppColors
                  .colorPrimaryText),
          isExpanded: true,
          onChanged: widget.isDisabled
              ? null // Disable selection when isDisabled is true
              : (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedValue = newValue;
              });
              String? selectedId = widget.data?[newValue];
              if (selectedId != null) {
                widget.onValueSelected(newValue, selectedId);
              }
            }
          },
          items: widget.data?.keys.map((String key) {
            return DropdownMenuItem<String>(
              value: key,
              child: Text(
                key,
                style: TextStyle(
                  color: widget.isDisabled ? Colors.grey : AppColors.colorBlack,
                  // Gray text if disabled
                  fontSize: ScreenUtils().screenWidth(context) * 0.032,
                  fontFamily: "Poppins",
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}