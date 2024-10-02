// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fur_get_me_not/bloc/adopter/pet_details/pet_details_bloc.dart';
// import 'package:fur_get_me_not/bloc/adopter/pet_details/pet_details_event.dart';
// import 'package:fur_get_me_not/bloc/adopter/pet_details/pet_details_state.dart';
// import 'package:fur_get_me_not/models/pet.dart';
// import 'package:fur_get_me_not/repositories/pet_repository.dart';
// import 'package:fur_get_me_not/screens/widgets/pet_detail_card.dart';
//
// class PetsDetailPage extends StatelessWidget {
//   final String petId;
//
//   const PetsDetailPage({super.key, required this.petId});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => PetDetailsBloc(
//         petRepository: context.read<PetRepository>(),
//       )..add(LoadPetDetailsEvent(petId: petId)), // Load pet details
//       child: Scaffold(
//         body: BlocBuilder<PetDetailsBloc, PetDetailsState>(
//           builder: (context, state) {
//             if (state is PetDetailsLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is PetDetailsLoaded) {
//               return PetDetailWidget(
//                 pet: state.pet,
//                 onAdopt: () {
//                   // Handle adoption logic here
//                 },
//               );
//             } else if (state is PetDetailsError) {
//               return Center(child: Text('Error: ${state.message}'));
//             }
//             return Container(); // Fallback if no valid state is provided
//           },
//         ),
//       ),
//     );
//   }
// }
