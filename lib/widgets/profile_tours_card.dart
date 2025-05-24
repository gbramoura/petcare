import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcare/models/tours_model.dart';
import 'package:petcare/themes/pet_care_theme.dart';

class ProfileToursCard extends StatelessWidget {
  final ToursModel tour;

  const ProfileToursCard({
    super.key,
    required this.tour,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PetCareTheme.blue_300,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tour.activity,
                softWrap: true,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                tour.place,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            DateFormat('dd/MM/yyyy').format(tour.date),
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
