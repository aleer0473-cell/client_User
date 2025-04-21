import 'dart:convert';

import 'package:dio/dio.dart';
class Connection {
  static const String baseUrl = "https://fcm.googleapis.com/";
  Dio dio = Dio();
  Connection() {
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = 30000
      ..options.receiveTimeout = 30000
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
        'Authorization': 'key=AAAAHHXDMfU:APA91bEXuOxQyRNyt6Hpu8JOiyt-d_eFMsHY48zig3DgLFrwimxoJisxHMmw7IZp0ccli0XJBuADhBQMeQHjpGI6Z0DWIct5ur5LXSbmioYXxUp39elS00Sh-1xWOzxZ9O0yOSUTBCvz'
      };
  }

  void send(String title, String message) async {
    Map<String, dynamic> data = {
      "title": title,
      "body": message,
    };

    // Using "/topics/all" to send to all users
    Map<String, dynamic> notification = {"to": "/topics/all", "data": data};

    Response response = await dio.post(
      "fcm/send",
      data: notification,
    );
    print("Notification Response ${response.data.toString()}");
    print("Notification Response ${response.statusCode.toString()}");
  }
}
