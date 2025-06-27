import 'package:flutter/material.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/core/services/firebase_notification_service.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/core/services/http_service.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/features/notifications/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this._notificationService, this._httpService)
    : super(OrderInitialState());

  static OrderCubit get(BuildContext context) =>
      BlocProvider.of<OrderCubit>(context);
  final FirebaseNotificationService _notificationService;

  // initialize notifications
  Future<void> initializeNotifications() async {
    emit(GetNotificationLoadingState());
    try {
      await _notificationService.initialize();
      final token = await _notificationService.getDeviceToken();
      print(token);
      emit(GetNotificationSuccessState(token: token!));
    } catch (e) {
      emit(GetNotificationErrorState());
    }
  }

  // send notification
  final HttpService _httpService;
  int currentOrderStatusIndex = 0;
  int? currentButtonSendingIndex;
  List<String> orderStatuses = ["Pending", "Confirmed", "Shipped", "Delivered"];
  Future<void> sendNotifiaction({
    required int newIndex,
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    currentButtonSendingIndex = newIndex;
    emit(SentNotificationLoadingState());
    print(" Sending notification for index: $newIndex");
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
      print("Notification sent successfully");
      emit(
        SentNotificationSuccessState(message: 'Notification sent successfully'),
      );
    } catch (e) {
      currentButtonSendingIndex = null;
      print(e);
      emit(SentNotificationErrorState(message: e.toString()));
    }
  }

  // update order status after firebase notification
  void updateOrderStatusFromFirebaseNotification(int index) {
    currentOrderStatusIndex = index;
    emit(UpdateStatusFromRemoteState(index: index));
  }
}
