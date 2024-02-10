import 'package:bookmytime/tools/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class UpcomingCard extends StatelessWidget {
  const UpcomingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallete.kWhiteColor,
      ),
      child: FlutterCarousel(
          items: [
            Image.asset(
              'assets/images/plant_care3.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/plant_care4.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/helping_to_traverse.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/entraide.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/equipe_1#.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/soin_des_animaux.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/talk_people.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
          options: CarouselOptions(
            height: 200,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            autoPlay: true,
            enableInfiniteScroll: true,
            autoPlayInterval: const Duration(seconds: 2),
            autoPlayAnimationDuration: const Duration(seconds: 1),
          )),
    );
  }
}
