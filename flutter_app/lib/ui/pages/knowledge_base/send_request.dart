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
      Uri.parse('http://158.160.153.243:8000/knowledge-base/send-request'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'requestText': request}),
    );
    if(response.statusCode == 200) {
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ThankYouPage()),
    );
    } else{
      throw Exception('Failed to send request');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Detailed Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Please formulate your request as detailed as possible',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), 
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null, // Allows the TextField to expand vertically
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your request here...',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _submitRequest,
              child: const Text('Save & Send'),
            ),
          ],
        ),
      ),
    );
  }
}