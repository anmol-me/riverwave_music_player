import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/home/view/home_screen.dart';

const _pageKey = ValueKey('_pageKey');
const _scaffoldKey = ValueKey('_scaffoldKey');

final appRouterProvider = Provider((ref) => appRouter);

final appRouter = GoRouter(
  routes: [
    // HomeScreen
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: _pageKey,
        child: HomeScreen(),
      ),
    ),
  ],
);
