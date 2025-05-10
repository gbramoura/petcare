import 'package:flutter/material.dart';
import 'package:petcare/constants/route_constants.dart';
import 'package:petcare/pages/feed_page.dart';
import 'package:petcare/pages/home_page.dart';
import 'package:petcare/pages/medic_history_page.dart';
import 'package:petcare/pages/pets_page.dart';
import 'package:petcare/pages/tours_and_activities_page.dart';
import 'package:petcare/pages/vaccination_history_page.dart';
import 'package:petcare/themes/pet_care_theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetCare',
      theme: petCareTheme,
      home: const HomePage(),
      routes: {
        RouteConstants.home: (context) => HomePage(),
        RouteConstants.pets: (context) => PetsPage(),
        RouteConstants.feed: (context) => FeedPage(),
        RouteConstants.medicHistory: (context) => MedicHistoryPage(),
        RouteConstants.vaccinationHistory: (context) =>
            VaccinationHistoryPage(),
        RouteConstants.toursAndActivities: (context) =>
            ToursAndActivitiesPage(),
      },
    );
  }
}
