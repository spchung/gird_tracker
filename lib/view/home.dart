
import 'package:flutter/material.dart';
import 'package:lets_git_it/locator.dart';
import 'package:lets_git_it/service/sessions.dart';
import 'package:lets_git_it/service/workout_group.dart';
import 'package:lets_git_it/theme.dart';
import 'package:lets_git_it/model/session.dart';
import 'package:lets_git_it/ui/dropdown.dart';
import 'package:lets_git_it/model/shared.dart';
import 'package:lets_git_it/ui/label_dropdown.dart';
const headers = [
  'Mon',
  'Tue',
  'Wed',
  'Thur',
  'Fri',
  'Sat',
  'Sun',
];

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 2,
          color: colorGrid[4],
          child: const InnerGrid()
        ),
        const SizedBox(height: 5),
        const LoggerInterface()
      ],
    );
  }
}

class LoggerInterface extends StatefulWidget {
  const LoggerInterface({super.key});

  @override
  State<LoggerInterface> createState() => _LoggerInterfaceState();
}

class _LoggerInterfaceState extends State<LoggerInterface> {
  String? _selectedWorkoutGroup;

  List<IdNameModel> _workoutGroups = [];

  @override
  void initState() {
    super.initState();
    final workoutGroupService = sl.get<WorkoutGroupService>();
    workoutGroupService.fetchWorkoutGroups().then((value) {
      setState(() {
        _workoutGroups = value.map((e) => IdNameModel(id: e.id.toString(), name: e.name)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colorGrid[4],
      ),
      child: Column(
        children: [
          LabelDropDownButton(
            label: "Workout Group",
            options: _workoutGroups,
            onChanged: (String? value) {
              setState(() {
                _selectedWorkoutGroup = value;
              });
            }, 
            enabled: true, 
            placeholderText: "Select Group",
          ),
          ElevatedButton(
            onPressed: () async {
              final sessionService = sl.get<SessionsService>();
              final session = sessionService.getData(3);
              session.then((value) => print(value.workoutGroupName));
            }, 
            child: Text("Get workout")
          )
        ],
      ),
    );
  }
}

class InnerGrid extends StatefulWidget {
  const InnerGrid({
    super.key,
  });

  @override
  State<InnerGrid> createState() => _InnerGridState();
}

class _InnerGridState extends State<InnerGrid> {
  late List<Session> _workoutData;
  late SessionsService _sessionService;

  @override
  void initState() {
    super.initState();
    _sessionService = sl.get<SessionsService>();
    _workoutData = _sessionService.sessions.value;
    // listener to refresh UI when data changes
    _sessionService.sessions.addListener(_updateWorkouts);
    _sessionService.fetchLoggedWorkouts();
  }

  void _updateWorkouts() {
    setState(() {
      _workoutData = _sessionService.sessions.value;
    });
  }

  @override
  void dispose() {
    _sessionService.sessions.removeListener(_updateWorkouts);
    super.dispose();
  }

  List<Session> preProcessLoggedWorkout(List<Session> data) {
    var newData = List<Session>.from(data);
    final firstDay = data.first.dateTime?.weekday;
    final placeholderCount = firstDay! - 1;

    for (var i = 0; i < placeholderCount; i++) {
      newData.insert(i, Session.placeholder());
    }
    return newData;
  }

  @override
  Widget build(BuildContext context) {
    if (_workoutData.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final paddedData = preProcessLoggedWorkout(_workoutData);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
            itemCount: paddedData.length,
            itemBuilder: (context, index) {
              if (paddedData[index].isPlaceholder == true) {
                return const SizedBox();
              } else {
                return Container(
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Center(
                    child: Text(
                      // data[index].workout!.name,
                      'TEMP',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        )
      ]
    );
  }
}