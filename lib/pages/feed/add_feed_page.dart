import 'package:flutter/material.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/models/feed_model.dart';
import 'package:petcare/pages/loading_page.dart';
import 'package:petcare/providers/petcare_database_provider.dart';
import 'package:petcare/repositories/feed_repository.dart';
import 'package:petcare/repositories/pets_repository.dart';
import 'package:petcare/themes/pet_care_theme.dart';
import 'package:petcare/widgets/dropdown_input.dart';
import 'package:petcare/widgets/save_button.dart';
import 'package:petcare/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddFeedPage extends StatefulWidget {
  const AddFeedPage({super.key});

  @override
  State<AddFeedPage> createState() => _AddFeedPageState();
}

class _AddFeedPageState extends State<AddFeedPage> {
  final _formGlobalKey = GlobalKey<FormState>();
  final _foodController = TextEditingController();
  final _weightController = TextEditingController();
  final _observationController = TextEditingController();

  late FeedRepository _feedRepository;
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
    var feedRepository = FeedRepository(database);
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
      _feedRepository = feedRepository;
      _pets = pets;
      _loading = false;
      _selectedPet = pet;
    });
  }

  _save() async {
    var feed = await _feedRepository.list();
    var value = FeedModel.create(
      id: feed.isEmpty ? 0 : feed.last.id + 1,
      name: _foodController.text,
      observation: _observationController.text,
      weight: num.parse(_weightController.text),
      petId: _selectedPet?.id ?? 0,
    );

    await _feedRepository.create(value);

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
    return SingleChildScrollView(
      child: Form(
        key: _formGlobalKey,
        child: Column(
          children: [
            DropdownInput(
              items: _dropdownMap(),
              label: 'Pet',
              hint: 'Nenhum pet encontrado',
              icon: Icons.pets,
              backgroundColor: PetCareTheme.orange_250,
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
              backgroundColor: PetCareTheme.orange_250,
              label: 'Ração',
              controller: _foodController,
              icon: Icons.cookie_outlined,
            ),
            SizedBox(height: 16),
            TextInput(
              backgroundColor: PetCareTheme.orange_250,
              label: 'Peso da Ração',
              controller: _weightController,
              icon: Icons.balance,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextInput(
              backgroundColor: PetCareTheme.orange_250,
              label: 'Observações',
              controller: _observationController,
              maxlines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return SaveButton(
      label: 'Salvar',
      color: PetCareTheme.orange_300,
      icon: Icons.cookie,
      onPressed: _save,
    );
  }
}
