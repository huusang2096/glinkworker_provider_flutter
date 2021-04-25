import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/model/provider_dispute_request_model.dart';
import 'package:glinkwok_provider/src/screens/your_service/models/dispute_list_response_model.dart';
import 'package:glinkwok_provider/src/screens/your_service/models/provider_past_trip_detail_response_model.dart';

part 'past_service_state.dart';

class PastServiceCubit extends BaseCubit<PastServiceState> {
  PastServiceCubit() : super(PastServiceInitial());

  getPastTripDetail(int request_id) async {
    try {
      String disputeType = 'provider';
      emit(state.copywith(isLoading: true));
      final ProviderPastTripDetailResponse tripDetail =
          await dataRepository.getPastTripDetail(request_id);
      final List<DisputeListResponse> disputeList =
          await dataRepository.disputeList(disputeType);
      emit(GetPastServiceDetail(tripDetail, disputeList, state));
    } catch (e) {
      print("Error: " + e.toString());
      handleAppError(e);
    }
    emit(state.copywith(isLoading: false));
  }

  selectDispute(int index) {
    print("index: " + index.toString());
    emit(SelectDispute(index, state));
  }

  dispute(ProviderDisputeRequest request) async {
    try {
      emit(state.copywith(isLoading: true));
      final response = await dataRepository.dispute(request);
      if (response.status == true) {
        emit(DisputeSuccess(response.message, state));
      }
    } catch (e) {
      handleAppError(e);
    }
    emit(state.copywith(isLoading: false));
  }
}
