import 'package:flutter_app_push_order_tracking_notifications_firebase/core/services/firebase_notification_service.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/core/services/http_service.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/features/notifications/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this._notificationService, this._httpService)
    : super(OrderInitialState());

  static OrderCubit get(context) => BlocProvider.of(context);
  final FirebaseNotificationService _notificationService;
  Future<void> initializeNotifications() async {
    emit(GetNotificationLoadingState());
    try {
      await _notificationService.initialize();
      final token = await _notificationService.getDeviceToken();
      print(token);
      emit(GetNotificationSuccessState(token: token!));
    } catch (e) {
      emit(GetNotificationErrorState(message: e.toString()));
    }
  }

  final HttpService _httpService;
  int currentOrderStatusIndex = 0; // index of the current order status
  int?
  currentButtonSendingIndex; // index of the button that is current Button sending a notification

  List<String> orderStatuses = ["Pending", "Confirmed", "Shipped", "Delivered"];
  Future<void> sendNotifiaction({
    required int newIndex,
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    currentButtonSendingIndex = newIndex;

    emit(SentNotificationLoadingState());

    try {
      final token = await _notificationService.getDeviceToken();
      await _httpService.sendNotification(
        token: token!,
        title: title,
        body: body,
        imageUrl: imageUrl,
      );
      currentOrderStatusIndex = newIndex;
      currentButtonSendingIndex = null;

      emit(SentNotificationSuccessState());
    } catch (e) {
      currentButtonSendingIndex = null;

      emit(SentNotificationErrorState(message: e.toString()));
    }
  }
}
