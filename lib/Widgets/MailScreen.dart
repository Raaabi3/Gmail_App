import 'package:flutter/material.dart';

class Mailscreen extends StatefulWidget {
  const Mailscreen({super.key});

  @override
  State<Mailscreen> createState() => _MailscreenState();
}

class _MailscreenState extends State<Mailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back,color: Colors.black,),
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Container(
                padding: EdgeInsets.all(16),
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selected Email Content",
                          style: TextStyle(fontSize: 24),
                        ),
                        Divider(),
                        Text("Full email content would appear here..."),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}