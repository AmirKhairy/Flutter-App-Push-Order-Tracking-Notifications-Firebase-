abstract class OrderState {}

class OrderInitialState extends OrderState {}

class GetNotificationLoadingState extends OrderState {}

class GetNotificationSuccessState extends OrderState {
  final String token;
  GetNotificationSuccessState({required this.token});
}

class GetNotificationErrorState extends OrderState {
  final String message;
  GetNotificationErrorState({required this.message});
}

class SentNotificationLoadingState extends OrderState {}

class SentNotificationSuccessState extends OrderState {}

class SentNotificationErrorState extends OrderState {
  final String message;
  SentNotificationErrorState({required this.message});
}
