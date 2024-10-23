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
        viewportFraction: 1.0, // Fill the entire width
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 1600),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: items.map((item) {
        return Container(
          decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.shade900,
            //     blurRadius: 14,
            //     offset: const Offset(2, 3),
            //   ),
            // ],
            borderRadius: BorderRadius.circular(0), // No rounded corners
            color: const Color(0xFFFE9879),
          ),
          child: Stack(
            children: [
              // Image fills the entire container
              Positioned.fill(
                child: Image.asset(
                  item.image,
                  fit: BoxFit.cover, // Ensures the image covers the whole widget
                ),
              ),
              // Text overlay
              Positioned(
                bottom: 20, // Position text towards the bottom
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        item.text,
                        style: TextStyle(
                          fontSize: 18,
                          wordSpacing: 2,
                          height: 1.4,
                          letterSpacing: -0.7,
                          color: Colors.white, // Change text color to improve visibility
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center, // Center the text
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
