part of 'home_cubit.dart';

class HomeState {
  ProfileResponse user;
  MenuItemType menu;
  TripResponse tripResponse;
  WaitingTimeResponse waitingTimeResponse;
  Set<Polyline> polylines;
  List<CancelReasonResponse> cancelReason;
  int selectedCancelReason;
  bool isOffline;
  bool isShowSlider;
  bool isShowLoading;
  bool isShowLocationHeader;
  bool isShowPanel;

  HomeState(
      {this.user,
      this.menu,
      this.tripResponse,
      this.waitingTimeResponse,
      this.cancelReason,
      this.selectedCancelReason = 0,
      this.isOffline = false,
      this.isShowSlider = false,
      this.isShowLoading = false,
      this.isShowLocationHeader = false,
      this.isShowPanel = false,
      this.polylines});

  HomeState copyWith(
      {ProfileResponse user,
      MenuItemType menu,
      TripResponse tripResponse,
      WaitingTimeResponse waitingTimeResponse,
      List<CancelReasonResponse> cancelReason,
      int selectedCancelReason,
      bool isOffline,
      bool isShowSlider,
      bool isShowLoading,
      bool isShowLocationHeader,
      bool isShowPanel,
      Set<Polyline> polylines}) {
    return HomeState(
        user: user ?? this.user,
        menu: menu ?? this.menu,
        tripResponse: tripResponse ?? this.tripResponse,
        waitingTimeResponse: waitingTimeResponse ?? this.waitingTimeResponse,
        cancelReason: cancelReason ?? this.cancelReason,
        selectedCancelReason: selectedCancelReason ?? this.selectedCancelReason,
        isOffline: isOffline ?? this.isOffline,
        isShowSlider: isShowSlider ?? this.isShowSlider,
        isShowLoading: isShowLoading ?? this.isShowLoading,
        isShowLocationHeader: isShowLocationHeader ?? this.isShowLocationHeader,
        isShowPanel: isShowPanel ?? this.isShowPanel,
        polylines: polylines ?? this.polylines);
  }

  HomeState.from(HomeState state) {
    this.user = state.user;
    this.menu = state.menu;
    this.tripResponse = state.tripResponse;
    this.waitingTimeResponse = state.waitingTimeResponse;
    this.cancelReason = state.cancelReason;
    this.selectedCancelReason = state.selectedCancelReason;
    this.isOffline = state.isOffline;
    this.isShowSlider = state.isShowSlider;
    this.isShowLoading = state.isShowLoading;
    this.isShowLocationHeader = state.isShowLocationHeader;
    this.isShowPanel = state.isShowPanel;
    this.polylines = state.polylines;
  }
}

class HomeInitial extends HomeState {
  HomeInitial()
      : super(
            menu: MenuItemType.header,
            isShowLoading: false,
            isShowLocationHeader: false);
}

class HomeUpdateScreen extends HomeState {
  HomeUpdateScreen(MenuItemType menu, HomeState state)
      : super.from(state.copyWith(menu: menu));
}

class HomeUpdateLocation extends HomeState {
  final Position position;

  HomeUpdateLocation(this.position, HomeState state) : super.from(state);
}

class ChangeSlider extends HomeState {
  ChangeSlider(bool isShowSlider, TripResponse tripResponse, HomeState state)
      : super.from(state.copyWith(
            isShowSlider: isShowSlider, tripResponse: tripResponse));
}

class IncommingRequestState extends HomeState {
  IncommingRequestState(TripResponse tripResponse, HomeState state)
      : super.from(state.copyWith(tripResponse: tripResponse));
}

class AcceptedTripRequestState extends HomeState {
  AcceptedTripRequestState(HomeState state) : super.from(state);
}

class StartedTripRequestState extends HomeState {
  StartedTripRequestState(HomeState state) : super.from(state);
}

class ArrivedState extends HomeState {
  ArrivedState(HomeState state) : super.from(state);
}

class ServiceDoneState extends HomeState {
  ServiceDoneState(HomeState state) : super.from(state);
}

class WaitingTimeResponseState extends HomeState {
  WaitingTimeResponseState(
      WaitingTimeResponse waitingTimeResponse, HomeState state)
      : super.from(state.copyWith(waitingTimeResponse: waitingTimeResponse));
}

class InvoiceState extends HomeState {
  InvoiceState(HomeState state) : super.from(state);
}

class RatingTripState extends HomeState {
  RatingTripState(HomeState state) : super.from(state);
}

class CancelTripState extends HomeState {
  CancelTripState(HomeState state) : super.from(state);
}

class AccountUpdateRequireState extends HomeState {
  AccountUpdateRequireState(HomeState state) : super.from(state);
}

class ChangeServiceStatusState extends HomeState {
  ChangeServiceStatusState(
      bool isOffline, TripResponse tripResponse, HomeState state)
      : super.from(
            state.copyWith(isOffline: isOffline, tripResponse: tripResponse));
}

class MoveToPositionState extends HomeState {
  final Position position;

  MoveToPositionState(this.position, HomeState state) : super.from(state);
}

class GetCancelReason extends HomeState {
  GetCancelReason(List<CancelReasonResponse> cancelReason, HomeState state)
      : super.from(state);
}

class SelectCancelReason extends HomeState {
  SelectCancelReason(int selectedCancelReason, HomeState state)
      : super.from(state.copyWith(selectedCancelReason: selectedCancelReason));
}
