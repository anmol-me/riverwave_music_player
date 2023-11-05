import 'package:audio_player/src/shared/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/classes/classes.dart';
import '../../../../shared/views/views.dart';

class ArtistEvents extends ConsumerWidget {
  const ArtistEvents({
    super.key,
    required this.artist,
  });

  final Artist artist;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final colors = Theme.of(context).colorScheme;

    return AdaptiveTable<Event>(
      breakpoint: 720,
      items: artist.events,
      itemBuilder: (item, index) {
        final dateParts = item.date.split('/');

        return ListTile(
          leading: Container(
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: dateParts[0],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                    TextSpan(
                      text: '/',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                    TextSpan(
                      text: dateParts[1],
                      style: TextStyle(
                        fontSize: 14.0,
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          title: Text(item.title),
          subtitle: Text(item.location),
          trailing: IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {},
          ),
        );
      },
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Date',
          ),
          numeric: true,
        ),
        DataColumn(
          label: Text(
            'Event',
          ),
        ),
        DataColumn(
          label: Text(
            'Location',
          ),
        ),
        DataColumn(
          label: Text(
            'More info',
          ),
        ),
      ],
      rowBuilder: (item, index) => DataRow.byIndex(index: index, cells: [
        DataCell(
          Text(item.date),
        ),
        DataCell(
          Row(children: [
            Expanded(child: Text(item.title)),
          ]),
        ),
        DataCell(
          Text(item.location),
        ),
        DataCell(
          Clickable(
            child: Text(
              item.link,
              style: TextStyle(
                color: theme.customColor(linkColor),
                decoration: TextDecoration.underline,
              ),
            ),
            onTap: () => launchUrl(Uri.parse('https://docs.flutter.dev')),
          ),
        ),
      ]),
    );
  }
}
