import 'package:flutter/cupertino.dart';
import 'package:diary/diary_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dialogs/create_dialog.dart';
import 'dialogs/delete_dialog.dart';
import 'dialogs/update_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 현재 캘린더의 형식으로, 초기값으로 월 형식을 사용
  CalendarFormat _calendarFormat = CalendarFormat.month;
  // 사용자가 선택한 날짜를 나타내며, 초기값으로 현재 날짜를 사용
  DateTime _focusedDay = DateTime.now();
  // 사용자가 선택한 날짜를 나타내며, 초기값은 null
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryService>(
      builder: (context, diaryService, child) {
        DateTime targetDay = _selectedDay ?? _focusedDay;
        List<Diary> diaries = diaryService.getByDate(targetDay);

        return Scaffold(
          appBar: AppBar(title: Text('TableCalendar')),
          body: Column(
            children: [
              // 캘린더 영역
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  // 선택된 날짜를 결정하는 함수로, _selectedDay와 'day'를 비교하여 선택된 날짜가 '날짜'인지 판단
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  // 사용자가 날짜를 선택했을 때 호출되는 콜백 함수
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // selectedDay는 사용자가 선택한 날짜, focusedDay는 현재 포커스 되어 있는 날짜
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                onFormatChanged: (format) {
                  // 캘린더 형식이 변경될 때 호출되는 콜백 함수
                  // 캘린더 형식을 월 단위로만 고정하여 사용한다면, 이 함수를 사용할 필요 없음
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  // 페이지가 변경될 때 호출되는 콜백 함수
                  // 포커스된 날짜를 업데이트 하며, setState() 필요 없음
                  _focusedDay = focusedDay;
                },
              ),

              // 일기 영역
              Divider(thickness: 0.5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                alignment: Alignment.centerLeft,
                child:
                    diaries.isEmpty
                        ? Text(
                          "작성된 일기가 없습니다",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        )
                        : GestureDetector(
                          // 수정 모달 띄우기
                          onTap: () => showUpdateDialog(context, diaries.first),
                          // 삭제 모달 띄우기
                          onLongPress:
                              () => showDeleteDialog(context, diaries.first),
                          child: Text(
                            diaries.first.text,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
              ),

              // 버튼 영역
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: Colors.indigo,
                    onPressed:
                        () => showCreateDialog(
                          context,
                          _selectedDay ?? _focusedDay,
                        ),
                    child: Icon(Icons.create, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
