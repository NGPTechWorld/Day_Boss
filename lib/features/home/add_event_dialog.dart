import 'package:dayboss/core/services/notifications/notification_service.dart';
import 'package:dayboss/core/utils/color_manager.dart';
import 'package:dayboss/data/models/event_model.dart';
import 'package:dayboss/data/models/tag_model.dart';
import 'package:dayboss/features/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEventBottomSheet extends StatelessWidget {
  final HomeController controller = Get.find();
  final EventModel? event; // ← حدث موجود للتعديل

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final RxString selectedTag = "".obs;
  final Rx<TimeOfDay?> startTime = Rx<TimeOfDay?>(null);
  final Rx<TimeOfDay?> endTime = Rx<TimeOfDay?>(null);
  final RxString importance = "عادي".obs;

  AddEventBottomSheet({super.key, this.event}) {
    if (event != null) {
      titleController.text = event!.title;
      descController.text = event!.description;
      startTime.value = TimeOfDay(
        hour: event!.startTime.hour,
        minute: event!.startTime.minute,
      );
      endTime.value = TimeOfDay(
        hour: event!.endTime.hour,
        minute: event!.endTime.minute,
      );
      selectedTag.value = event!.tag;
      importance.value = event!.importance;
    }
  }

  Future<void> pickTime(BuildContext context, Rx<TimeOfDay?> target) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) target.value = picked;
  }

  void openAddTagSheet(BuildContext context) {
    final nameController = TextEditingController();
    Color selectedColor = Colors.blue;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "إضافة تصنيف جديد",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "اسم التصنيف",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var color in [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.orange,
                  Colors.purple,
                ])
                  GestureDetector(
                    onTap: () => selectedColor = color,
                    child: CircleAvatar(backgroundColor: color, radius: 15),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primaryColor,
              ),
              onPressed: () async {
                if (nameController.text.isEmpty) {
                  Get.snackbar("خطأ", "يرجى إدخال اسم التصنيف");
                  return;
                }
                await controller.addTag(
                  TagModel(
                    name: nameController.text,
                    colorValue: selectedColor.value,
                  ),
                );
                Get.back();
                Get.snackbar("تم", "تمت إضافة التصنيف بنجاح");
              },
              child: const Text("حفظ التصنيف"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              "إضافة حدث جديد",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: titleController,
              style: Get.textTheme.bodyMedium,
              decoration: const InputDecoration(
                labelText: "العنوان",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: descController,
              style: Get.textTheme.bodyMedium,
              decoration: const InputDecoration(
                labelText: "الملاحظات",
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),

            const Text(
              "وقت الحدث:",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => OutlinedButton.icon(
                      icon: const Icon(Icons.access_time),
                      label: Text(
                        startTime.value == null
                            ? "بداية"
                            : startTime.value!.format(context),
                      ),
                      onPressed: () => pickTime(context, startTime),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Obx(
                    () => OutlinedButton.icon(
                      icon: const Icon(Icons.timelapse),
                      label: Text(
                        endTime.value == null
                            ? "نهاية"
                            : endTime.value!.format(context),
                      ),
                      onPressed: () => pickTime(context, endTime),
                    ),
                  ),
                ),
              ],
            ),

            // const SizedBox(height: 20),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Text(
            //       "اختر التصنيف:",
            //       style: TextStyle(fontWeight: FontWeight.w600),
            //     ),
            //     TextButton.icon(
            //       icon: const Icon(Icons.add, size: 18),
            //       label: const Text("إضافة تاغ"),
            //       onPressed: () => openAddTagSheet(context),
            //     ),
            //   ],
            // ),

            // Obx(() {
            //   return Wrap(
            //     spacing: 8,
            //     children: controller.tags.map((tag) {
            //       final isSelected = selectedTag.value == tag.name;
            //       return ChoiceChip(
            //         label: Text(
            //           tag.name,
            //           style: TextStyle(
            //             color: isSelected ? Colors.white : Colors.black,
            //           ),
            //         ),
            //         backgroundColor: Color(tag.colorValue).withOpacity(0.3),
            //         selectedColor: Color(tag.colorValue),
            //         selected: isSelected,
            //         onSelected: (_) => selectedTag.value = tag.name,
            //       );
            //     }).toList(),
            //   );
            // }),
            const SizedBox(height: 20),

            const Text(
              "مستوى الأهمية:",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            Obx(() {
              return Wrap(
                spacing: 8,
                children: ["عادي", "متوسط", "عالي"].map((level) {
                  Color color = ColorManager.greenColor;
                  if (level == "متوسط") color = ColorManager.yello;
                  if (level == "عالي") color = ColorManager.redColor;
                  return ChoiceChip(
                    label: Text(
                      level,
                      style: TextStyle(
                        color: importance.value == level
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    selected: importance.value == level,
                    selectedColor: color,
                    backgroundColor: color.withOpacity(0.3),
                    onSelected: (_) => importance.value = level,
                  );
                }).toList(),
              );
            }),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    child: const Text("إلغاء"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primaryColor,
                    ),
                    onPressed: () {
                      if (titleController.text.isEmpty) {
                        Get.snackbar("خطأ", "يرجى إدخال عنوان الحدث");
                        return;
                      }
                      if (startTime.value == null || endTime.value == null) {
                        Get.snackbar("خطأ", "يرجى اختيار وقت البداية والنهاية");
                        return;
                      }

                      final now = controller.selectedDay.value;
                      final startDateTime = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        startTime.value!.hour,
                        startTime.value!.minute,
                      );
                      final endDateTime = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        endTime.value!.hour,
                        endTime.value!.minute,
                      );

                      if (event != null) {
                        // تعديل الحدث
                        event!
                          ..title = titleController.text
                          ..description = descController.text
                          ..startTime = startDateTime
                          ..endTime = endDateTime
                          ..tag = selectedTag.value
                          ..importance = importance.value
                          ..save();
                        controller.events.refresh();
                      } else {
                        // إضافة جديد
                        controller.addEvent(
                          EventModel(
                            title: titleController.text,
                            description: descController.text,
                            date: controller.selectedDay.value,
                            startTime: startDateTime,
                            endTime: endDateTime,
                            tag: selectedTag.value,
                            importance: importance.value,
                          ),
                        );
                        
                      }

                      Get.back();
                    },
                    child: Text(
                      event != null ? "تعديل" : "إضافة",
                      style: TextStyle(color: ColorManager.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
