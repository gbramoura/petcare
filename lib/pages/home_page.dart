import 'package:flutter/material.dart';
import 'package:petcare/themes/pet_care_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
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

  Widget _body() {
    return Center(
      child: Column(
        children: [
          _banner(),
        ],
      ),
    );
  }

  Widget _banner() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.only(left: 16, right: 16),
      height: 130,
      decoration: BoxDecoration(
        color: PetCareTheme.pink_300,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Cuidados com o \nseu Pet na sua mão',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: PetCareTheme.white_50,
            ),
          ),
          Image.asset('assets/home_banner_image.png'),
        ],
      ),
    );
  }
}
