import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:petcare/models/medic_model.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/themes/pet_care_theme.dart';

class MedicCard extends StatefulWidget {
  final PetModel pet;
  final MedicModel medic;
  final void Function(BuildContext context) onDelete;

  const MedicCard({
    super.key,
    required this.medic,
    required this.pet,
    required this.onDelete,
  });

  @override
  State<MedicCard> createState() => _MedicCardState();
}

class _MedicCardState extends State<MedicCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: PetCareTheme.pink_75,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              onPressed: widget.onDelete,
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Deletar',
            ),
          ],
        ),
        child: _content(),
      ),
    );
  }

  Widget _content() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.pet.name,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              Text(
                widget.medic.healthStatus,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.medic.medic,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(widget.medic.date),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
