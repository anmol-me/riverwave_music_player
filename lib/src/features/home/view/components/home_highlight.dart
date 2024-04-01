import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '/src/shared/views/clickable.dart';

class HomeHighlights extends StatelessWidget {
  const HomeHighlights({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Clickable(
              child: SizedBox(
                height: 275,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/news/concert.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: () => launchUrl(Uri.parse('https://docs.flutter.dev')),
            ),
          ),
        ),
      ],
    );
  }
}
