part of 'service_cubit.dart';

class ServiceState {
  List<ProviderPastTripResponse> pastTrips;
  List<ProviderOngoingTripDetailResponse> upcomingTrips;
  TripResponse ongoingTrips;
  bool isLoading;
  ServiceState(
      {this.pastTrips, this.upcomingTrips, this.ongoingTrips, this.isLoading});

  ServiceState.from(ServiceState state) {
    this.pastTrips = state.pastTrips;
    this.upcomingTrips = state.upcomingTrips;
    this.ongoingTrips = state.ongoingTrips;
    this.isLoading = state.isLoading;
  }

  ServiceState copyWith(
      {List<ProviderPastTripResponse> pastTrips,
      List<ProviderOngoingTripDetailResponse> upgoingTrips,
      TripResponse ongoingTrips,
      bool isLoading}) {
    return ServiceState(
      upcomingTrips: upcomingTrips ?? this.upcomingTrips,
      ongoingTrips: ongoingTrips ?? this.ongoingTrips,
      pastTrips: pastTrips ?? this.pastTrips,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ServiceInitial extends ServiceState {
  ServiceInitial()
      : super(
          pastTrips: null,
          ongoingTrips: null,
          isLoading: false,
        );
}

class GetServiceHistory extends ServiceState {
  GetServiceHistory(
    List<ProviderPastTripResponse> pastTrips,
    List<ProviderOngoingTripDetailResponse> upcomingTrips,
    TripResponse ongoingTrips,
    ServiceState state,
  ) : super.from(state.copyWith(
            pastTrips: pastTrips,
            ongoingTrips: ongoingTrips,
            upgoingTrips: upcomingTrips));
}

class RefreshDataState extends ServiceState {
  RefreshDataState(ServiceState state) : super.from(state.copyWith());
}

class CancelTripState extends ServiceState {
  CancelTripState(ServiceState state) : super.from(state.copyWith());
}
