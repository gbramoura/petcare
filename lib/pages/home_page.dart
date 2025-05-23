import 'package:flutter/material.dart';
import 'package:petcare/constants/route_constants.dart';
import 'package:petcare/themes/pet_care_theme.dart';
import 'package:petcare/widgets/dashboard_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigate(BuildContext context, String path) {
    Navigator.pushNamed(context, path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'PetCare',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w600,
        ),
      ),
      shadowColor: Colors.transparent,
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _banner(context),
            _board(context),
          ],
        ),
      ),
    );
  }

  Widget _banner(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      height: 130,
      decoration: BoxDecoration(
        color: PetCareTheme.pink_300,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              'Cuidados com o seu Pet na sua mão',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: PetCareTheme.white_50,
              ),
            ),
          ),
          Flexible(
            child: Image.asset('assets/home_banner_image.png'),
          ),
        ],
      ),
    );
  }

  Widget _board(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                softWrap: true,
                textAlign: TextAlign.start,
                'Serviços',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.spaceEvenly,
            direction: Axis.horizontal,
            spacing: 16,
            runSpacing: 16,
            children: [
              DashboardButton(
                backgroundColor: PetCareTheme.orange_100,
                label: 'Meus Pets',
                icon: Icons.pets,
                onPressed: () => {
                  _navigate(context, RouteConstants.pets),
                },
              ),
              DashboardButton(
                backgroundColor: PetCareTheme.pink_900,
                label: 'Histórico de Vacinação',
                icon: Icons.vaccines,
                onPressed: () => {
                  _navigate(context, RouteConstants.vaccinationHistory),
                },
              ),
              DashboardButton(
                backgroundColor: PetCareTheme.blue_300,
                label: 'Históricos de Atividades',
                icon: Icons.park,
                onPressed: () => {
                  _navigate(context, RouteConstants.toursAndActivities),
                },
              ),
              DashboardButton(
                backgroundColor: PetCareTheme.orange_300,
                label: 'Histórico Alimentação',
                icon: Icons.cookie,
                onPressed: () => {
                  _navigate(context, RouteConstants.feed),
                },
              ),
              DashboardButton(
                backgroundColor: PetCareTheme.pink_300,
                label: 'Histórico Medico',
                icon: Icons.medical_services,
                onPressed: () => {
                  _navigate(context, RouteConstants.medicHistory),
                },
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Image.asset(
                'assets/home_bottom_image.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
