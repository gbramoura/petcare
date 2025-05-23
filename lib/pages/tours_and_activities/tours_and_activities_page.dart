import 'package:flutter/material.dart';
import 'package:petcare/constants/route_constants.dart';
import 'package:petcare/models/tours_model.dart';
import 'package:petcare/pages/loading_page.dart';
import 'package:petcare/providers/petcare_database_provider.dart';
import 'package:petcare/repositories/tours_repository.dart';
import 'package:petcare/themes/pet_care_theme.dart';
import 'package:petcare/widgets/add_button.dart';
import 'package:petcare/widgets/tours_card.dart';
import 'package:provider/provider.dart';

class ToursAndActivitiesPage extends StatefulWidget {
  const ToursAndActivitiesPage({super.key});

  @override
  State<ToursAndActivitiesPage> createState() => _ToursAndActivitiesPageState();
}

class _ToursAndActivitiesPageState extends State<ToursAndActivitiesPage> {
  late ToursRepository _toursRepository;
  late List<ToursModel> _list;

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
    var tours = await toursRepository.list();

    setState(() {
      _toursRepository = toursRepository;
      _list = tours;
      _loading = false;
    });
  }

  _delete(int id) async {
    setState(() {
      _loading = true;
    });

    await _toursRepository.delete(id);

    var tours = await _toursRepository.list();

    setState(() {
      _list = tours;
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
        'Histórico de Atividades',
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
        var tours = _list[index];
        return ToursCard(
          id: tours.id,
          petId: tours.petId,
          activity: tours.activity,
          date: tours.date,
          place: tours.place,
          onDelete: (context) {
            _delete(tours.id);
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
          'assets/empty_tours_and_activities.png',
          height: 368,
          width: 368,
        ),
        Text(
          'Nenhuma atividade encontrada',
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
      label: 'Adicionar Atividade',
      color: PetCareTheme.blue_300,
      icon: Icons.park,
      onPressed: () {
        Navigator.pushNamed(context, RouteConstants.addToursAndActivities).then(
          (value) async {
            setState(() {
              _loading = true;
            });

            var tours = await _toursRepository.list();

            setState(() {
              _list = tours;
              _loading = false;
            });
          },
        );
      },
    );
  }
}
