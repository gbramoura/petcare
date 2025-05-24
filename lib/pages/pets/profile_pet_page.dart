import 'dart:io';

import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:petcare/models/feed_model.dart';
import 'package:petcare/models/medic_model.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/models/tours_model.dart';
import 'package:petcare/models/vaccine_model.dart';
import 'package:petcare/pages/loading_page.dart';
import 'package:petcare/providers/petcare_database_provider.dart';
import 'package:petcare/repositories/feed_repository.dart';
import 'package:petcare/repositories/medic_repository.dart';
import 'package:petcare/repositories/pets_repository.dart';
import 'package:petcare/repositories/tours_repository.dart';
import 'package:petcare/repositories/vaccine_repository.dart';
import 'package:petcare/themes/pet_care_theme.dart';
import 'package:petcare/widgets/profile_feed_card.dart';
import 'package:petcare/widgets/profile_medic_card.dart';
import 'package:petcare/widgets/profile_tours_card.dart';
import 'package:petcare/widgets/profile_vaccine_card.dart';
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
  late PetModel _pet;
  late List<ToursModel> _tours;
  late List<VaccineModel> _vaccines;
  late List<FeedModel> _feeds;
  late List<MedicModel> _medics;

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
    var feedRepository = FeedRepository(database);
    var medicRepository = MedicRepository(database);

    var pet = await petsRepository.get(widget.id);
    var tours = await toursRepository.listWherePet(pet.id);
    var vaccines = await vaccineRepository.listWherePet(pet.id);
    var feeds = await feedRepository.listWherePet(pet.id);
    var medics = await medicRepository.listWherePet(pet.id);

    setState(() {
      _pet = pet;
      _tours = tours;
      _vaccines = vaccines;
      _feeds = feeds;
      _medics = medics;
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
    return CustomScrollView(
      slivers: [
        _header(),
        _vaccinesSection(),
        _toursSection(),
        _feedSection(),
        _medicsSection(),
        SliverToBoxAdapter(child: SizedBox(height: 35)),
      ],
    );
  }

  SliverToBoxAdapter _header() {
    return SliverToBoxAdapter(
      child: Container(
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
      ),
    );
  }

  SliverList _vaccinesSection() {
    if (_vaccines.isEmpty) {
      return SliverList(delegate: SliverChildListDelegate([]));
    }

    var vaccinesWidgets = _vaccines.map((vaccine) {
      return ProfileVaccineCard(
        vaccine: vaccine,
      );
    }).toList();

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
            child: Text(
              'Vacinas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...vaccinesWidgets,
        ],
      ),
    );
  }

  SliverList _toursSection() {
    if (_tours.isEmpty) {
      return SliverList(delegate: SliverChildListDelegate([]));
    }

    var toursWidgets = _tours.map(
      (tour) {
        return ProfileToursCard(
          tour: tour,
        );
      },
    ).toList();

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
            child: Text(
              'Histórico de Atividades',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...toursWidgets,
        ],
      ),
    );
  }

  SliverList _feedSection() {
    if (_feeds.isEmpty) {
      return SliverList(delegate: SliverChildListDelegate([]));
    }

    var feedsWidgets = _feeds.map((feed) {
      return ProfileFeedCard(
        feed: feed,
      );
    }).toList();

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
            child: Text(
              'Histórico de Alimentação',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...feedsWidgets,
        ],
      ),
    );
  }

  SliverList _medicsSection() {
    if (_medics.isEmpty) {
      return SliverList(delegate: SliverChildListDelegate([]));
    }

    var medicsWidgets = _medics.map((medic) {
      return ProfileMedicCard(
        medic: medic,
      );
    }).toList();

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
            child: Text(
              'Histórico Medico',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...medicsWidgets,
        ],
      ),
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
