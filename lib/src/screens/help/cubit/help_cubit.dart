import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/common/launch_url.dart';
import 'package:glinkwok_provider/src/model/help_response.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

part 'help_state.dart';

class HelpCubit extends BaseCubit<HelpState> {
  HelpCubit() : super(HelpInitial());

  getHelp() async {
    try {
      emit(state.copyWith(isLoading: true));
      final helpResponse = await dataRepository.getHelp();

      emit(GetHelpSuccessState(state, helpResponse));
    } catch (e) {
      showErrorMessage("get_help_failed".tr);
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> launchUrl(String path, UrlScheme urlScheme) async {
    try {
      emit(state.copyWith(isLoading: true));
      await launchURL(path, urlScheme);
    } catch (e) {
      showErrorMessage("launch_url_failed".tr);
    }
    emit(state.copyWith(isLoading: false));
  }
}
