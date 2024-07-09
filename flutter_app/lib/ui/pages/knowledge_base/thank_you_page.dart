import 'package:flutter/material.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Match the background color
      body: Padding(
        padding: const EdgeInsets.all(24.0), // Add padding for visual space
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 4, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), 
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0), 
                child: Column(
                  children: <Widget>[
                    const Icon(
                      Icons.check_circle_outline,
                      color: Colors.blueAccent, 
                      size: 80,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Thank You',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0), // Match text color
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'For sending a request. We will notify the editor and he will create an article as soon as possible.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home'); // Navigate back to the homepage
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.grey[200],
                        backgroundColor: Colors.blueAccent, 
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48.0, vertical: 16.0
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Go to Homepage'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}