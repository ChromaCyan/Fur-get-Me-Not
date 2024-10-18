import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/authentication/repositories/auth_repository.dart';
import 'package:fur_get_me_not/authentication/models/user.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

// Events
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfile extends ProfileEvent {
  final String userId;

  const FetchProfile(this.userId);

  @override
  List<Object> get props => [userId];
}

class UpdateProfile extends ProfileEvent {
  final String userId;
  final String firstName;
  final String lastName;
  final String address;
  final String? profileImage;

  const UpdateProfile({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.address,
    this.profileImage,
  });

  @override
  List<Object> get props => [
    userId,
    firstName,
    lastName,
    address,
    profileImage ?? '',
  ];
}

// States
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> profileData;

  const ProfileLoaded(this.profileData);

  @override
  List<Object> get props => [profileData];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository authRepository;

  ProfileBloc({required this.authRepository}) : super(ProfileInitial()) {
    on<FetchProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await authRepository.getProfileById(event.userId);
        if (profile['success']) {
          emit(ProfileLoaded(profile['profile']));
        } else {
          emit(ProfileError(profile['message']));
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        // Update the profile with the provided data
        await authRepository.updateProfile(
          userId: event.userId,
          firstName: event.firstName,
          lastName: event.lastName,
          address: event.address,
          profileImage: event.profileImage,
        );

        // Fetch the updated profile to confirm changes
        final profile = await authRepository.getProfileById(event.userId);
        emit(ProfileLoaded(profile['profile']));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
