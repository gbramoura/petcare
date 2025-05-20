import 'package:flutter/material.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/pages/loading_page.dart';
import 'package:petcare/providers/petcare_database_provider.dart';
import 'package:petcare/repositories/pets_repository.dart';
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
    return Center(
      child: Text(_pet.name),
    );
  }
}
