import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_browse/adoption_browse_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_browse/adoption_browse_event.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_browse/adoption_browse_state.dart';
import 'package:fur_get_me_not/adopter/screens/adoption_list/pet_details_screen.dart';
import 'package:fur_get_me_not/widgets/cards/pet_card.dart';
import 'package:fur_get_me_not/widgets/headers/banner_card.dart';
import 'package:fur_get_me_not/adopter/models/widget/carousel.dart';

class AdoptionScreen extends StatefulWidget {
  const AdoptionScreen({super.key});

  @override
  State<AdoptionScreen> createState() => _AdoptionScreenState();
}

class _AdoptionScreenState extends State<AdoptionScreen> {
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
        child: Column(
          children: [
            const SizedBox(height: 20),
            ReusableCarousel(items: carouselData),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<AdoptionBrowseBloc, AdoptionBrowseState>(
                builder: (context, state) {
                  if (state is AdoptionBrowseLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AdoptionBrowseLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        itemCount: state.pets.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PetDetailsPage(petId: pet.id),
                                ),
                              );
                            },
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
            ),
          ],
        ),
      ),
    );
  }
}
