part of 'profile_cubit.dart';

class ProfileState {
  ProfileResponse profileResponse;
  UpdateProfileRequest profileRequest;
  bool inAsyncCall;
  ProfileState({this.profileResponse, this.profileRequest, this.inAsyncCall});

  ProfileState copyWith(
      {ProfileResponse profileResponse,
      UpdateProfileRequest profileRequest,
      bool inAsyncCall}) {
    return ProfileState(
        profileResponse: profileResponse ?? this.profileResponse,
        profileRequest: profileRequest ?? this.profileRequest,
        inAsyncCall: inAsyncCall ?? this.inAsyncCall);
  }

  ProfileState.from(ProfileState state) {
    this.profileResponse = state.profileResponse;
    this.profileRequest = state.profileRequest;
    this.inAsyncCall = state.inAsyncCall;
  }
}

class ProfileInitial extends ProfileState {
  ProfileInitial()
      : super(
            profileResponse: ProfileResponse(),
            profileRequest: UpdateProfileRequest(),
            inAsyncCall: false);
}

class GetProfileSuccessState extends ProfileState {
  GetProfileSuccessState(ProfileResponse profileResponse, ProfileState state)
      : super.from(state.copyWith(profileResponse: profileResponse));
}

class UpdateProfileSuccessState extends ProfileState {
  UpdateProfileSuccessState(ProfileResponse profileResponse, ProfileState state)
      : super.from(state.copyWith(profileResponse: profileResponse));
}

class LogoutSuccessState extends ProfileState {
  LogoutSuccessState(ProfileState state) : super.from(state);
}

class ProfileUpdateState extends ProfileState {
  ProfileUpdateState(UpdateProfileRequest profileRequest, ProfileState state)
      : super.from(state.copyWith(profileRequest: profileRequest));
}
