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
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: PetCareTheme.white,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                icon,
                size: 32,
                color: PetCareTheme.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
