import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganizationCard extends StatelessWidget {
   
  final String? id;
  final String? name;
  final Uri link;
  final String? description;
  final NetworkImage? logo;
  final List<String>? categories;
  final List<String>? countries;

  const OrganizationCard({
    super.key,
    this.id,
    this.name,
    required this.link,
    this.description,
    this.logo,
    this.categories,
    this.countries,
  });
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(link)) {
          await launchUrl(link);
        } else {
          throw 'Could not launch $link';
        }
      },
      
      child: Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name ?? 'Unknown Name',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            description ?? 'No Description Available',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8.0),
          if (logo != null)
            Image.network(
              logo!.url,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return const Icon(Icons.image_not_supported);
              },
            ),
        ],
      ),
    ),
    );
  }
}
