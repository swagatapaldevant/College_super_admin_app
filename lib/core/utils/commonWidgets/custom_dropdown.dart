import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../helper/screen_utils.dart';

class CustomDropdownForAttendance extends StatefulWidget {
  final String placeHolderText;
  final Map<String, int> data;
  final Function(String, int) onValueSelected;
  final bool isDisabled;

  const CustomDropdownForAttendance({
    super.key,
    required this.placeHolderText,
    required this.data,
    required this.onValueSelected,
    this.isDisabled = false,
  });

  @override
  State<CustomDropdownForAttendance> createState() => _CustomDropdownForAttendanceState();
}

class _CustomDropdownForAttendanceState extends State<CustomDropdownForAttendance> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final screenWidth = ScreenUtils().screenWidth(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      decoration: BoxDecoration(
        color: widget.isDisabled ? Colors.grey[300] : const Color(0xFFF5F5FA),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        boxShadow: widget.isDisabled
            ? []
            : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 0,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          hint: Text(
            widget.placeHolderText,
            style: TextStyle(
              color: widget.isDisabled ? Colors.grey : AppColors.colorPrimaryText,
              fontSize: screenWidth * 0.032,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: widget.isDisabled ? Colors.grey : AppColors.colorPrimaryText,
          ),
          onChanged: widget.isDisabled
              ? null
              : (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedValue = newValue;
              });

              final selectedClassId = widget.data[newValue];
              if (selectedClassId != null) {
                widget.onValueSelected(newValue, selectedClassId);
              }
            }
          },
          items: widget.data.keys.map((String key) {
            final modifiedKey = key.replaceFirst(RegExp(r'^\d+\s*'), '');
            return DropdownMenuItem<String>(
              value: key,
              child: Text(
                modifiedKey,
                style: TextStyle(
                  color: widget.isDisabled ? Colors.grey : AppColors.colorBlack,
                  fontSize: screenWidth * 0.032,
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
