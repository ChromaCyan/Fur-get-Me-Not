import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_status/adoption_status_bloc.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_status/adoption_status_repository.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_status/adoption_status_event.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_status/adoption_status_state.dart';
import 'package:fur_get_me_not/widgets/cards/adoption_status_card.dart';

class AdoptionStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdoptionStatusBloc(
        adoptionStatusRepository: AdoptionStatusRepository(),
      )..add(LoadAdoptionStatus()),
      child: Scaffold(
        body: BlocBuilder<AdoptionStatusBloc, AdoptionStatusState>(
          builder: (context, state) {
            if (state is AdoptionStatusLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AdoptionStatusLoaded) {
              final adoptionStatusList = state.adoptionStatusList;
              if (adoptionStatusList.isEmpty) {
                return Center(child: Text('No adoption statuses found.'));
              }
              return ListView.builder(
                itemCount: adoptionStatusList.length,
                itemBuilder: (context, index) {
                  final adoptionStatus = adoptionStatusList[index];
                  return AdoptionStatusCard(adoption: adoptionStatus);
                },
              );
            } else if (state is AdoptionStatusError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('No adoption status found.'));
            }
          },
        ),
      ),
    );
  }
}
