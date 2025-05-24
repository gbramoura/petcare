import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/models/tours_model.dart';
import 'package:petcare/pages/loading_page.dart';
import 'package:petcare/providers/petcare_database_provider.dart';
import 'package:petcare/repositories/pets_repository.dart';
import 'package:petcare/repositories/tours_repository.dart';
import 'package:petcare/themes/pet_care_theme.dart';
import 'package:petcare/widgets/date_input.dart';
import 'package:petcare/widgets/dropdown_input.dart';
import 'package:petcare/widgets/save_button.dart';
import 'package:petcare/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddToursAndActivitiesPage extends StatefulWidget {
  const AddToursAndActivitiesPage({super.key});

  @override
  State<AddToursAndActivitiesPage> createState() =>
      _AddToursAndActivitiesPageState();
}

class _AddToursAndActivitiesPageState extends State<AddToursAndActivitiesPage> {
  final _formGlobalKey = GlobalKey<FormState>();
  final _activityController = TextEditingController();
  final _placeController = TextEditingController();
  final _dateController = TextEditingController();

  late ToursRepository _toursRepository;
  late List<PetModel> _pets = [];
  late PetModel? _selectedPet;

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
    var toursRepository = ToursRepository(database);
    var petsRepository = PetsRepository(database);

    var pets = await petsRepository.list();
    var pet = PetModel.create(
      id: 0,
      name: '',
      breed: '',
      bornDate: DateTime(0),
      observation: '',
      image: '',
    );

    setState(() {
      _toursRepository = toursRepository;
      _pets = pets;
      _loading = false;
      _selectedPet = pet;
    });
  }

  _save() async {
    var tours = await _toursRepository.list();
    var value = ToursModel.create(
      id: tours.last.id + 1,
      activity: _activityController.text,
      date: DateFormat("dd/MM/yyyy").parse(_dateController.text),
      observation: '',
      place: _placeController.text,
      petId: _selectedPet?.id ?? 0,
    );

    await _toursRepository.create(value);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  List<DropdownMenuItem<PetModel>> _dropdownMap() {
    if (_pets.isEmpty) {
      return [];
    }

    return _pets
        .map<DropdownMenuItem<PetModel>>(
          (pet) => DropdownMenuItem(
            value: pet,
            child: Text(pet.name),
          ),
        )
        .toList();
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
            items: _dropdownMap(),
            label: 'Pet',
            hint: 'Nenhum pet encontrado',
            icon: Icons.pets,
            backgroundColor: PetCareTheme.blue_250,
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            value: _selectedPet,
            onChanged: (value) => {
              setState(() {
                _selectedPet = value;
              })
            },
          ),
          SizedBox(height: 16),
          TextInput(
            backgroundColor: PetCareTheme.blue_250,
            label: 'Atividade',
            controller: _activityController,
            icon: Icons.park,
          ),
          SizedBox(height: 16),
          TextInput(
            backgroundColor: PetCareTheme.blue_250,
            label: 'Local',
            controller: _placeController,
            icon: Icons.location_pin,
          ),
          SizedBox(height: 16),
          DateInput(
            backgroundColor: PetCareTheme.blue_250,
            label: 'Data da Atividade',
            controller: _dateController,
          ),
        ],
      ),
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return SaveButton(
      label: 'Salvar',
      color: PetCareTheme.blue_300,
      icon: Icons.park,
      onPressed: _save,
    );
  }
}
