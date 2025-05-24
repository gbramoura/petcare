import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:petcare/models/vaccine_model.dart';
import 'package:petcare/providers/petcare_database_provider.dart';
import 'package:petcare/repositories/pets_repository.dart';
import 'package:petcare/themes/pet_care_theme.dart';
import 'package:provider/provider.dart';

class VaccineCard extends StatefulWidget {
  final int petId;
  final VaccineModel vaccine;
  final void Function(BuildContext context) onDelete;

  const VaccineCard({
    super.key,
    required this.vaccine,
    required this.petId,
    required this.onDelete,
  });

  @override
  State<VaccineCard> createState() => _VaccineCardState();
}

class _VaccineCardState extends State<VaccineCard>
    with SingleTickerProviderStateMixin {
  late String _petName = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    var provider = Provider.of<PetcareDatabaseProvider>(context, listen: false);
    var database = provider.getDatabase();

    var petsRepository = PetsRepository(database);
    var pet = await petsRepository.get(widget.petId);

    setState(() {
      _petName = pet.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: PetCareTheme.pink_50,
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.vaccine.name,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                Text(
                  _petName,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Column(children: [
            Text(
              DateFormat('dd/MM/yyyy').format(widget.vaccine.date),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ])
        ],
      ),
    );
  }
}
