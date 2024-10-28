import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adopter/models/pet_list/adopted_pet.dart';
import 'package:fur_get_me_not/adopter/bloc/adopted_pet_details/adopted_pet_details_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adopted_pet_details/adopted_pet_details_event.dart';
import 'package:fur_get_me_not/adopter/bloc/adopted_pet_details/adopted_pet_details_state.dart';
import 'package:fur_get_me_not/widgets/buttons/back_button.dart';
import 'package:fur_get_me_not/widgets/adopted_pet_details/medical_card.dart';
import 'package:fur_get_me_not/widgets/adopted_pet_details/vaccine_card.dart';
import 'package:fur_get_me_not/widgets/adopted_pet_details/pet_info.dart';
import 'package:fur_get_me_not/widgets/pet_details/toggle_button.dart';

class PetDetailsPage extends StatelessWidget {
  final String petId;

  const PetDetailsPage({Key? key, required this.petId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the bloc
    final petDetailsBloc = BlocProvider.of<AdoptedPetDetailsBloc>(context);
    // Dispatch an event to load pet details
    petDetailsBloc.add(LoadAdoptedPetDetailsEvent(petId: petId));

    return Scaffold(
      body: BlocBuilder<AdoptedPetDetailsBloc, AdoptedPetDetailsState>(
        builder: (context, state) {
          if (state is AdoptedPetDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AdoptedPetDetailsLoaded) {
            final pet = state.pet;
            return _PetDetailsView(
                pet: pet, showPetInfo: state.showPetInfo); // Pass showPetInfo
          } else if (state is AdoptedPetDetailsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }
}

class _PetDetailsView extends StatefulWidget {
  final AdoptedPet pet; // Fixed variable name
  final bool showPetInfo;

  const _PetDetailsView(
      {Key? key, required this.pet, required this.showPetInfo})
      : super(key: key);

  @override
  State<_PetDetailsView> createState() => _PetDetailsViewState();
}

class _PetDetailsViewState extends State<_PetDetailsView> {
  late bool showPetInfo; // Use late initialization
  bool showVaccineHistory = false;
  late ScrollController _scrollController;
  double _offset = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the state based on the value from the Bloc
    showPetInfo = widget.showPetInfo;
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _offset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: Stack(
        children: [
          itemsImageAndBackground(size),
          // BackButtonWidget(),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: size.height * 0.5,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: size.height * 0.52,
                      width: size.width,
                      decoration: const BoxDecoration(
                        // gradient: LinearGradient(
                        //   colors: [Color(0xFFFE9879), Color(0xFF21899C)],
                        //   begin: Alignment.topLeft,
                        //   end: Alignment.bottomRight,
                        // ),

                        color: Color(0xFFF5E6CA),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              nameAddressAndFavoriteButton(),
                              const SizedBox(height: 15),
                              // OwnerInfo(
                              //   firstName: widget.pet.adoptee.firstName,
                              //   lastName: widget.pet.adoptee.lastName,
                              //   gender: widget.pet.gender,
                              //   profileImage: widget.pet.adoptee.profileImage ?? 'images/image2.png',
                              //   chatId: widget.pet.adoptee.chatId,
                              //   otherUserId: widget.pet.adoptee.id,
                              // ),
                              // const SizedBox(height: 20),

                              // Pet Info TextButton
                              const Text(
                                'Pet Info',
                                style: TextStyle(
                                  fontSize: 20, 
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),

                              // PetInfoWidget displayed by default
                              PetInfoWidget(pet: widget.pet),
                              const SizedBox(height: 20),
                              
                              buildToggleButtons(),
                              // const SizedBox(height: 20),
                              // adoptMeButton(context),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 15,
            child: Container(
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(17.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: BackButtonWidget(
                onPressed: () =>
                    Navigator.of(context).pop(), // Ensures navigation back
                // color: Colors.black,
                iconSize: 30.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget nameAddressAndFavoriteButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 300, // Set your desired fixed width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.pet.name,
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                softWrap: true, // Allow text to wrap
              ),
            ],
          ),
        ),
      ],
    );
  }


  // Widget buildToggleButtons() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       ToggleButton(
  //         label: 'Pet Info',
  //         isSelected: showPetInfo,
  //         onPressed: () {
  //           setState(() {
  //             showPetInfo = true;
  //             showVaccineHistory = false;
  //           });
  //           // Dispatch the event to toggle view
  //           BlocProvider.of<AdoptedPetDetailsBloc>(context)
  //               .add(ToggleAdoptedPetInfoViewEvent(showPetInfo: true));
  //         },
  //       ),
  //       ToggleButton(
  //         label: 'Vaccine History',
  //         isSelected: showVaccineHistory,
  //         onPressed: () {
  //           setState(() {
  //             showPetInfo = false;
  //             showVaccineHistory = true;
  //           });
  //           // Dispatch the event to toggle view
  //           BlocProvider.of<AdoptedPetDetailsBloc>(context)
  //               .add(ToggleAdoptedPetInfoViewEvent(showPetInfo: false));
  //         },
  //       ),
  //       ToggleButton(
  //         label: 'Medical History',
  //         isSelected: !showPetInfo && !showVaccineHistory,
  //         onPressed: () {
  //           setState(() {
  //             showPetInfo = false;
  //             showVaccineHistory = false;
  //           });
  //           // Dispatch the event to toggle view
  //           BlocProvider.of<AdoptedPetDetailsBloc>(context)
  //               .add(ToggleAdoptedPetInfoViewEvent(showPetInfo: false));
  //         },
  //       ),
  //     ],
  //   );
  // }

    Widget buildToggleButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Adjust radius
            ),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16), // Adjust size
            backgroundColor: Color(0xFF21899C), // Change color
            elevation: 5,
          ).copyWith(
            overlayColor: MaterialStateProperty.all(Color(0xFFFE9879)),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Use min size for dialog
                      children: [
                        VaccineHistoryWidget(vaccineHistory: widget.pet.vaccineHistory),
                        const SizedBox(height: 10), // Spacing before the button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Close', style: TextStyle(color: Colors.red)), // Customize text style if needed
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Text('Vaccine History', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Adjust radius
            ),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16), // Adjust size
            backgroundColor: Color(0xFF21899C), // Change color
            elevation: 5,
          ).copyWith(
            overlayColor: MaterialStateProperty.all(Color(0xFFFE9879)),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Use min size for dialog
                      children: [
                        MedicalHistoryWidget(medicalHistory: widget.pet.medicalHistory),
                        const SizedBox(height: 10), // Spacing before the button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Close', style: TextStyle(color: Colors.red)), // Customize text style if needed
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Text('Medical History', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Container itemsImageAndBackground(Size size) {
    return Container(
      height: size.height * 0.50,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
      ),
      child: Hero(
        tag: widget.pet.petImageUrl,
        child: Image.network(
          widget.pet.petImageUrl,
          height: size.height * 0.5,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Container itemsImageAndBackground(Size size) {
  //   return Container(
  //     height: size.height * 0.50,
  //     width: size.width,
  //     decoration: BoxDecoration(
  //       color: Colors.grey.withOpacity(0.5),
  //     ),
  //     child: Stack(
  //       children: [
  //         Positioned(
  //           left: -60,
  //           top: 30,
  //           child: Transform.rotate(
  //             angle: -11.5,
  //             child: Image.asset(
  //               'images/pet-cat2.png',
  //               color: Colors.black,
  //               height: 55,
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           right: -60,
  //           bottom: 0,
  //           child: Transform.rotate(
  //             angle: 12,
  //             child: Image.asset(
  //               'images/pet-cat2.png',
  //               color: Colors.black,
  //               height: 55,
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           bottom: 10,
  //           left: 0,
  //           right: 0,
  //           child: Hero(
  //             tag: widget.pet.petImageUrl,
  //             child: Image.network(
  //               widget.pet.petImageUrl,
  //               height: size.height * 0.45,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // ClipRRect moreInfo(
  //     Color pawColor, Color backgroundColor, String title, String value) {
  //   return ClipRRect(
  //     borderRadius: BorderRadius.circular(20),
  //     child: Stack(
  //       children: [
  //         Positioned(
  //           bottom: -20,
  //           right: -20,
  //           child: Container(
  //             height: 50,
  //             width: 50,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               color: backgroundColor,
  //             ),
  //           ),
  //         ),
  //         Container(
  //           height: 60,
  //           width: 100,
  //           padding: const EdgeInsets.all(10),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(20),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(0.2),
  //                 blurRadius: 10,
  //                 spreadRadius: 2,
  //                 offset: const Offset(0, 3),
  //               ),
  //             ],
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 title,
  //                 style: const TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //               const SizedBox(height: 5),
  //               Text(
  //                 value,
  //                 style: const TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
