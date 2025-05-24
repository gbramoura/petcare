import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcare/models/vaccine_model.dart';
import 'package:petcare/themes/pet_care_theme.dart';

class ProfileVaccineCard extends StatelessWidget {
  final VaccineModel vaccine;

  const ProfileVaccineCard({
    super.key,
    required this.vaccine,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PetCareTheme.pink_900,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vaccine.name,
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 6),
          Text(
            DateFormat('dd/MM/yyyy').format(vaccine.date),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
