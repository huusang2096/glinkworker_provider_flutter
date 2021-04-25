part of 'earning_cubit.dart';

class EarningState {
  RideResponse rideResponse;
  double total;
  double percent;
  bool isLoading;

  EarningState(
    this.rideResponse,
    this.total,
    this.percent,
    this.isLoading,
  );

  EarningState copyWith({
    RideResponse rideResponse,
    double total,
    double percent,
    bool isLoading,
  }) {
    return EarningState(
      rideResponse ?? this.rideResponse,
      total ?? this.total,
      percent ?? this.percent,
      isLoading ?? this.isLoading,
    );
  }

  EarningState.from(EarningState state) {
    rideResponse = state.rideResponse;
    total = state.total;
    percent = state.percent;
    isLoading = state.isLoading;
  }
}

class EarningInitial extends EarningState {
  EarningInitial() : super(null, 0, 0, false);
}

class GetRideSuccessState extends EarningState {
  GetRideSuccessState(
    EarningState state,
    RideResponse rideResponse,
    double total,
    double percent,
  ) : super.from(state.copyWith(
          rideResponse: rideResponse,
          total: total,
          percent: percent,
        ));
}
