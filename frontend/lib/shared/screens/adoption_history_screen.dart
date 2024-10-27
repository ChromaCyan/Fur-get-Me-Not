import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/shared/blocs/adoption_history_bloc.dart';
import 'package:fur_get_me_not/shared/repository/adoption_history_repository.dart';
import 'package:fur_get_me_not/widgets/cards/adoption_history_card.dart';
import 'package:fur_get_me_not/widgets/headers/app_bar.dart';

class AdoptionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdoptionHistoryBloc(
        adoptionHistoryRepository: AdoptionHistoryRepository(),
      )..add(FetchAdoptionHistory()),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Adoption History',
          hasBackButton: true,
          onBackButtonPressed: () => Navigator.of(context).pop(),
        ),
        body: BlocBuilder<AdoptionHistoryBloc, AdoptionHistoryState>(
          builder: (context, state) {
            if (state is AdoptionHistoryLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AdoptionHistoryLoaded) {
              final adoptionHistoryList = state.adoptionHistory;
              if (adoptionHistoryList.isEmpty) {
                return Center(child: Text('No adoption history found.'));
              }
              return ListView.builder(
                itemCount: adoptionHistoryList.length,
                itemBuilder: (context, index) {
                  final adoptionHistory = adoptionHistoryList[index];
                  return AdoptionHistoryCard(
                    adoptionHistory: adoptionHistory,
                  );
                },
              );
            } else if (state is AdoptionHistoryError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('No adoption history found.'));
            }
          },
        ),
      ),
    );
  }
}
