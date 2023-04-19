import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'firebase_service.g.dart';

@RestApi(baseUrl: 'https://fcm.googleapis.com')
abstract class FirebaseService {
  factory FirebaseService(Dio dio) = _FirebaseService;

  @POST("/fcm/send")
  Future<HttpResponse> sendPushMessage(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> body,
  );

  @POST("/fcm/send")
  Future<HttpResponse> sendPushMessageTopic(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> body,
  );
}

// String baseURL = "https://fcm.googleapis.com/fcm/send";
String toParams = "/topics/orderCoffee";
String serverKey =
    "key=AAAAIK603zw:APA91bFSffeMI5Lf1hhsNgt6wwpxA1ZayS0UAaRc0F8QRb-Xq12C51QJqIxxn5X-OgcmmMvqdYJCGQ3xUvkaA6yxIdobU_sTJygBQs2g9JxiJh3jyOTdTl9VwGOXy1emLEX22v5rw2rc";

Future sendPushMessage({
  required String token,
  required String orderID,
  required String body,
  required String title,
}) async {
  try {
    Map<String, dynamic> bodyFCM = {
      'notification': <String, dynamic>{'body': body, 'title': title},
      'priority': 'high',
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': orderID,
      },
      "to": token,
    };

    FirebaseService firebaseService =
        FirebaseService(Dio(BaseOptions(contentType: "application/json")));
    firebaseService.sendPushMessage(serverKey, bodyFCM);
  } catch (_) {}
}

Future sendPushMessageTopic({
  required String orderID,
  required String body,
  required String title,
}) async {
  try {
    Map<String, dynamic> bodyFCM = {
      'notification': <String, dynamic>{'body': body, 'title': title},
      'priority': 'high',
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': orderID,
      },
      "to": toParams,
    };

    FirebaseService firebaseService =
        FirebaseService(Dio(BaseOptions(contentType: "application/json")));
    firebaseService.sendPushMessageTopic(serverKey, bodyFCM);
  } catch (_) {}
}

Future saveNewTokenFCM() async {
  FirebaseMessaging.instance.getToken().then((token) async {
    print(token);
    await SharedPreferences.getInstance().then((value) {
      String id = value.getString("userID") ?? "";
      FirebaseFirestore.instance
          .collection("token")
          .doc(id)
          .set({"token": token});
    });
  });
}

Future deleteTokenFCM() async {
  await SharedPreferences.getInstance().then((value) {
    String id = value.getString("userID") ?? "";
    FirebaseFirestore.instance.collection("token").doc(id).set({"token": ""});
  });
}

/*Future sendPushMessage({
  required String token,
  required String id,
  required String body,
  required String title,
  String status = 'message',
  String myToken = "",
  String screen = 'chat',
}) async {
  try {
    Map<String, String> headerFCM = {
      "Content-Type": "application/json",
      "Authorization": serverKey,
    };

    Map<String, dynamic> bodyFCM = {
      'notification': <String, dynamic>{'body': body, 'title': title},
      'priority': 'high',
      'data': <String, dynamic>{
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': id,
        'status': status,
        'token': myToken,
        'screen': screen,
      },
      "to": token,
    };

    http.post(
      Uri.parse(baseURL),
      headers: headerFCM,
      body: jsonEncode(bodyFCM),
    );
  } catch (_) {}
}*/
