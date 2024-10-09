import 'package:lets_git_it/model/workout.dart';

import 'temp_data.dart';
import 'package:flutter/material.dart';

const headers = [
  'Mon',
  'Tue',
  'Wed',
  'Thur',
  'Fri',
  'Sat',
  'Sun',
];

class GridTrackerView extends StatelessWidget {
  const GridTrackerView({super.key});

  List<LoggedWorkout> preProcessLoggedWorkout(List<LoggedWorkout> data) {
    // find the day of week of the first day
    var newData = List<LoggedWorkout>.from(data);
    final firstDay = data.first.dateTime?.weekday;
    final placeholderCount = firstDay! - 1;

    for (var i = 0; i < placeholderCount; i++) {
      newData.insert(i, LoggedWorkout.placeholder());
    }

    return newData;
  }

  @override
  Widget build(BuildContext context) {
    final data = preProcessLoggedWorkout(tempData);
    return Column(
      children: [
        Row(
          children: headers.map((e) => Expanded(
            child: Text(e, style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),),
          )).toList(),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              if (data[index].isPlaceholder == true) {
                return const SizedBox();
              } else {
                return Container(
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: data[index].workout!.color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      data[index].workout!.name,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class GridTracker extends StatelessWidget {
  const GridTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('hellp');
  }
}