import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Fund extends StatelessWidget {
  final String title;
  final NetworkImage image;
  final String description;

  const Fund({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Implement URL launching logic if needed
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRect(
              child: Container(
                width: 200, // Set the desired width
                height: 200, // Set the desired height
                child: Image(image: image, fit: BoxFit.cover), // Use BoxFit.cover to crop the image
              ),
            ),
            const SizedBox(width: 16),
            Flexible( // Wrap the description in a Flexible widget
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    softWrap: true, // Enable soft wrapping
                    overflow: TextOverflow.fade, // Fade out text that overflows
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
