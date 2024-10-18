import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_browse/adoption_browse_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_browse/adoption_browse_event.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_browse/adoption_browse_state.dart';
import 'package:fur_get_me_not/adopter/screens/adoption_list/pet_details_screen.dart';
import 'package:fur_get_me_not/widgets/cards/pet_card.dart';
import 'package:fur_get_me_not/widgets/headers/banner_card.dart';
import 'package:fur_get_me_not/adopter/models/widget/carousel.dart';
import 'package:fur_get_me_not/widgets/navigations/drawer.dart'; // Import the AppDrawer

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
      drawer: AppDrawer(), // Add the AppDrawer here
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 350.0, // Adjust height based on carousel size
              floating: false,
              pinned: true,
              centerTitle: true, // Center the title
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(bottom: 16.0), // Padding to position title
                title: const Text(
                  'Fur-Get-Me Not',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                collapseMode: CollapseMode.pin,
                background: Container(
                  width: size.width,
                  height: size.height,
                  child: ReusableCarousel(items: carouselData),
                    // Image.asset(
                    //   'assets/images/adoption_banner.jpg',
                    //   fit: BoxFit.cover,
                    //   height: 150, // Adjust the banner height
                    //   width: double.infinity,
                    // ),
                    
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Adoption Listing',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Spacing between text and grid
                ],
              ),
            ),
            BlocBuilder<AdoptionBrowseBloc, AdoptionBrowseState>(
              builder: (context, state) {
                if (state is AdoptionBrowseLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is AdoptionBrowseLoaded) {
                  return SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
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
                        childCount: state.pets.length,
                      ),
                    ),
                  );
                } else if (state is AdoptionBrowseError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(state.message)),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text('Error: Unknown state')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
