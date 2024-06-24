import 'package:flutter/material.dart';

// Define the fund widget
class Fund extends StatelessWidget {
  final String title;
  final NetworkImage image;

  const Fund({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.grey,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(image: image, width: 200, height: 200),
          const SizedBox(width: 16),
          Column(children:[
          Text(title,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),
          const Text('this is fund description, \nbut rn it is empty',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ]
          ),
        ],
      ),
    );
  }
}
