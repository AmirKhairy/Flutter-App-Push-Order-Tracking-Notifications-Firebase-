import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  final String baseUrl = "http://192.168.1.2:3000";

  // send notification request
  Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    final url = Uri.parse("$baseUrl/send-notification");

    final payload = {'fcmToken': token, 'title': title, 'body': body};

    if (imageUrl != null) {
      payload['image'] = imageUrl;
    }

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
    if (response.statusCode == 200) {
      print("request sent successfully: ${response.body}");
    }

    if (response.statusCode != 200) {
      print("Failed to send notification: ${response.body}");
      throw Exception("Failed to send notification: ${response.body}");
    }
  }
}
