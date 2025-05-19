import 'package:flutter/material.dart';
import 'package:petcare/themes/pet_care_theme.dart';

class SaveButton extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final void Function()? onPressed;

  const SaveButton({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Icon(
                icon,
                size: 32,
                color: PetCareTheme.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
