import 'package:dayboss/features/home/home_controller.dart';
import 'package:dayboss/features/home/home_page.dart';
import 'package:get/get.dart';
import '/core/routes/app_routes.dart';
import '/features/splash/splash_controller.dart';
import '/features/splash/splash_page.dart';

abstract class NavigationManager {
  static final getPages = [
    GetPage(
      name: AppRoutes.splashRoute,
      page: () => SplashPage(),
      binding: BindingsBuilder.put(() => SplashController()),
    ),
    GetPage(
      name: AppRoutes.homeRoute,
      page: () => HomePage(),
      binding: BindingsBuilder.put(() => HomeController()),
    ),
  
    // GetPage(
    //   name: AppRoutes.loginRoute,
    //   page: () => LoginPage(),
    //   binding: BindingsBuilder.put(() => LoginPageController()),
    // ),
  ];
}
