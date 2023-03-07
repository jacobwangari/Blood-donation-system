import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  void _sendEmailRequest() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    // User is not logged in
    return;
  }

  // Check if the email address entered by the user belongs to a registered user
  final email = _emailController.text.trim();
  final userQuerySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
  print(userQuerySnapshot);
  if (userQuerySnapshot.docs.isEmpty) {
    // No user with that email address found
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No user with that email address found')));
  } else {
    // Send email to user
    final recipientEmail = userQuerySnapshot.docs.first.get('email');
    const message =
        'Hello,\n\nWe received a request to send you an email. If you did not make this request, please ignore this message.\n\nBest regards,\nThe Safe Live Team';

    // Create a SMTP client to send the email
    final smtpServer = gmail(currentUser.email!, currentUser.refreshToken!);
    final messageToSend = Message()
      ..from = Address(currentUser.email!)
      ..recipients.add(recipientEmail)
      ..subject = 'Email request'
      ..text = message;

    try {
      await send(messageToSend, smtpServer);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email request sent.')),
      );
    } catch (e) {
      print('Error sending email: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to send email request. Please try again later.'),
      ));
    }
  }
}


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Blood'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _sendEmailRequest();
                  }
                },
                child: const Text('Request Blood'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
