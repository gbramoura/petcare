import 'package:flutter/material.dart';
import 'package:petcare/themes/pet_care_theme.dart';

class AddButton extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final void Function()? onPressed;

  const AddButton({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Icon(
                icon,
                size: 32,
                color: PetCareTheme.white,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
