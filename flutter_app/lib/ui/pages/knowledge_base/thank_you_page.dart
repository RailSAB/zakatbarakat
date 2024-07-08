import 'package:flutter/material.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.check_circle_outline, // Green checkmark icon
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20), // Space between icon and text
            const Text(
              'Thank You',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10), // Space between texts
            const Text(
              'For sending a request. We will notify the editor and he will create an article as soon as possible.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40), // Space before the button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home'); // Navigate back to the homepage
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
              ),
              child: const Text('Go to Homepage'),
            ),
          ],
        ),
      ),
    );
  }
}