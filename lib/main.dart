import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petcare/constants/route_constants.dart';
import 'package:petcare/pages/feed_page.dart';
import 'package:petcare/pages/home_page.dart';
import 'package:petcare/pages/medic_history_page.dart';
import 'package:petcare/pages/pets_page.dart';
import 'package:petcare/pages/splash_page.dart';
import 'package:petcare/pages/tours_and_activities_page.dart';
import 'package:petcare/pages/vaccination_history_page.dart';
import 'package:petcare/themes/pet_care_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(App(page: SplashPage()));

  // TODO: Use this gap to load the data

  runApp(App(page: HomePage()));
}

class App extends StatelessWidget {
  final Widget page;

  const App({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetCare',
      debugShowCheckedModeBanner: false,
      theme: PetCareTheme.theme,
      home: page,
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
