import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/pet_list/pet_list_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/pet_list/pet_list_event.dart';
import 'package:fur_get_me_not/adopter/screens/pet_list/pet_details_screen.dart';
import 'package:fur_get_me_not/adopter/bloc/pet_list/pet_list_state.dart';
import 'package:fur_get_me_not/widgets/cards/adopted_pet_card.dart';
import 'package:fur_get_me_not/widgets/headers/banner_card.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
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
        child: Column(
          children: [
            const SizedBox(height: 20),
            BlocBuilder<PetListBloc, PetListState>(
              builder: (context, state) {
                if (state is PetListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PetListLoaded) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(state.pets.length, (index) {
                        final adoptedPet = state.pets[index];
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
                      }),
                    ),
                  );
                } else if (state is PetListError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('Error: Unknown state'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
