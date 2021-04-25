part of 'menu_cubit.dart';

class MenuState {
  ProfileResponse profileResponse;
  MenuState(this.profileResponse);
}

class MenuInitial extends MenuState {
  MenuInitial() : super(ProfileResponse());
}

class GetProfileState extends MenuState {
  GetProfileState(ProfileResponse profileResponse, MenuState state)
      : super(profileResponse);
}
