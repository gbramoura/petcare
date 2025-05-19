import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcare/themes/pet_care_theme.dart';

class DateInput extends StatefulWidget {
  final Color? backgroundColor;
  final String label;
  final IconData? icon;
  final EdgeInsetsGeometry? margin;
  final TextEditingController controller;

  const DateInput({
    super.key,
    this.margin,
    this.icon,
    required this.backgroundColor,
    required this.label,
    required this.controller,
  });

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: TextFormField(
        enabled: true,
        readOnly: true,
        onTap: _selectDate,
        style: TextStyle(fontSize: 18),
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          fillColor: widget.backgroundColor,
          filled: true,
          hintText: 'Selecione a Data',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          suffixIcon: Icon(
            widget.icon ?? Icons.calendar_today,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      builder: _datePickerTheme,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );

    setState(() {
      widget.controller.text =
          pickedDate == null ? '' : DateFormat('dd/MM/yyyy').format(pickedDate);
    });
  }

  Widget _datePickerTheme(context, child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: widget.backgroundColor!,
          onPrimary: Colors.black,
          onSurface: Colors.black,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
          ),
        ),
        datePickerTheme: DatePickerThemeData(
          backgroundColor: PetCareTheme.white_50,
        ),
      ),
      child: child!,
    );
  }
}
