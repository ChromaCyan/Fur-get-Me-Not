import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/adoption_request/adoption_request_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/adoption_request/adoption_request_event.dart';
import 'package:fur_get_me_not/adoptee/bloc/adoption_request/adoption_request_state.dart';
import 'package:fur_get_me_not/adoptee/repositories/adoption_request/adoption_request_repository.dart';
import 'package:fur_get_me_not/widgets/cards/adoption_request_card.dart';

class AdoptionRequestListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdoptionRequestBloc(
        repository: AdoptionRequestRepository(),
      )..add(LoadAdoptionRequests()),
      child: Scaffold(
        body: BlocBuilder<AdoptionRequestBloc, AdoptionRequestState>(
          builder: (context, state) {
            if (state is AdoptionRequestLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AdoptionRequestLoaded) {
              if (state.requests.isEmpty) {
                return Center(child: Text('No adoption requests found.'));
              }
              return ListView.builder(
                itemCount: state.requests.length,
                itemBuilder: (context, index) {
                  final adoptionRequest = state.requests[index];
                  return AdoptionRequestCard(
                    adoptionRequest: adoptionRequest,
                    onStatusChanged: (newStatus) {
                      BlocProvider.of<AdoptionRequestBloc>(context).add(
                        UpdateAdoptionRequestStatus(
                          index: index,
                          newStatus: newStatus,
                          requestId: adoptionRequest.requestId,
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is AdoptionRequestError) {
              return Center(child: Text('Error loading requests: ${state.message}'));
            }
            return Center(child: Text('No adoption requests found.'));
          },
        ),
      ),
    );
  }
}
