import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/adoption_status/adoption_status_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/adoption_status/adoption_status_state.dart';
import 'package:fur_get_me_not/models/adoption_status.dart';

class AdoptionStatusScreen extends StatefulWidget {
  @override
  _AdoptionStatusScreenState createState() => _AdoptionStatusScreenState();
}

class _AdoptionStatusScreenState extends State<AdoptionStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AdoptionStatusBloc, AdoptionStatusState>(
        builder: (context, state) {
          if (state is AdoptionStatusInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AdoptionStatusLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AdoptionStatusLoaded) {
            final adoptions = state.adoptions;
            return ListView.builder(
              itemCount: adoptions.length,
              itemBuilder: (context, index) {
                final adoption = adoptions[index];
                return ListTile(
                  title: Text(adoption.petName),
                  subtitle: Text('Owner: ${adoption.ownerName}, Status: ${adoption.status}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          Navigator.pushNamed(context, '/adoption_details', arguments: adoption);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is AdoptionStatusError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No adoptions found.'));
          }
        },
      ),
    );
  }
}
