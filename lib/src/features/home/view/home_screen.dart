import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:adaptive_components/adaptive_components.dart';

import 'package:audio_player/src/shared/providers/providers.dart';
import 'package:audio_player/src/features/home/view/view.dart';
import 'package:audio_player/src/shared/views/views.dart';
import 'package:audio_player/src/shared/extensions.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final constraints = ref.watch(constraintsProvider);

    /// Mobile
    return constraints!.isMobile
        ? DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: const Text('Good Morning'),
                actions: const [BrightnessToggle()],
                bottom: const TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'Home'),
                    Tab(text: 'Recently Played'),
                    Tab(text: 'New Releases'),
                    Tab(text: 'Top Songs'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  const SingleChildScrollView(
                    child: Column(
                      children: [
                        HomeHighlights(),
                        HomeArtists(),
                      ],
                    ),
                  ),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
          )

        /// Desktop
        : Scaffold(
            body: SingleChildScrollView(
              child: AdaptiveColumn(
                children: [
                  AdaptiveContainer(
                    columnSpan: 12,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Good Morning'),
                          ),
                          BrightnessToggle(),
                        ],
                      ),
                    ),
                  ),
                  AdaptiveContainer(
                    columnSpan: 12,
                    child: const Column(
                      children: [
                        HomeHighlights(),
                        HomeArtists(),
                      ],
                    ),
                  ),
                  AdaptiveContainer(
                    columnSpan: 12,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Text('Recently played'),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
