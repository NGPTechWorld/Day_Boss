import 'package:dayboss/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/utils/assets.gen.dart';
import '/core/utils/values_manager.dart';
import '/core/utils/widgets/bubble_background.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final SplashController controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryDark,
      body: Stack(
        children: [
          Center(
            child: AnimatedBuilder(
              animation: controller.animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: controller.opacityAnimation.value,
                  child: Transform.scale(
                    scale: controller.scaleAnimation.value,
                    child: Assets.icons.logo.svg(
                      fit: BoxFit.contain,
                      width: AppSize.sWidth * 0.5,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
