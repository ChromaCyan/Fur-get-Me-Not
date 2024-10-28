import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_management/pet_management_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_management/pet_management_event.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_management/pet_management_state.dart';
import 'package:fur_get_me_not/adoptee/screens/pet_management/pet_details_screen.dart';
import 'package:fur_get_me_not/widgets/cards/admin_pet_card.dart';
import 'package:fur_get_me_not/widgets/headers/search.dart';
import 'package:fur_get_me_not/widgets/headers/categories.dart';
import 'add_pet_form.dart';

class PetManagementScreen extends StatefulWidget {
  const PetManagementScreen({super.key});

  @override
  State<PetManagementScreen> createState() => _PetManagementScreenState();
}

class _PetManagementScreenState extends State<PetManagementScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  String selectedBreed = 'All';

  @override
  void initState() {
    super.initState();
    // Load pet management data when the screen initializes
    context.read<PetManagementBloc>().add(LoadPetManagementEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // Make the content scrollable
        physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Your pets listed',
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
              const SizedBox(height: 20), // Add space before the pets grid

              // Wrap the BlocBuilder and its content in a Padding
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<PetManagementBloc, PetManagementState>(
                  builder: (context, state) {
                    // Show loading indicator when in the loading state
                    if (state is PetManagementLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    // When pets are loaded, display them in a grid view
                    else if (state is PetManagementLoaded) {
                      // Filter pets based on selected breed and search query
                      final filteredPets = state.pets.where((pet) {
                        final matchesBreed = selectedBreed == 'All' ||
                            pet.breed == selectedBreed;
                        final matchesQuery = pet.name.toLowerCase().contains(
                            searchQuery.toLowerCase());
                        return matchesBreed && matchesQuery;
                      })
                          .toList()
                          .reversed
                          .toList();

                      // If no pets are available after filtering, show a message
                      if (filteredPets.isEmpty) {
                        return const Center(
                          child: Text('No pets available for your selection.'),
                        );
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        // Allow the GridView to take up space based on its content
                        physics: const NeverScrollableScrollPhysics(),
                        // Disable GridView scrolling
                        itemCount: filteredPets.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          final pet = filteredPets[index];
                          return PetCard(
                            pet: pet,
                            size: size,
                            onTap: () {
                              // Navigate to PetDetailsPage when a pet card is tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PetDetailsPage(
                                        petId: pet.id ?? '',
                                      ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                    // Display error message if there was an error loading the pets
                    else if (state is PetManagementError) {
                      return Center(child: Text(state.message));
                    }
                    // Handle unknown state
                    else {
                      return const Center(child: Text('Error: Unknown state'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // Floating action button for adding a new pet
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPetForm(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
