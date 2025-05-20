import 'dart:io';

import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:petcare/pages/pets/profile_pet_page.dart';
import 'package:petcare/themes/pet_care_theme.dart';

class PetCard extends StatefulWidget {
  final int id;
  final String image;
  final String name;
  final String breed;
  final DateTime bornDate;

  const PetCard({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.breed,
    required this.bornDate,
  });

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  _navigate() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePetPage(
          id: widget.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PetCareTheme.orange_100.withAlpha(125),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(
                  File(widget.image),
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                Text(
                  widget.breed,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  _getAge(widget.bornDate),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: _navigate,
            borderRadius: BorderRadius.circular(16),
            child: Ink(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                width: 42,
                height: 100,
                child: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getAge(DateTime date) {
    var age = AgeCalculator.age(date);

    if (age.years >= 1) {
      return '${age.years.toString()} Ano(s)';
    }

    return '${age.months.toString()} Mes(es)';
  }
}
