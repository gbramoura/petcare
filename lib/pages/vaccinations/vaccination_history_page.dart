import 'package:flutter/material.dart';
import 'package:petcare/constants/route_constants.dart';
import 'package:petcare/models/vaccine_model.dart';
import 'package:petcare/pages/loading_page.dart';
import 'package:petcare/providers/petcare_database_provider.dart';
import 'package:petcare/repositories/vaccine_repository.dart';
import 'package:petcare/themes/pet_care_theme.dart';
import 'package:petcare/widgets/add_button.dart';
import 'package:provider/provider.dart';

class VaccinationHistoryPage extends StatefulWidget {
  const VaccinationHistoryPage({super.key});

  @override
  State<VaccinationHistoryPage> createState() => _VaccinationHistoryPageState();
}

class _VaccinationHistoryPageState extends State<VaccinationHistoryPage> {
  late VaccineRepository _vaccineRepository;
  late List<VaccineModel> _list;

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
    var vaccines = await vaccineRepository.list();

    setState(() {
      _vaccineRepository = vaccineRepository;
      _list = vaccines;
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
        'Histórico de Vacinação',
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

    return Center(
      child: Text('vac'),
    );
  }

  Widget _empty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: double.infinity),
        Image.asset('assets/empty_vaccination.png', height: 368, width: 368),
        Text(
          'Nenhuma vacina encontrada',
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
      label: 'Adicionar Vacina',
      color: PetCareTheme.pink_900,
      icon: Icons.vaccines,
      onPressed: () {
        Navigator.pushNamed(context, RouteConstants.addVaccination).then(
          (value) async {
            setState(
              () {
                _loading = true;
              },
            );

            var vaccines = await _vaccineRepository.list();

            setState(
              () {
                _list = vaccines;
                _loading = false;
              },
            );
          },
        );
      },
    );
  }
}
