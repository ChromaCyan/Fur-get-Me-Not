import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/pet_list/pet_list_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/pet_list/pet_list_event.dart';
import 'package:fur_get_me_not/adopter/screens/pet_list/pet_details_screen.dart';
import 'package:fur_get_me_not/adopter/bloc/pet_list/pet_list_state.dart';
import 'package:fur_get_me_not/widgets/cards/adopted_pet_card.dart';
import 'package:fur_get_me_not/widgets/headers/search.dart'; // Import the custom search bar

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Trigger event to load adopted pets when the screen initializes
    context.read<PetListBloc>().add(LoadPetListEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<PetListBloc, PetListState>(
          builder: (context, state) {
            if (state is PetListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PetListLoaded) {
              // Check if there are any pets
              if (state.pets.isEmpty) {
                return Center(
                  child: Text(
                    'You have no adopted pets, try to adopt one first!',
                    style: TextStyle(),
                  ),
                );
              }

              // Filter the pets based on the search query
              final filteredPets = state.pets.where((pet) {
                return pet.name.toLowerCase().contains(searchQuery.toLowerCase());
              }).toList();

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Custom search bar placed at the top
                      CustomSearchBar(
                        hintText: 'Search pets...',
                        searchController: searchController,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value; // Update search query
                          });
                        },
                        onClear: () {
                          setState(() {
                            searchController.clear();
                            searchQuery = ''; // Clear search query
                          });
                        },
                        onSearch: () {
                          // You can add additional search actions here if needed
                        },
                      ),
                      const SizedBox(height: 10),
                      const Center(
                        child: const Text("Your List of Pets", 
                          style: 
                          TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(), // GridView itself won't scroll
                        shrinkWrap: true, // Make GridView take only the necessary height
                        itemCount: filteredPets.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          final adoptedPet = filteredPets[index];
                          return AdoptedPetCard(
                            adoptedPet: adoptedPet,
                            size: size,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PetDetailsPage(petId: adoptedPet.id), // Pass the pet ID
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is PetListError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Error: Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
