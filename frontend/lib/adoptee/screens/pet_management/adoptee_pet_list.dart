import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_management/pet_management_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_management/pet_management_state.dart';
import 'package:fur_get_me_not/adopter/screens/adoption_list/pet_details_screen.dart';
import 'package:fur_get_me_not/widgets/cards/admin_pet_card.dart';
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
            BlocBuilder<PetManagementBloc, PetManagementState>(
              builder: (context, state) {
                if (state is PetManagementLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PetManagementLoaded) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(state.pets.length, (index) {
                        final pet = state.pets[index];
                        return PetCard(
                          pet: pet,
                          size: size,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PetDetailsPage(petId: pet.id),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  );
                } else if (state is PetManagementError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('Error: Unknown state'));
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
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
