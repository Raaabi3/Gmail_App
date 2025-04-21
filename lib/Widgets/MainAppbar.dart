import 'package:flutter/material.dart';

class Mainappbar extends StatefulWidget {
  const Mainappbar({super.key});

  @override
  State<Mainappbar> createState() => _MainappbarState();
}

class _MainappbarState extends State<Mainappbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Gmail"),
        const SizedBox(width: 50),
        TextButton(
          onPressed: () {},
          child: const Text("Mail", style: TextStyle(color: Colors.grey)),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Address book",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {},
          child: const Text("NotePad", style: TextStyle(color: Colors.grey)),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {},
          child: const Text("Files", style: TextStyle(color: Colors.grey)),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {},
          child: const Text("Manage", style: TextStyle(color: Colors.grey)),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Text(
                "User Name",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.arrow_drop_down, color: Colors.grey
              ),
            ],
          ),
        ),

        const CircleAvatar(),
      ],
    );
  }
}
