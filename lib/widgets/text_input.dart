import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final Color? backgroundColor;
  final String label;
  final IconData? icon;
  final int? maxlines;
  final EdgeInsetsGeometry? margin;
  final TextEditingController controller;

  const TextInput({
    super.key,
    this.margin,
    this.icon,
    this.maxlines,
    required this.backgroundColor,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextFormField(
        style: TextStyle(fontSize: 18),
        controller: controller,
        maxLines: maxlines,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          fillColor: backgroundColor,
          filled: true,
          label: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          suffixIcon: Icon(icon),
        ),
      ),
    );
  }
}
