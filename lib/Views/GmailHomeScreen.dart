import 'package:flutter/material.dart';
import 'package:gmail_app/Widgets/MailScreen.dart';
import '../Widgets/MailList.dart';
import '../Widgets/MainAppbar.dart';
import '../widgets/sidebar.dart';
import '../widgets/rightsidebar.dart'; // Import the new right sidebar

class GmailHomeScreen extends StatefulWidget {
  const GmailHomeScreen({super.key});

  @override
  State<GmailHomeScreen> createState() => _GmailHomeScreenState();
}

class _GmailHomeScreenState extends State<GmailHomeScreen> {
  bool isLeftExpanded = false;
  bool isRightExpanded = false;
  final Duration _animationDuration = const Duration(milliseconds: 200);

  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.inbox, 'label': 'Inbox'},
    {'icon': Icons.send, 'label': 'Sent'},
    {'icon': Icons.archive, 'label': 'Archive'},
    {'icon': Icons.delete, 'label': 'Trash'},
    {'icon': Icons.settings, 'label': 'Settings'},
  ];

  final List<Map<String, dynamic>> chatItems = [
    {'icon': Icons.chat, 'label': 'Recent Chats'},
    {'icon': Icons.help, 'label': 'Help Desk'},
    {'icon': Icons.person, 'label': 'Contacts'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black,
        backgroundColor: Colors.grey[50],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/logo/gmail.jpg"),
        ),
        title: Mainappbar(),
      ),
      body: Row(
        children: [
          Sidebar(
            isExpanded: isLeftExpanded,
            menuItems: menuItems,
            onToggle: (expanded) {
              setState(() {
                isLeftExpanded = expanded;
              });
            },
          ),
          const VerticalDivider(thickness: 1, color: Colors.grey),
          const MailList(),
          const VerticalDivider(thickness: 1, color: Colors.grey),
          const Flexible(flex: 7, child: Mailscreen()),
          Rightsidebar(
            isExpanded: isRightExpanded,
            menuItems: chatItems,
            onToggle: (expanded) {
              setState(() {
                isRightExpanded = expanded;
              });
            },
            animationDuration: _animationDuration,
          ),
        ],
      ),
    );
  }
}