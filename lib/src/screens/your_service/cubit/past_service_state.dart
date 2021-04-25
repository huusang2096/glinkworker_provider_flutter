part of 'past_service_cubit.dart';

class PastServiceState {
  ProviderPastTripDetailResponse pastTripDetail;
  List<DisputeListResponse> disputeList;
  int selectedDispute;
  String message;
  bool isLoading;

  PastServiceState(
      {this.pastTripDetail,
      this.disputeList,
      this.selectedDispute,
      this.message,
      this.isLoading});

  PastServiceState copywith(
      {ProviderPastTripDetailResponse pastTripDetail,
      List<DisputeListResponse> disputeList,
      int selectedDispute,
      String message,
      bool isLoading}) {
    return PastServiceState(
        pastTripDetail: pastTripDetail ?? this.pastTripDetail,
        disputeList: disputeList ?? this.disputeList,
        selectedDispute: selectedDispute ?? this.selectedDispute,
        message: message ?? this.message,
        isLoading: isLoading ?? this.isLoading);
  }

  PastServiceState.from(PastServiceState state) {
    this.pastTripDetail = state.pastTripDetail;
    this.disputeList = state.disputeList;
    this.selectedDispute = state.selectedDispute;
    this.isLoading = state.isLoading;
  }
}

class PastServiceInitial extends PastServiceState {
  PastServiceInitial()
      : super(
          pastTripDetail: null,
          disputeList: null,
          message: '',
          isLoading: false,
        );
}

class GetPastServiceDetail extends PastServiceState {
  GetPastServiceDetail(ProviderPastTripDetailResponse pastTripDetail,
      List<DisputeListResponse> disputeList, PastServiceState state)
      : super.from(state.copywith(
          pastTripDetail: pastTripDetail,
          disputeList: disputeList,
        ));
}

class SelectDispute extends PastServiceState {
  SelectDispute(int selectedDispute, PastServiceState state)
      : super.from(state.copywith(selectedDispute: selectedDispute));
}

class DisputeSuccess extends PastServiceState {
  DisputeSuccess(String message, PastServiceState state)
      : super.from(state.copywith(message: message));
}
