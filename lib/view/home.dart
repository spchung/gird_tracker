import 'package:flutter/material.dart';
import 'package:lets_git_it/locator.dart';
import 'package:lets_git_it/model/exercise.dart';
import 'package:lets_git_it/service/exercise.dart';
import 'package:lets_git_it/service/sessions.dart';
import 'package:lets_git_it/service/workout_group.dart';
import 'package:lets_git_it/theme.dart';
import 'package:lets_git_it/model/session.dart';
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 2,
            // color: colorGrid[4],
            color: lightThemePalette['background'],
            child: const InnerGrid()
          ),
          // const SizedBox(height: 5),
          // const Spacer(),
          const SizedBox(height: 10),
          const LoggerInterface(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class LoggerInterface extends StatefulWidget {
  const LoggerInterface({super.key});

  @override
  State<LoggerInterface> createState() => _LoggerInterfaceState();
}

class _LoggerInterfaceState extends State<LoggerInterface> {
  // String? _selectedWorkoutGroup;
  final ValueNotifier<IdNameModel?> _selectedWorkoutGroup = ValueNotifier<IdNameModel?>(null);
  List<Exercise>? _exercises;
  List<IdNameModel>? _workoutGroups;


  @override
  void initState() {
    super.initState();
    sl.get<WorkoutGroupService>().fetchWorkoutGroups()
      .then((value) {
          setState(() {
          _workoutGroups = value.map((e) => IdNameModel(id: e.id.toString(), name: e.name)).toList();
        });
      }
    );

    _selectedWorkoutGroup.addListener(() {
      if (_selectedWorkoutGroup.value == null) {
        return;
      }
      setState(() {
        sl.get<ExerciseService>().fetchExercisesByGroupId(_selectedWorkoutGroup.value!.id)
          .then((value) {
            setState(() {
              _exercises = value;
            });
          });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: lightThemePalette['background'],
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.33,
              child: Column(
                children: [
                  Expanded(
                    child: LabelDropDownButton(
                      label: "Workout Group",
                      options: _workoutGroups ?? [],
                      onChanged: (IdNameModel? value) {
                        setState(() {
                          _selectedWorkoutGroup.value = value;
                        });
                      }, 
                      enabled: true, 
                      placeholderText: "Select Group",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final sessionService = sl.get<SessionsService>();
                      sessionService.addLoggedWorkout(
                        Session(
                          dateTime: DateTime.now(),
                          workoutGroupId: 1,
                        )
                      );
                    }, 
                    child: const Text("Log Workout"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final sessionService = sl.get<SessionsService>();
                      final sess = await sessionService.getData(21);
                      print(sess.workoutGroupName);
                      sess.exercises?.forEach((element) {
                        print(element.name);
                      });

                    }, 
                    child: const Text("read Workout"),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: lightThemePalette['onSecondary'],
                ),
                height: MediaQuery.of(context).size.height * 0.3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _exercises?.map((e) => ExerciseCheckbox(exercise: e,)).toList() ?? const [],
                    ),
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}

class ExerciseCheckbox extends StatelessWidget {
  const ExerciseCheckbox({
    super.key,
    required this.exercise
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Text(
      exercise.name,
      style: mainTheme.textTheme.bodyMedium?.copyWith(
        color: lightThemePalette['primary'],
      ),
      textAlign: TextAlign.start,
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
        SizedBox(
          // height: 320,  
          height: MediaQuery.of(context).size.height * 0.35,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemCount: paddedData.length,
            itemBuilder: (context, index) {
              final loggedWorkout = paddedData[index];
              if (loggedWorkout.isPlaceholder == true) {
                // rest day 
                return const SizedBox();
              } else {
                // workout day
                return Container(
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: lightThemePalette['onSecondary'],
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () => print(loggedWorkout.workoutGroupName),
                      child: Text(
                        // data[index].workout!.name,
                        loggedWorkout.workoutGroupName ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          color: lightThemePalette['primary'],
                          // color: Colors.black
                        ),
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