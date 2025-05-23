import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcare/providers/petcare_database_provider.dart';
import 'package:petcare/repositories/pets_repository.dart';
import 'package:petcare/themes/pet_care_theme.dart';
import 'package:provider/provider.dart';

class ToursCard extends StatefulWidget {
  final int id;
  final int petId;
  final String activity;
  final String place;
  final DateTime date;

  const ToursCard({
    super.key,
    required this.id,
    required this.activity,
    required this.place,
    required this.petId,
    required this.date,
  });

  @override
  State<ToursCard> createState() => _ToursCardState();
}

class _ToursCardState extends State<ToursCard> {
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
    var pet = await petsRepository.get(widget.id);

    setState(() {
      _petName = pet.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PetCareTheme.blue_250,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.activity,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              Text(
                widget.place,
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
                _petName,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(widget.date),
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
