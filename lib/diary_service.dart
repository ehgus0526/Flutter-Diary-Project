import 'package:flutter/material.dart';

class Diary {
  String text; // 내용
  DateTime createdAt; // 작성 시간

  Diary({required this.text, required this.createdAt});
}

class DiaryService extends ChangeNotifier {
  /// Diary 목록
  List<Diary> diaryList = [];

  /// 특정 날짜의 diary 조회
  List<Diary> getByDate(DateTime date) {
    return diaryList.where((diary) {
      return diary.createdAt.year == date.year &&
          diary.createdAt.month == date.month &&
          diary.createdAt.day == date.day;
    }).toList();
  }

  /// Diary 작성
  void create(String text, DateTime selectedDate) {
    diaryList.add(Diary(text: text, createdAt: selectedDate));
    notifyListeners();
  }

  /// Diary 수정
  void update(DateTime createdAt, String newContent) {
    int index = diaryList.indexWhere(
      (diary) =>
          diary.createdAt.year == createdAt.year &&
          diary.createdAt.month == createdAt.month &&
          diary.createdAt.day == createdAt.day,
    );
    if (index != -1) {
      diaryList[index] = Diary(text: newContent, createdAt: createdAt);
      notifyListeners();
    }
  }

  /// Diary 삭제
  void delete(DateTime createdAt) {
    int index = diaryList.indexWhere(
      (diary) =>
          diary.createdAt.year == createdAt.year &&
          diary.createdAt.month == createdAt.month &&
          diary.createdAt.day == createdAt.day,
    );
    diaryList.removeAt(index);
    notifyListeners();
  }
}
