import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_management/pet_management_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_management/pet_management_event.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_management/pet_management_state.dart';
import 'package:fur_get_me_not/adoptee/screens/pet_management/edit_pet_form.dart';
import 'package:fur_get_me_not/adoptee/screens/pet_management/pet_details_screen.dart';
import 'package:fur_get_me_not/widgets/cards/admin_pet_card.dart';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';
import 'package:fur_get_me_not/adoptee/screens/adoptee_profile/adoptee_profile.dart'; // Import ProfilePage
import 'add_pet_form.dart';

class PetManagementScreen extends StatefulWidget {
  const PetManagementScreen({super.key});

  @override
  State<PetManagementScreen> createState() => _PetManagementScreenState();
}

class _PetManagementScreenState extends State<PetManagementScreen> {
  @override
  void initState() {
    super.initState();
    // Load pet management data when the screen initializes
    context.read<PetManagementBloc>().add(LoadPetManagementEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile IconButton added above the header widgets
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.account_circle, size: 30),
                    onPressed: () {
                      // Navigate to ProfilePage when the icon is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Placeholder for carousel or other header widgets if needed
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<PetManagementBloc, PetManagementState>(
                builder: (context, state) {
                  // Show loading indicator when in the loading state
                  if (state is PetManagementLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // When pets are loaded, display them in a grid view
                  else if (state is PetManagementLoaded) {
                    // If no pets are available, show a message
                    if (state.pets.isEmpty) {
                      return const Center(
                        child: Text('No pets available. Add a pet to manage.'),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        itemCount: state.pets.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          final pet = state.pets[index];
                          return PetCard(
                            pet: pet,
                            size: size,
                            onTap: () {
                              // Navigate to PetDetailsPage when a pet card is tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PetDetailsPage(
                                    petId: pet.id ?? '',
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
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
