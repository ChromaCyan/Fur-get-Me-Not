import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_browse/adoption_browse_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_browse/adoption_browse_event.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_browse/adoption_browse_state.dart';
import 'package:fur_get_me_not/adopter/screens/adoption_list/pet_details_screen.dart';
import 'package:fur_get_me_not/widgets/cards/pet_card.dart';
import 'package:fur_get_me_not/widgets/headers/search.dart';
import 'package:fur_get_me_not/adopter/models/widget/carousel.dart';
import 'package:fur_get_me_not/widgets/headers/banner_card.dart';
import 'package:fur_get_me_not/widgets/headers/categories.dart';

class AdoptionScreen extends StatefulWidget {
  const AdoptionScreen({super.key});

  @override
  State<AdoptionScreen> createState() => _AdoptionScreenState();
}

class _AdoptionScreenState extends State<AdoptionScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  String selectedBreed = 'All';

  @override
  void initState() {
    super.initState();
    context.read<AdoptionBrowseBloc>().add(LoadAdoptionBrowseEvent(filter: ''));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 340,
                height: 235,
                child: ReusableCarousel(items: carouselData),
                decoration: BoxDecoration(
                  color: Color(0xFFF5E6CA),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Adoption Listing',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomSearchBar(
                hintText: 'Search pets...',
                searchController: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                onClear: () {
                  setState(() {
                    searchController.clear();
                    searchQuery = '';
                  });
                },
                onSearch: () {},
              ),
              const SizedBox(height: 20),
              CategoryChip(
                categories: ['All', 'Dog', 'Cat'],
                selectedCategory: selectedBreed,
                onSelected: (String category) {
                  setState(() {
                    selectedBreed = category;
                  });
                },
              ),

              const SizedBox(height: 20),

              BlocBuilder<AdoptionBrowseBloc, AdoptionBrowseState>(
                builder: (context, state) {
                  if (state is AdoptionBrowseLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AdoptionBrowseLoaded) {
                    final filteredPets = state.pets.where((pet) {
                      final matchesBreed = selectedBreed == 'All' || pet.breed == selectedBreed;
                      final matchesQuery = pet.name.toLowerCase().contains(searchQuery.toLowerCase());
                      return matchesBreed && matchesQuery;
                    }).toList().reversed.toList();

                    if (filteredPets.isEmpty) {
                      return Center(child: Text('No pets found for your search.'));
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: filteredPets.length,
                        itemBuilder: (context, index) {
                          final pet = filteredPets[index];
                          return Center(
                            child: PetCard(
                              pet: pet,
                              size: size,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PetDetailsPage(petId: pet.id),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is AdoptionBrowseError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('Error: Unknown state'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

