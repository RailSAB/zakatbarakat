import 'dart:convert';
import 'package:flutter_app/ui/pages/knowledge_base/thank_you_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SendRequest extends StatefulWidget {
  const SendRequest({super.key});

  @override
  State<SendRequest> createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _submitRequest() async {
    final request = _controller.text;
    final response = await http.post(
      Uri.parse('https://weaviatetest.onrender.com/knowledge-base/send-request'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'requestText': request}),
    );
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ThankYouPage()),
      );
    } else {
      throw Exception('Failed to send request');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Send Detailed Request'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0), // Increased padding for better visual space
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
            children: <Widget>[
              const SizedBox(height: 20),
              Text(
                'Please formulate your request as detailed as possible',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _controller,
                    maxLines: null, // Allows the TextField to expand vertically
                    decoration: InputDecoration(
                      hintText: 'Enter your request here...',
                      border: InputBorder.none,
                      
                    ),
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _submitRequest,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.grey[200],
                    backgroundColor: Colors.blueAccent, // Button text color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Save & Send'),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}