import 'package:flutter/material.dart';

class TermsAndServicesPage extends StatelessWidget {
  const TermsAndServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Services'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Terms & Services",
                style:
                    textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                "Welcome to our School Parent Application. By accessing or using this app, "
                "you agree to the following Terms and Services. Please read them carefully.",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              _sectionTitle(context, "1. Acceptance of Terms"),
              Text(
                "By downloading, accessing, or using this application, you agree to be bound "
                "by these Terms and any additional guidelines or rules posted within the app.",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              _sectionTitle(context, "2. Purpose of the Application"),
              Text(
                "This application is designed to provide parents with access to school-related "
                "information about their child, including attendance, grades, announcements, "
                "homework, events, and communication tools.",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              _sectionTitle(context, "3. User Responsibilities"),
              Text(
                "Users agree to:\n"
                "• Use the application responsibly.\n"
                "• Keep login credentials secure.\n"
                "• Provide accurate information when required.\n"
                "• Avoid any misuse, manipulation, or unauthorized access to the system.",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              _sectionTitle(context, "4. Privacy & Data Protection"),
              Text(
                "We are committed to protecting your personal information. Any data collected "
                "through this app is used solely for educational and communication purposes "
                "within the school system. No data is shared with third parties without consent.",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              _sectionTitle(context, "5. Limitations of Use"),
              Text(
                "You may not:\n"
                "• Attempt to hack, modify, or reverse-engineer the application.\n"
                "• Use the app to harass or harm others.\n"
                "• Upload inappropriate, harmful, or unauthorized content.",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              _sectionTitle(context, "6. Service Availability"),
              Text(
                "We strive to ensure that the application is accessible at all times.\n"
                "However, we do not guarantee uninterrupted access and may temporarily "
                "suspend the service for maintenance, updates, or technical issues.",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              _sectionTitle(context, "7. Modifications to the Terms"),
              Text(
                "The school or app developers reserve the right to update or modify these "
                "Terms at any time. Continued use of the application signifies your acceptance "
                "of any changes.",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              _sectionTitle(context, "8. Contact Information"),
              Text(
                "If you have any questions regarding these Terms & Services, please contact "
                "the school administration or the developers.",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
