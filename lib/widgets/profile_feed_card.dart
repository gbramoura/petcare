import 'package:flutter/material.dart';
import 'package:petcare/models/feed_model.dart';
import 'package:petcare/themes/pet_care_theme.dart';

class ProfileFeedCard extends StatelessWidget {
  final FeedModel feed;

  const ProfileFeedCard({
    super.key,
    required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PetCareTheme.orange_300,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            feed.name,
            softWrap: true,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${feed.weight.toString()} Quilos',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
