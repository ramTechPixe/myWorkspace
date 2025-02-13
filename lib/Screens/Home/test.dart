// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:my_workspace/untils/export_file.dart';
// import 'package:table_calendar/table_calendar.dart';

// class KtestScreen extends StatefulWidget {
//   const KtestScreen({super.key});

//   @override
//   State<KtestScreen> createState() => _KtestScreenState();
// }

// class _KtestScreenState extends State<KtestScreen> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _selectedDay = DateTime.now();
//   DateTime _focusedDay = DateTime.now();

//   // Sample data
//   Map<DateTime, int> eventData = {
//     DateTime(2025, 3, 23): 10,
//     DateTime(2025, 3, 24): 12,
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Calendar with Events")),
//       body: Column(
//         children: [
//           TableCalendar(
//             firstDay: DateTime(2000),
//             lastDay: DateTime(2100),
//             focusedDay: _focusedDay,
//             calendarFormat: _calendarFormat,
//             selectedDayPredicate: (day) {
//               return isSameDay(_selectedDay, day);
//             },
//             onDaySelected: (selectedDay, focusedDay) {
//               setState(() {
//                 _selectedDay = selectedDay;
//                 _focusedDay = focusedDay;
//               });

//               // Check if selected day has data and show toast
//               if (eventData.containsKey(selectedDay)) {
//                 Fluttertoast.showToast(
//                   msg:
//                       "Date: ${selectedDay.day} ${_getMonthName(selectedDay.month)}, ${selectedDay.year}\nCount: ${eventData[selectedDay]}",
//                   toastLength: Toast.LENGTH_SHORT,
//                   gravity: ToastGravity.BOTTOM,
//                 );
//               }
//             },
//             calendarBuilders: CalendarBuilders(
//               defaultBuilder: (context, day, focusedDay) {
//                 if (eventData.containsKey(day)) {
//                   return Container(
//                     margin: EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Center(
//                       child: Text(
//                         '${day.day}',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   );
//                 }
//                 return null;
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _getMonthName(int month) {
//     List<String> months = [
//       "January",
//       "February",
//       "March",
//       "April",
//       "May",
//       "June",
//       "July",
//       "August",
//       "September",
//       "October",
//       "November",
//       "December"
//     ];
//     return months[month - 1];
//   }
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:table_calendar/table_calendar.dart';

class KtestScreen extends StatefulWidget {
  const KtestScreen({super.key});

  @override
  State<KtestScreen> createState() => _KtestScreenState();
}

class _KtestScreenState extends State<KtestScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // ✅ Normalize dates by setting time to 00:00:00
  Map<DateTime, int> eventData = {
    DateTime(2025, 3, 23, 0, 0, 0): 10,
    DateTime(2025, 3, 24, 0, 0, 0): 12,
  };

  // ✅ Function to remove time (set hours, minutes, seconds to 0)
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calendar with Event")),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

              // ✅ Normalize selected date to remove time
              DateTime normalizedDate = _normalizeDate(selectedDay);

              // ✅ Check if normalized date exists in eventData
              if (eventData.containsKey(normalizedDate)) {
                Fluttertoast.showToast(
                  msg:
                      "Date: ${normalizedDate.day} ${_getMonthName(normalizedDate.month)}, ${normalizedDate.year}\nCount: ${eventData[normalizedDate]}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              }
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                // ✅ Normalize current calendar day
                DateTime normalizedDay = _normalizeDate(day);

                // ✅ Check if this day has an event
                if (eventData.containsKey(normalizedDay)) {
                  return Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${day.day}', // Show date number
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${eventData[normalizedDay]}', // Show count value
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function to get month name
  String _getMonthName(int month) {
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }
}
