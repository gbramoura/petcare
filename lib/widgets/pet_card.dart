import 'dart:io';

import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/themes/pet_care_theme.dart';

class PetCard extends StatelessWidget {
  final PetModel pet;
  final void Function(BuildContext context) onDelete;
  final void Function(BuildContext context) onNavigate;

  const PetCard({
    super.key,
    required this.pet,
    required this.onDelete,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: PetCareTheme.orange_50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.50,
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              onPressed: onNavigate,
              backgroundColor: PetCareTheme.orange_100,
              foregroundColor: Colors.white,
              icon: Icons.pets,
              label: 'Perfil',
            ),
            SlidableAction(
              onPressed: onDelete,
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Deletar',
            ),
          ],
        ),
        child: container(),
      ),
    );
  }

  Widget container() {
    return Container(
      padding: EdgeInsets.all(16),
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
                  File(pet.image),
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
                  pet.name,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                Text(
                  pet.breed,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  _getAge(pet.bornDate),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ],
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
