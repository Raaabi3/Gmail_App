import 'package:flutter/material.dart';

import '../Controllers/MailController.dart';
import '../Models/EmailModel.dart';

class Mailscreen extends StatelessWidget {
  final EmailModel? email;

  const Mailscreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    if (email == null) {
      return const Center(
        child: Text('Select an email to read', style: TextStyle(fontSize: 18)),
      );
    }
    final emailDate = email!.receivedAt;
    final formatted = formatEmailTimestamp(
      emailDate,
    );

    if (email == null) {
      return const Center(
        child: Text('Select an email to read', style: TextStyle(fontSize: 18)),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 25,
                  child: Text(
                    extractemailname(email!.sender)[0],
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      extractemailname(email!.sender),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      extractemail(email!.sender),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${extractTime(email!.receivedAt)[0]},${extractTime(email!.receivedAt)[1]},${extractTime(email!.receivedAt)[2]},${extractTime(email!.receivedAt)[3]}",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      "${extractTime(email!.receivedAt)[4]}",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              email!.subject,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            const Divider(),
            const SizedBox(height: 12),
            Text(email!.body, style: const TextStyle(fontSize: 16)),
            BottomAppBar(
              color: Colors.white,
              height: 100,
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 40),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.grey[700] ?? Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.subdirectory_arrow_left_rounded,
                          color: Colors.grey[700],
                        ),
                        Text(
                          "Reply",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100, 40),
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.grey[700] ?? Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.subdirectory_arrow_right_rounded,
                          color: Colors.grey[700],
                        ),
                        Text(
                          "Forward",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                  /*
                  Text(
                    "To: ${email!.recipient}",
                    style: const TextStyle(fontSize: 16),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
