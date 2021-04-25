import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/model/notification_response.dart';

part 'notification_state.dart';

class NotificationCubit extends BaseCubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  getNotification() async {
    try {
      emit(state.copyWith(isLoading: true));
      final notificationsResponse = await dataRepository.getListNotification();
      emit(GetNotificationSuccessState(state, notificationsResponse));
    } catch (e) {
      handleAppError('get_notification_error');
    }
    emit(state.copyWith(isLoading: false));
  }
}
