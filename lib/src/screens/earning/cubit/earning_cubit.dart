import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/model/ride_response.dart';

part 'earning_state.dart';

class EarningCubit extends BaseCubit<EarningState> {
  EarningCubit() : super(EarningInitial());

  getEarning() async {
    emit(state.copyWith(isLoading: true));
    try {
      RideResponse rideResponse = await dataRepository.getRideTarget();
      // sum provider pay
      double total = 0;
      rideResponse.rides.forEach((ride) {
        total += ride.payment.providerPay;
      });

      double prercent = 0;
      prercent = rideResponse.rides.length / int.parse(rideResponse.target);

      emit(GetRideSuccessState(state, rideResponse, total, prercent));
    } catch (e) {
      handleAppError('get_target');
    }
    emit(state.copyWith(isLoading: false));
  }
}
