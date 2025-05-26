import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcare/models/medic_model.dart';
import 'package:petcare/themes/pet_care_theme.dart';

class ProfileMedicCard extends StatelessWidget {
  final MedicModel medic;

  const ProfileMedicCard({
    super.key,
    required this.medic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PetCareTheme.pink_300,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                medic.medic,
                softWrap: true,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                medic.healthStatus,
                softWrap: true,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            DateFormat('dd/MM/yyyy').format(medic.date),
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
