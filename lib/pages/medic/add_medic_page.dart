import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcare/models/medic_model.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/pages/loading_page.dart';
import 'package:petcare/providers/petcare_database_provider.dart';
import 'package:petcare/repositories/medic_repository.dart';
import 'package:petcare/repositories/pets_repository.dart';
import 'package:petcare/themes/pet_care_theme.dart';
import 'package:petcare/widgets/date_input.dart';
import 'package:petcare/widgets/dropdown_input.dart';
import 'package:petcare/widgets/save_button.dart';
import 'package:petcare/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddMedicPage extends StatefulWidget {
  const AddMedicPage({super.key});

  @override
  State<AddMedicPage> createState() => _AddMedicPageState();
}

class _AddMedicPageState extends State<AddMedicPage> {
  final _formGlobalKey = GlobalKey<FormState>();
  final _petIdController = TextEditingController();
  final _nameController = TextEditingController();
  final _healthStatusController = TextEditingController();
  final _medicDateController = TextEditingController();
  final _observationController = TextEditingController();

  late List<PetModel> _petlist;
  late MedicRepository _medicRepository;

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
    var petsRepository = PetsRepository(database);
    var pets = await petsRepository.list();

    setState(() {
      _petlist = pets;
      _medicRepository = medicRepository;
      _loading = false;
    });
  }

  _save() async {
    if (!_formGlobalKey.currentState!.validate()) {
      return;
    }

    try {
      var medic = await _medicRepository.list();
      var value = MedicModel.create(
        id: medic.isEmpty ? 0 : medic.last.id + 1,
        medic: _nameController.text,
        date: DateFormat("dd/MM/yyyy").parse(_medicDateController.text),
        observation: _observationController.text,
        healthStatus: _healthStatusController.text,
        petId: int.parse(_petIdController.text),
      );

      await _medicRepository.create(value);
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {}
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

  AppBar? _appBar(context) {
    return AppBar(
      titleSpacing: 0,
      title: Text(
        'Nova Consulta',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
      ),
      shadowColor: Colors.transparent,
    );
  }

  Widget? _body(context) {
    return Form(
      key: _formGlobalKey,
      child: Column(
        children: [
          DropdownInput(
            label: 'Pet',
            items: _petDropdownMenuItems(),
            hint: 'Nenhum pet selecionado',
            value: _petIdController.text,
            icon: Icons.pets,
            backgroundColor: PetCareTheme.pink_75,
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            onChanged: (value) => _petIdController.text = value!,
          ),
          SizedBox(height: 16),
          TextInput(
            backgroundColor: PetCareTheme.pink_75,
            label: 'Médico Veterinário',
            controller: _nameController,
            icon: Icons.medical_services,
          ),
          SizedBox(height: 16),
          DateInput(
            backgroundColor: PetCareTheme.pink_75,
            label: 'Data da Consulta',
            controller: _medicDateController,
          ),
          SizedBox(height: 16),
          TextInput(
            backgroundColor: PetCareTheme.pink_75,
            label: 'Estado de Saúde',
            controller: _healthStatusController,
            icon: Icons.health_and_safety,
          ),
          SizedBox(height: 16),
          TextInput(
            backgroundColor: PetCareTheme.pink_75,
            label: 'Observação',
            controller: _observationController,
            maxlines: 3,
          ),
        ],
      ),
    );
  }

  Widget? _floatingActionButton(context) {
    return SaveButton(
      label: 'Salvar',
      color: PetCareTheme.pink_300,
      icon: Icons.medical_services,
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
