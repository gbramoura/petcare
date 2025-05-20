import 'dart:io';

import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/pages/loading_page.dart';
import 'package:petcare/providers/petcare_database_provider.dart';
import 'package:petcare/repositories/pets_repository.dart';
import 'package:petcare/themes/pet_care_theme.dart';
import 'package:provider/provider.dart';

class ProfilePetPage extends StatefulWidget {
  final int id;

  const ProfilePetPage({
    super.key,
    required this.id,
  });

  @override
  State<ProfilePetPage> createState() => _ProfilePetPageState();
}

class _ProfilePetPageState extends State<ProfilePetPage> {
  late PetsRepository _petsRepository;
  late PetModel _pet;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    setState(() {
      _loading = true;
    });

    var provider = Provider.of<PetcareDatabaseProvider>(context, listen: false);
    var database = provider.getDatabase();
    var petsRepository = PetsRepository(database);
    var pet = await petsRepository.get(widget.id);

    setState(() {
      _petsRepository = petsRepository;
      _pet = pet;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return LoadingPage();
    }

    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Text(
        'Meu Pet',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
      ),
      shadowColor: Colors.transparent,
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: PetCareTheme.orange_100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _pet.name,
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: PetCareTheme.white,
                      ),
                    ),
                    Text(
                      _pet.breed,
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: PetCareTheme.white,
                      ),
                    ),
                    Text(
                      _getAge(_pet.bornDate),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: PetCareTheme.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(
                      File(_pet.image),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
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
