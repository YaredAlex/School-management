import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About This App",
                style:
                    textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                "This School Parent App is designed to help parents stay connected "
                "with their child's academic activities, school updates, and daily progress. "
                "The application provides real-time access to attendance, grades, announcements, "
                "timetables, homework, school events, and more.",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Text(
                "Our Mission",
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                "Our mission is to simplify communication between parents and the school, "
                "ensuring transparency, easy access to information, and improved involvement "
                "in a child's learning journey.",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Developer Section Title
                  Text(
                    "About the Developers",
                    style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // Developer Info Box
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "https://mellainnovation.com/assets/logomain-0xJVy25o.png",
                            width: 60,
                            height: 60,
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Developer Info Text + Clickable Link
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "This application is developed and maintained by Mella Innovation.",
                                style: textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () async {
                                  final uri =
                                      Uri.parse("https://mellainnovation.com/");
                                  if (!await launchUrl(
                                    uri,
                                    mode: LaunchMode.externalApplication,
                                  )) {
                                    throw Exception("Could not launch $uri");
                                  }
                                },
                                child: Text(
                                  "Visit Website",
                                  style: textTheme.bodyMedium?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Footer
                  Center(
                    child: Text(
                      "Powered by Mella Innovation",
                      style: textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
