part of 'summary_cubit.dart';

class SummaryState {
  SummaryResponse summaryResponse;
  bool isLoading;

  SummaryState(this.summaryResponse, this.isLoading);

  SummaryState copyWith({
    SummaryResponse summaryResponse,
    bool isLoading,
  }) {
    return SummaryState(
      summaryResponse ?? this.summaryResponse,
      isLoading ?? this.isLoading,
    );
  }

  SummaryState.from(SummaryState state) {
    summaryResponse = state.summaryResponse;
    isLoading = state.isLoading;
  }
}

class SummaryInitial extends SummaryState {
  SummaryInitial() : super(null, false);
}

class GetSummarySuccessState extends SummaryState {
  GetSummarySuccessState(SummaryResponse summaryResponse, SummaryState state)
      : super.from(state.copyWith(summaryResponse: summaryResponse));
}
