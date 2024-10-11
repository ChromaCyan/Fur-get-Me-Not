import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fur_get_me_not/adopter/models/widget/carousel.dart';

class ReusableCarousel extends StatelessWidget {
  final List<CarouselItem> items;

  ReusableCarousel({required this.items});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlay: true,
        viewportFraction: 0.8,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: items.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade900,
                  blurRadius: 14,
                  offset: const Offset(2, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(40),
              color: Color(0xFFFE9879),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          item.text,
                          style: TextStyle(
                            fontSize: 23,
                            wordSpacing: 2.5,
                            height: 1.4,
                            letterSpacing: -0.7,
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Image.asset(item.image),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
