import 'package:flutter/material.dart';
import 'package:petcare/themes/pet_care_theme.dart';

class DashboardButton extends StatelessWidget {
  final Color backgroundColor;
  final String label;
  final IconData icon;
  final void Function()? onPressed;

  const DashboardButton({
    super.key,
    required this.backgroundColor,
    required this.label,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 48,
                  color: PetCareTheme.white,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              label,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
