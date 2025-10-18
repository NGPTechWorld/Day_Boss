import 'package:dayboss/core/utils/color_manager.dart';
import 'package:dayboss/data/models/tag_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../data/models/event_model.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime> selectedDay = DateTime.now().obs;
  //! Setup Hive
  final Box<EventModel> eventsBox = Hive.box<EventModel>('events');
  final Box<TagModel> tagsBox = Hive.box<TagModel>('tags');
  RxList<EventModel> events = <EventModel>[].obs;
  RxList<TagModel> tags = <TagModel>[].obs;
  final calendarFormat = CalendarFormat.twoWeeks.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    events.assignAll(eventsBox.values.toList());
    tags.assignAll(tagsBox.values.toList());
  }

  Future<void> addEvent(EventModel event) async {
    await eventsBox.add(event);
    loadData();
  }

  Future<void> deleteEvent(EventModel event) async {
    await event.delete();
    loadData();
  }

  Future<void> addTag(TagModel tag) async {
    await tagsBox.add(tag);
    loadData();
  }

  List<EventModel> getEventsForDay(DateTime day) {
    return events
        .where(
          (e) =>
              e.date.year == day.year &&
              e.date.month == day.month &&
              e.date.day == day.day,
        )
        .toList();
  }

  int getFreeMinutesForDay(DateTime day) {
    const int totalMinutes = 24 * 60;
    final events = getEventsForDay(day);
    int busy = 0;
    for (var e in events) {
      busy += e.endTime.difference(e.startTime).inMinutes;
    }
    int free = totalMinutes - busy;
    return free.clamp(0, totalMinutes);
  }

  Color getDayColor(DateTime day) {
    final events = getEventsForDay(day);
      // ignore: deprecated_member_use
    if (events.isEmpty) return ColorManager.greenColor.withOpacity(0.3);
    bool hasHigh = events.any((e) => e.importance.toLowerCase() == 'عالي');
    bool hasMedium = events.any((e) => e.importance.toLowerCase() == 'متوسط');
    if (hasHigh) {
      // ignore: deprecated_member_use
      return ColorManager.redColor.withOpacity(0.3);
    } else if (hasMedium) {
        // ignore: deprecated_member_use
      return ColorManager.gradientStart.withOpacity(0.3); // أصفر
    } else {
        // ignore: deprecated_member_use
      return ColorManager.greenColor.withOpacity(0.3);
    }
  }

  Color getProertyColor(String proerty) {
    if (proerty == "عالي") {
      return ColorManager.redColor;
    } else if (proerty == "متوسط") {
      return ColorManager.yello;
    } else {
      return ColorManager.greenColor;
    }
  }

  void selectDay(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }
}
