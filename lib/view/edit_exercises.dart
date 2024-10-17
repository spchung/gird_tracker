import 'package:flutter/material.dart';
import 'package:lets_git_it/locator.dart';
import 'package:lets_git_it/model/exercise.dart';
import 'package:lets_git_it/service/exercise.dart';
import 'package:lets_git_it/theme.dart';
import 'package:lets_git_it/view/temp.dart';
import 'package:lets_git_it/view/test_swipe_to_reveal.dart';

/*
0-left: AutoCompleteTextField to search for exercises
0-right : Add new exercise button
1: List of exercises
 - 1.1-left: Exercise name
  - 1.1-right: Edit exercise button
*/ 
class EditExerciseView extends StatelessWidget {
  const EditExerciseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: lightThemePalette['onBackground'],
        title: const Text('Edit Exercises & Groups'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: lightThemePalette['background'],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: const AddExerciseForm(),
            ),
            // AddGroupBody(),
            FlutterSlidable(),
          ],
        ),
      ),
    );
  }
}

// swipe to reveal edit and trash icon
class ExerciseRow extends StatelessWidget {
  const ExerciseRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Exercise Name'),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Edit'),
        ),
      ],
    );
  }
}


// this should be in a pop up
class AddExerciseForm extends StatefulWidget {
  const AddExerciseForm({super.key});

  @override
  State<AddExerciseForm> createState() => _AddExerciseFormState();
}

class _AddExerciseFormState extends State<AddExerciseForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _exerciseNameCtrl = TextEditingController();
  final _exerciseDescriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _exerciseNameCtrl,
            decoration: const InputDecoration(
              labelText: 'Exercise Name',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _exerciseDescriptionCtrl,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await sl<ExerciseService>().addExercise(
                  Exercise(
                    name: _exerciseNameCtrl.text,
                    description: _exerciseDescriptionCtrl.text,
                    workoutGroupId: 1,
                  )
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      )
    );
  }
}

class AddGroupBody extends StatelessWidget {
  const AddGroupBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: lightThemePalette['background'],
        ),
        child: const Column(
          children: [
            Center(child: Text('group')),
            FormExample(),
            FormExample(),
          ],
        ),
      ),
    );
  }
}