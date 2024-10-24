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
  final File? profileImage; // Keep this as File to upload

  const UpdateProfile({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.address,
    this.profileImage, // Use the File object
  });

  @override
  List<Object> get props => [
    userId,
    firstName,
    lastName,
    address,
    profileImage?.path ?? '', // Update this to reflect the file path
  ];
}

// New Event for Logout
class ClearProfileEvent extends ProfileEvent {}

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
    // Fetch Profile Event
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

    // Update Profile Event
    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        // Directly call the updated method that handles image upload as well
        await authRepository.updateUserProfile(
          userId: event.userId,
          firstName: event.firstName,
          lastName: event.lastName,
          address: event.address,
          image: event.profileImage,  // Pass the File object
        );

        // Fetch updated profile
        final updatedProfile = await authRepository.getProfileById(event.userId);
        if (updatedProfile['success']) {
          emit(ProfileLoaded(updatedProfile['profile']));
        } else {
          emit(ProfileError(updatedProfile['message']));
        }
      } catch (e) {
        print('Profile update error: $e');
        emit(ProfileError(e.toString()));
      }
    });

    // Clear Profile Event (logout)
    on<ClearProfileEvent>((event, emit) {
      emit(ProfileInitial());
    });
  }
}
