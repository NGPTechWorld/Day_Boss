import 'package:dayboss/core/services/notifications/notification_service.dart';
import 'package:dayboss/data/models/event_model.dart';
import 'package:dayboss/data/models/tag_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import '/core/services/api/api_service.dart';
import '/core/services/cache/cache_service.dart';
import '/core/services/cache/get_storage_helper.dart';
import '/core/translations/app_translation.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CacheService>(GetStorageHelper());
    Get.put(ApiService());

    // Get.put(NotificationRepo()).initialize();
    // Get.put(UsersRepo());
    // Get.put(PermissionService());
  }

  static Future<void> init() async {
    await Get.find<CacheService>().init();
    await AppTranslations.init();

    await Hive.initFlutter();

    Hive.registerAdapter(EventModelAdapter());
    Hive.registerAdapter(TagModelAdapter());
    NotificationService.init();
    await Hive.openBox<EventModel>('events');
    await Hive.openBox<TagModel>('tags');
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    // await PushNotification.initialise();
    // Stripe.publishableKey =
    //     'pk_test_51RRWQY06D6FmvGT4dqW0A34yH45MTIDe4hveJ1xx1urwPE3PJB6utgLtYFpfVc1UlIve5EerS45AAyn7heo1J2v700VQMzruXM'; // حط المفتاح تبعك

    // await Stripe.instance.applySettings();
    // await getFcmToken();
  }
}

// Future<String?> getFcmToken() async {
//   final fcmToken = await FirebaseMessaging.instance.getToken();

//   log('FCM Token: $fcmToken');
//   return fcmToken;
// }
