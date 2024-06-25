import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

// Define the fund widget
class Fund extends StatelessWidget {
  final String title;
  final NetworkImage image;
  final Uri url; // Add a field for the URL

  const Fund({
    super.key,
    required this.title,
    required this.image,
    required this.url, // Pass the URL when creating a Fund instance
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: image, width: 200, height: 200),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Ensure text starts from the left
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'this is fund description, \nbut rn it is empty',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
