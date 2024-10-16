import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lets_git_it/view/home_nav.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    // Define a route that will be used to navigate to the home page
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeNavigator();
      },
      routes: const <GoRoute>[
        // Define a nested route that will be used to navigate to the home page
        // GoRoute(
        //   path: 'test',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return const StackedUnstackedView();
        //   },
        // ),
      ]
    ),
  ],
);