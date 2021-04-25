part of 'notification_cubit.dart';

class NotificationState {
  List<NotificationResponse> notificationResponses;
  bool isLoading;

  NotificationState(this.notificationResponses, this.isLoading);

  NotificationState copyWith({
    List<NotificationResponse> notificationResponses,
    bool isLoading,
  }) {
    return NotificationState(
      notificationResponses ?? this.notificationResponses,
      isLoading ?? this.isLoading,
    );
  }

  NotificationState.from(NotificationState state) {
    notificationResponses = state.notificationResponses;
    isLoading = state.isLoading;
  }
}

class NotificationInitial extends NotificationState {
  NotificationInitial() : super(null, false);
}

class GetNotificationSuccessState extends NotificationState {
  GetNotificationSuccessState(
      NotificationState state, List<NotificationResponse> notificationResponses)
      : super.from(
            state.copyWith(notificationResponses: notificationResponses));
}
