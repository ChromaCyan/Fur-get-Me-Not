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
            borderRadius: BorderRadius.circular(25), // No rounded corners
            color: Colors.transparent,
          ),
          child: Stack(
            children: [
              // Image fills the entire container
              Center(
                child: Container(
                  width: 300, // Adjust the width as needed
                  height: 200, // Adjust the height as needed
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25), // Match the container's radius
                    child: Image.asset(
                      item.image,
                      fit: BoxFit.cover, // Ensures the image covers the whole widget
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2), // Darken the image with 50% opacity
                    borderRadius: BorderRadius.circular(25), // Match the container's radius
                  ),
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
                          color: Color(0xFFF5E6CA), // Change text color to improve visibility
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
