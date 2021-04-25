import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:meta/meta.dart';
import 'package:simplest/simplest.dart';

part 'languages_state.dart';

class LanguagesCubit extends BaseCubit<LanguagesState> {
  LanguagesCubit() : super(LanguagesInitial());

  onSelectLocale(Locale locale) {
    appPref.langCode = locale.languageCode;
    Get.updateLocale(locale);
    dataRepository.loadAuthHeader();
    emit(state);
  }
}
