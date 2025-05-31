import 'package:flutter/material.dart';
import 'package:petcare/constants/route_constants.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/pages/loading_page.dart';
import 'package:petcare/pages/pets/profile_pet_page.dart';
import 'package:petcare/providers/petcare_database_provider.dart';
import 'package:petcare/repositories/feed_repository.dart';
import 'package:petcare/repositories/medic_repository.dart';
import 'package:petcare/repositories/pets_repository.dart';
import 'package:petcare/repositories/tours_repository.dart';
import 'package:petcare/repositories/vaccine_repository.dart';
import 'package:petcare/themes/pet_care_theme.dart';
import 'package:petcare/widgets/add_button.dart';
import 'package:petcare/widgets/pet_card.dart';
import 'package:provider/provider.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  late PetsRepository _petsRepository;
  late ToursRepository _toursRepository;
  late VaccineRepository _vaccineRepository;
  late MedicRepository _medicRepository;
  late FeedRepository _feedRepository;
  late List<PetModel> _list;

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
    var toursRepository = ToursRepository(database);
    var vaccineRepository = VaccineRepository(database);
    var medicRepository = MedicRepository(database);
    var feedRepository = FeedRepository(database);
    var pets = await petsRepository.list();

    setState(() {
      _petsRepository = petsRepository;
      _toursRepository = toursRepository;
      _vaccineRepository = vaccineRepository;
      _medicRepository = medicRepository;
      _feedRepository = feedRepository;
      _list = pets;
      _loading = false;
    });
  }

  _delete(int id) async {
    setState(() {
      _loading = true;
    });

    var tours = await _toursRepository.listWherePet(id);
    if (tours.isNotEmpty) {
      for (var tour in tours) {
        await _toursRepository.delete(tour.id);
      }
    }

    var vaccines = await _vaccineRepository.listWherePet(id);
    if (vaccines.isNotEmpty) {
      for (var vaccine in vaccines) {
        await _vaccineRepository.delete(vaccine.id);
      }
    }

    var feeds = await _feedRepository.listWherePet(id);
    if (feeds.isNotEmpty) {
      for (var feed in feeds) {
        await _feedRepository.delete(feed.id);
      }
    }

    var medics = await _medicRepository.listWherePet(id);
    if (medics.isNotEmpty) {
      for (var medic in medics) {
        await _medicRepository.delete(medic.id);
      }
    }

    await _petsRepository.delete(id);

    var pets = await _petsRepository.list();

    setState(() {
      _list = pets;
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
        'Meus Pets',
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
        var pet = _list[index];
        return PetCard(
          pet: pet,
          onDelete: (context) {
            _delete(pet.id);
          },
          onNavigate: (BuildContext context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePetPage(
                  id: pet.id,
                ),
              ),
            );
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
        Image.asset('assets/empty_pets.png', height: 368, width: 368),
        Text(
          'Nenhum pet encontrado',
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
      label: 'Adicionar Pet',
      color: PetCareTheme.orange_100,
      icon: Icons.pets,
      onPressed: () {
        Navigator.pushNamed(context, RouteConstants.addPet).then((value) async {
          setState(() {
            _loading = true;
          });

          var pets = await _petsRepository.list();

          setState(() {
            _list = pets;
            _loading = false;
          });
        });
      },
    );
  }
}
