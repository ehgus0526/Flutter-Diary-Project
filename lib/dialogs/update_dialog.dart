import 'package:diary/diary_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showUpdateDialog(BuildContext context, Diary diary) {
  TextEditingController controller = TextEditingController(text: diary.text);

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('일기 수정', style: TextStyle(fontWeight: FontWeight.w500)),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: '한 줄 일기를 작성해주세요.'),
            ),
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
                      // 수정 버튼
                      TextButton(
                        onPressed: () {
                          String newText = controller.text;
                          final diaryService = context.read<DiaryService>();
                          // 일기 수정
                          diaryService.update(diary.createdAt, newText);
                          Navigator.pop(context);
                        },
                        child: Text(
                          '수정',
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
