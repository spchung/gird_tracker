import 'package:flutter/material.dart';
import 'package:lets_git_it/locator.dart';
import 'package:lets_git_it/service/db.dart';
import 'package:lets_git_it/theme.dart';
import 'package:lets_git_it/service/app.dart';
import 'package:watch_it/watch_it.dart';
import 'package:lets_git_it/view/home.dart';
import 'package:lets_git_it/routes.dart';


void main() async {
  locatorSetUp();
  WidgetsFlutterBinding.ensureInitialized();
  await sl.get<DatabaseHelper>().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Git It',
      // locale: provider.locale,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      theme: mainTheme,
      routerConfig: appRouter,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _incrementCounter() {
    sl<AppModel>().incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: const HomeView(),
    );
  }
}

class GetItCounterExample extends StatelessWidget {
  const GetItCounterExample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          WatchCount()
        ],
      ),
    );
  }
}

class WatchCount extends StatelessWidget with WatchItMixin {
  const WatchCount({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Text(
      '${watchValue((AppModel x) => x.counter)}',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
