import 'package:dayboss/core/utils/assets.gen.dart';
import 'package:dayboss/features/home/add_event_dialog.dart';
import 'package:dayboss/features/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dayboss/core/utils/color_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController c = Get.put(HomeController());

    return Scaffold(
      backgroundColor: ColorManager.primary1Color,
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
        title: const Row(
          children: [
            Text(
              "أهلاً بك ",
              style: TextStyle(color: ColorManager.primary20Color),
            ),
            Text("محمد علي النعيمي"),
          ],
        ),
      ),
      body: Column(
        children: [
          Calendar(c: c),
          const SizedBox(height: 10),
          MyTasks(c: c),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primaryColor,
        onPressed: () {
          Get.bottomSheet(
            AddEventBottomSheet(),
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
          );
        },
        child: const Icon(Icons.add, color: ColorManager.cardBack2),
      ),
    );
  }
}

class MyTasks extends StatelessWidget {
  const MyTasks({super.key, required this.c});

  final HomeController c;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        final events = c.getEventsForDay(c.selectedDay.value);
        if (events.isEmpty) {
          return const Center(
            child: Text('مافي أحداث اليوم', style: TextStyle(fontSize: 16)),
          );
        }
        return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final e = events[index];
            String formatTime(DateTime time) {
              final hour = time.hour > 12
                  ? time.hour - 12
                  : (time.hour == 0 ? 12 : time.hour);
              final minute = time.minute.toString().padLeft(2, '0');
              final period = time.hour >= 12 ? ' م' : ' ص';
              return '$hour:$minute$period';
            }

            return Card(
              color: ColorManager.cardBackground,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      decoration: BoxDecoration(
                        color: c.getProertyColor(e.importance),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          spacing: 4,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    e.title,
                                    style: Get.textTheme.bodyLarge,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    PopupMenuButton<String>(
                                      icon: const Icon(Icons.more_vert),
                                      onSelected: (value) async {
                                        if (value == 'edit') {
                                          Get.bottomSheet(
                                            AddEventBottomSheet(event: e),
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                          );
                                        } else if (value == 'delete') {
                                          // تأكيد الحذف
                                          Get.defaultDialog(
                                            title: "تأكيد الحذف",
                                            middleText:
                                                "هل أنت متأكد أنك تريد حذف هذا الحدث؟",
                                            textCancel: "إلغاء",
                                            textConfirm: "حذف",
                                            confirmTextColor: Colors.white,
                                            onConfirm: () async {
                                              await e.delete();
                                              c.loadData();
                                              Get.back();
                                            },
                                          );
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(
                                          value: 'edit',
                                          child: Text('تعديل'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',
                                          child: Text('حذف'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            e.description != ""
                                ? Row(
                                    children: [
                                      Text(
                                        "الملاحظات: ",
                                        style: Get.textTheme.bodyMedium,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            Row(
                              children: [
                                Text(
                                  "الوقت: ",
                                  style: Get.textTheme.bodyMedium,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(formatTime(e.startTime)),
                                      Text(formatTime(e.endTime)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class Calendar extends StatelessWidget {
  const Calendar({super.key, required this.c});

  final HomeController c;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.lightPrimaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            border: BoxBorder.all(color: ColorManager.primaryColor),
          ),
          child: TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2050, 12, 31),
            focusedDay: c.focusedDay.value,
            selectedDayPredicate: (day) => isSameDay(c.selectedDay.value, day),
            onDaySelected: c.selectDay,
            calendarFormat: c.calendarFormat.value,
            onFormatChanged: (format) => c.calendarFormat.value = format,
            headerStyle: HeaderStyle(
              titleTextStyle: Get.textTheme.bodyLarge!.copyWith(
                color: ColorManager.primaryColor,
              ),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: ColorManager.primaryColor.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: ColorManager.primaryDark,
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) {
                final color = c.getDayColor(day);
                return Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color: color == Colors.transparent
                            ? ColorManager.grey3
                            : ColorManager.primary6Color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
