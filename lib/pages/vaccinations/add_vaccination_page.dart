import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/models/vaccine_model.dart';
import 'package:petcare/pages/loading_page.dart';
import 'package:petcare/providers/petcare_database_provider.dart';
import 'package:petcare/repositories/pets_repository.dart';
import 'package:petcare/repositories/vaccine_repository.dart';
import 'package:petcare/themes/pet_care_theme.dart';
import 'package:petcare/widgets/date_input.dart';
import 'package:petcare/widgets/dropdown_input.dart';
import 'package:petcare/widgets/save_button.dart';
import 'package:petcare/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddVaccinationPage extends StatefulWidget {
  const AddVaccinationPage({super.key});

  @override
  State<AddVaccinationPage> createState() => _AddVaccinationPageState();
}

class _AddVaccinationPageState extends State<AddVaccinationPage> {
  final _formGlobalKey = GlobalKey<FormState>();
  final _petIdController = TextEditingController() ;
  final _nameController = TextEditingController();
  final _applicationDateController = TextEditingController();
  final _observationController = TextEditingController();

  late List<PetModel> _petlist;
  late PetsRepository _petsRepository;
  late VaccineRepository _vaccineRepository;

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
    var vaccineRepository = VaccineRepository(database);
    var petsRepository = PetsRepository(database);
    var pets = await petsRepository.list();

    setState(() {
      _petsRepository = petsRepository;
      _petlist = pets;
      _vaccineRepository = vaccineRepository;
      _loading = false;
    });
  }

  _save() async {
    if (!_formGlobalKey.currentState!.validate()) {
      return;
    }

    try {
      var vaccine = await _vaccineRepository.list();
      var value = VaccineModel.create(
        id: vaccine.isEmpty? 0: vaccine.last.id+1,
        name: _nameController.text,
        date: DateFormat("dd/MM/yyyy").parse(_applicationDateController.text),
        observation: _observationController.text,
        petId: int.parse(_petIdController.text),
      );

      await _vaccineRepository.create(value);
      // TODO: Create dialog to show sucess and go back to page
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      // TODO: Create dialog to show error
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return LoadingPage();
    }
    
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _floatingActionButton(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Text(
        'Novo Pet',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
      ),
      shadowColor: Colors.transparent,
    );
  }

  Widget _body(BuildContext context) {
    return Form(
      key: _formGlobalKey,
      child: Column(
        children: [
          DropdownInput(
            label: 'Pet',
            items: _petDropdownMenuItems(),
            hint: 'Nenhum pet selecionado',
            value: _petIdController.text,
            backgroundColor: PetCareTheme.pink_50,
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            onChanged: (value) => _petIdController.text=value!,
          ),
          SizedBox(height: 16),
          TextInput(
            backgroundColor: PetCareTheme.pink_50,
            label: 'Vacina',
            controller: _nameController,
            icon: Icons.vaccines,
          ),
          SizedBox(height: 16),
          DateInput(
            backgroundColor: PetCareTheme.pink_50,
            label: 'Data da vacina',
            controller: _applicationDateController,
          ),
          SizedBox(height: 16),
          TextInput(
            backgroundColor: PetCareTheme.pink_50,
            label: 'Observação',
            controller: _observationController,
            maxlines: 3,
          ),
        ],
      ),
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return SaveButton(
      label: 'Salvar',
      color: PetCareTheme.pink_900,
      icon: Icons.pets,
      onPressed: _save,
    );
  }

  List<DropdownMenuItem<String>> _petDropdownMenuItems() {
    if (_petlist.isEmpty) {
      return [];
    }

    return _petlist
        .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
              value: e.id.toString(),
              child: Text(e.name),
            ))
        .toList();
  }
}
