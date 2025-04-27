import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../diary_service.dart';

void showCreateDialog(BuildContext context, DateTime targetDay) {
  TextEditingController controller = TextEditingController();
  String? error;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('일기 작성', style: TextStyle(fontWeight: FontWeight.w500)),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: '한 줄 일기를 작성해주세요.',
                errorText: error,
              ),
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
                      // 작성 버튼
                      TextButton(
                        onPressed: () {
                          String text = controller.text;
                          if (text.isEmpty) {
                            setState(() => (error = "일기를 작성해주세요"));
                          } else {
                            final diaryService = context.read<DiaryService>();
                            // 일기 생성
                            diaryService.create(text, targetDay);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          '작성',
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
