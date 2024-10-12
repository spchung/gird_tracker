
import 'package:flutter/material.dart';
import 'package:lets_git_it/locator.dart';
import 'package:lets_git_it/service/logged_workout.dart';
import 'package:lets_git_it/theme.dart';
import 'package:lets_git_it/model/workout.dart';
import 'package:lets_git_it/view/temp_data.dart';

const headers = [
  'Mon',
  'Tue',
  'Wed',
  'Thur',
  'Fri',
  'Sat',
  'Sun',
];

class GridTrackerView extends StatefulWidget {
  const GridTrackerView({super.key});

  @override
  State<GridTrackerView> createState() => _GridTrackerViewState();
}

class _GridTrackerViewState extends State<GridTrackerView> {
  late Future<List<LoggedWorkout>> _workoutData;

  @override
  void initState() {
    super.initState();
    // Get the WorkoutService instance and fetch data
    final workoutService = sl.get<LoggedWorkoutService>();
    _workoutData = workoutService.fetchLoggedWorkouts();
  }

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
  Widget build(BuildContext context){
    return FutureBuilder<List<LoggedWorkout>>(
      future: _workoutData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No workouts found.'));
        }
        final workouts = snapshot.data!;
        final data = preProcessLoggedWorkout(workouts);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 2,
              color: Colors.grey[700],
              child: WrokoutStatGrid(data: data)
            ),
            Text('Outer Column - Child 1'),
            SizedBox(height: 20),
          ],
        );
      }
    );
  }
}

class WrokoutStatGrid extends StatelessWidget {
  const WrokoutStatGrid({
    super.key,
    required this.data,
  });

  final List<LoggedWorkout> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Inner column only takes height of children
      children: [
        // Activity Summary
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Activity Summary', style: mainTheme.textTheme.bodyLarge,),
                    Text('Jan 1 - Jan 7',style: mainTheme.textTheme.bodyMedium,),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Change Period'),
                ),
              ),
            ],
          ),
        ),
        // Data Dash
        const Row(
          children: [
            Expanded(child:Text("Data1", textAlign: TextAlign.center,)),
            Expanded(child:Text("Data2", textAlign: TextAlign.center,)),
            Expanded(child:Text("Data3", textAlign: TextAlign.center,)),
          ],
        ),
        // headers
        Row(
          children: headers.map((day) => Expanded(
            child: Text(day,style: mainTheme.textTheme.bodyMedium,textAlign: TextAlign.center),
          )).toList(),
        ),
        // grid (Use SizedBox to give fixed height)
        SizedBox(
          height: 320,  // You can adjust this value as needed
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
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
                    borderRadius: BorderRadius.circular(99),
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
