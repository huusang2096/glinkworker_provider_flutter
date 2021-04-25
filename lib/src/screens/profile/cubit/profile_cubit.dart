import 'package:glinkwok_provider/locator.dart';
import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/model/profile_response.dart';
import 'package:glinkwok_provider/src/model/update_profile_request.dart';
import 'package:glinkwok_provider/src/services/trip_service.dart';
import 'package:simplest/simplest.dart';

part 'profile_state.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  getProfile() async {
    try {
      emit(state.copyWith(inAsyncCall: true));
      final profileResponse = await dataRepository.getProfile();
      emit(GetProfileSuccessState(profileResponse, state));
    } catch (e) {
      handleAppError(e);
      logger.e(e);
    }
    emit(state.copyWith(inAsyncCall: false));
  }

  submitUpdate({String countryCode, mobile, firstName, lastName, email}) async {
    try {
      emit(state.copyWith(inAsyncCall: true));
      // Do not allow to update phone or email
      final profileResponse = await dataRepository.updateProfile(
        first_name: state.profileRequest.firstName,
        last_name: state.profileRequest.lastName,
        avatar: state.profileRequest.avatar,
      );
      snackbarService.showSnackbar(message: 'update_profile_success'.tr);
      emit(UpdateProfileSuccessState(profileResponse, state));
    } catch (e) {
      handleAppError(e);
    }
    emit(state.copyWith(inAsyncCall: false));
  }

  logout() async {
    try {
      emit(state.copyWith(inAsyncCall: true));
      String userId = appPref.getUserId();
      await dataRepository.logout(userId: userId);
      await appPref.logout();
      locator<TripService>().stopService();
      emit(LogoutSuccessState(state));
    } catch (e) {
      handleAppError(e);
    }
    emit(state.copyWith(inAsyncCall: false));
  }

  updateFirstName(String firstName) {
    UpdateProfileRequest request = state.profileRequest;
    request.firstName = firstName;
    emit(ProfileUpdateState(request, state));
  }

  updateLastName(String lastName) {
    UpdateProfileRequest request = state.profileRequest;
    request.lastName = lastName;
    emit(ProfileUpdateState(request, state));
  }

  updatePhone(String phone) {
    UpdateProfileRequest request = state.profileRequest;
    request.mobile = phone;
    emit(ProfileUpdateState(request, state));
  }

  updateCountryCode(String countryCode) {
    UpdateProfileRequest request = state.profileRequest;
    request.countryCode = countryCode;
    emit(ProfileUpdateState(request, state));
  }

  updateEmail(String email) {
    UpdateProfileRequest request = state.profileRequest;
    request.email = email;
    emit(ProfileUpdateState(request, state));
  }

  onSelectImageFromDevice() async {
    try {
      final file = await locator<MediaService>().pickImage();
      if (file == null) {
        return;
      }
      final _currentRequest = state.profileRequest;
      _currentRequest.avatar = file;
      emit(state.copyWith(profileRequest: _currentRequest));
    } catch (error) {
      logger.e(error);
      showErrorMessage('unable_to_select_image'.tr);
    }
  }
}
