import 'package:flutter/material.dart';
import 'package:petcare/themes/pet_care_theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: PetCareTheme.pink_100,
              ),
              child: Image.asset('assets/pet_care_icon.png'),
            ),
            SizedBox(height: 20),
            Text(
              'PetCare',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: PetCareTheme.pink_300,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'O app para pais de pet de \n primeira viagem',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: PetCareTheme.pink_100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
