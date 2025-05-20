import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/pages/loading_page.dart';
import 'package:petcare/providers/petcare_database_provider.dart';
import 'package:petcare/repositories/pets_repository.dart';
import 'package:petcare/themes/pet_care_theme.dart';
import 'package:petcare/widgets/date_input.dart';
import 'package:petcare/widgets/image_input.dart';
import 'package:petcare/widgets/save_button.dart';
import 'package:petcare/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final _formGlobalKey = GlobalKey<FormState>();
  final _imageController = TextEditingController();
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _bornDateController = TextEditingController();
  final _observationController = TextEditingController();

  late PetsRepository _petsRepository;

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

    setState(() {
      _petsRepository = petsRepository;
      _loading = false;
    });
  }

  _save() async {
    var file = XFile(_imageController.text);
    var duplicateFilePath = (await getApplicationDocumentsDirectory()).path;
    var fileName = file.path.split(Platform.pathSeparator).last;
    var filePath = '$duplicateFilePath/$fileName';

    await file.saveTo(filePath);

    var pets = await _petsRepository.list();
    var value = PetModel.create(
      id: pets.length,
      name: _nameController.text,
      breed: _breedController.text,
      bornDate: DateFormat("dd/MM/yyyy").parse(_bornDateController.text),
      observation: _observationController.text,
      image: filePath,
    );

    await _petsRepository.create(value);

    if (mounted) {
      Navigator.pop(context);
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
          ImageInput(
            color: PetCareTheme.orange_50,
            controller: _imageController,
          ),
          SizedBox(height: 16),
          TextInput(
            backgroundColor: PetCareTheme.orange_50,
            label: 'Nome',
            controller: _nameController,
            icon: Icons.pets,
          ),
          SizedBox(height: 16),
          TextInput(
            backgroundColor: PetCareTheme.orange_50,
            label: 'Raça',
            controller: _breedController,
            icon: Icons.bloodtype,
          ),
          SizedBox(height: 16),
          DateInput(
            backgroundColor: PetCareTheme.orange_50,
            label: 'Data de Nascimento',
            controller: _bornDateController,
          ),
          SizedBox(height: 16),
          TextInput(
            backgroundColor: PetCareTheme.orange_50,
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
      color: PetCareTheme.orange_100,
      icon: Icons.pets,
      onPressed: _save,
    );
  }
}
