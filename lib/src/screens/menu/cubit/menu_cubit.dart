import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/model/profile_response.dart';
import 'package:simplest/simplest.dart';

part 'menu_state.dart';

class MenuCubit extends BaseCubit<MenuState> {
  MenuCubit() : super(MenuInitial());

  getProfile() async {
    try {
      if (appPref.user != null) {
        emit(MenuState(appPref.user)); // Fetch from local first
      }
      final profileResponse = await dataRepository.getProfile();
      appPref.user = profileResponse;
      emit(GetProfileState(profileResponse, state));
    } catch (e) {
      handleAppError(e);
      logger.e(e);
    }
  }
}
