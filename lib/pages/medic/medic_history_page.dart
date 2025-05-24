import 'package:flutter/material.dart';
import 'package:petcare/constants/route_constants.dart';
import 'package:petcare/models/medic_model.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/pages/loading_page.dart';
import 'package:petcare/providers/petcare_database_provider.dart';
import 'package:petcare/repositories/medic_repository.dart';
import 'package:petcare/repositories/pets_repository.dart';
import 'package:petcare/themes/pet_care_theme.dart';
import 'package:petcare/widgets/add_button.dart';
import 'package:petcare/widgets/medic_card.dart';
import 'package:provider/provider.dart';

class MedicHistoryPage extends StatefulWidget {
  const MedicHistoryPage({super.key});

  @override
  State<MedicHistoryPage> createState() => _MedicHistoryPageState();
}

class _MedicHistoryPageState extends State<MedicHistoryPage> {
  late MedicRepository _medicRepository;
  late List<MedicModel> _list;
  late List<PetModel> _petsList;

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

    var medicRepository = MedicRepository(database);
    var medics = await medicRepository.list();

    var petsRepository = PetsRepository(database);
    var pets = await petsRepository.list();

    setState(() {
      _medicRepository = medicRepository;
      _list = medics;
      _petsList = pets;
      _loading = false;
    });
  }

  _delete(int id) async {
    setState(() {
      _loading = true;
    });

    await _medicRepository.delete(id);

    var medics = await _medicRepository.list();

    setState(() {
      _list = medics;
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _floatingActionButton(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Text(
        'Histórico Médico',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
      ),
      shadowColor: Colors.transparent,
    );
  }

  Widget _body(BuildContext context) {
    if (_list.isEmpty) {
      return _empty();
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      primary: false,
      shrinkWrap: true,
      itemCount: _list.length,
      itemBuilder: (context, index) {
        var medic = _list[index];
        var pet = _petsList.where((pet) => pet.id == medic.petId).first;
        return MedicCard(
          medic: medic,
          pet: pet,
          onDelete: (context) {
            _delete(medic.id);
          },
        );
      },
    );
  }

  Widget _empty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: double.infinity),
        Image.asset(
          'assets/empty_medic_history.png',
          height: 368,
          width: 368,
        ),
        Text(
          'Nenhuma consulta encontrada',
          textAlign: TextAlign.center,
          softWrap: true,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return AddButton(
      label: 'Adicionar Consulta',
      color: PetCareTheme.pink_300,
      icon: Icons.medical_services,
      onPressed: () {
        Navigator.pushNamed(context, RouteConstants.addMedic).then(
          (value) async {
            setState(() {
              _loading = true;
            });

            var medics = await _medicRepository.list();

            setState(() {
              _list = medics;
              _loading = false;
            });
          },
        );
      },
    );
  }
}
