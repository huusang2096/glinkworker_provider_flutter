part of 'help_cubit.dart';

class HelpState {
  HelpResponse helpResponse;
  bool isLoading;

  HelpState(
    this.helpResponse,
    this.isLoading,
  );

  HelpState copyWith({
    HelpResponse helpResponse,
    bool isLoading,
  }) {
    return HelpState(
      helpResponse ?? this.helpResponse,
      isLoading ?? this.isLoading,
    );
  }

  HelpState.from(HelpState state) {
    helpResponse = state.helpResponse;
    isLoading = state.isLoading;
  }
}

class HelpInitial extends HelpState {
  HelpInitial() : super(null, false);
}

class GetHelpSuccessState extends HelpState {
  GetHelpSuccessState(HelpState state, HelpResponse helpResponse)
      : super.from(state.copyWith(helpResponse: helpResponse));
}
