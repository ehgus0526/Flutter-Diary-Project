import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../diary_service.dart';

void showDeleteDialog(BuildContext context, Diary diary) {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('일기 삭제', style: TextStyle(fontWeight: FontWeight.w500)),
            content: Text('"${diary.text}"를 삭제하시겠습니까?'),
            actions: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // 취소 버튼
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          '취소',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // 삭제 버튼
                      TextButton(
                        onPressed: () {
                          final diaryService = context.read<DiaryService>();
                          // 일기 삭제
                          diaryService.delete(diary.createdAt);
                          Navigator.pop(context);
                        },
                        child: Text(
                          '삭제',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );
}
