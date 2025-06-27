abstract class OrderState {}

class OrderInitialState extends OrderState {}

class GetNotificationLoadingState extends OrderState {}

class GetNotificationSuccessState extends OrderState {
  final String token;
  final String? message;
  GetNotificationSuccessState({required this.token, this.message});
}

class GetNotificationErrorState extends OrderState {}

class SentNotificationLoadingState extends OrderState {}

class SentNotificationSuccessState extends OrderState {
  final String? message;
  SentNotificationSuccessState({this.message});
}

class SentNotificationErrorState extends OrderState {
  final String message;
  SentNotificationErrorState({required this.message});
}

class UpdateStatusFromRemoteState extends OrderState {
  final int index;
  UpdateStatusFromRemoteState({required this.index});
}
