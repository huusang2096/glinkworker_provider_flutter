import 'package:glinkwok_provider/locator.dart';
import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/model/trip_response.dart';
import 'package:glinkwok_provider/src/screens/your_service/models/provider_ongoing_trip_response_model.dart';
import 'package:glinkwok_provider/src/screens/your_service/models/provider_past_trip_response_model.dart';
import 'package:simplest/simplest.dart';

part 'service_state.dart';

class ServiceCubit extends BaseCubit<ServiceState> {
  ServiceCubit() : super(ServiceInitial());

  getProivderTrips() async {
    try {
      emit(state.copyWith(isLoading: true));
      final _location = locator<LocationService>();
      final List<ProviderPastTripResponse> pastTrips =
          await dataRepository.getPastTrip();
      final List<ProviderOngoingTripDetailResponse> ongoingTrips =
          await dataRepository.getUpcomingTrip();
      final TripResponse ongoing = await dataRepository.getTrip(
          latitude: _location.position.latitude,
          longitude: _location.position.longitude);
      emit(GetServiceHistory(pastTrips, ongoingTrips, ongoing, state));
    } catch (e) {
      handleAppError(e);
    }
    emit(state.copyWith(isLoading: false));
  }

  refreshData() async {
    emit(state.copyWith(isLoading: true));
    await getProivderTrips();
    emit(state.copyWith(isLoading: false));
  }

  cancelTrip(int id, String reason) async {
    try {
      await dataRepository.cancelRequest(id, reason);
      emit(CancelTripState(state));
    } catch (e) {
      handleAppError(e);
    }
  }
}
