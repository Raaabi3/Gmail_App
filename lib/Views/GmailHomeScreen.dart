import 'package:flutter/material.dart';
import 'package:gmail_app/Widgets/MailScreen.dart';
import 'package:provider/provider.dart';
import '../Helpers/Providers/AuthProvider.dart';
import '../Models/EmailModel.dart';
import '../Widgets/MailList.dart';
import '../Widgets/MainAppbar.dart';
import '../widgets/sidebar.dart';
import '../widgets/rightsidebar.dart';

class GmailHomeScreen extends StatefulWidget {
  const GmailHomeScreen({super.key});

  @override
  State<GmailHomeScreen> createState() => _GmailHomeScreenState();
}

class _GmailHomeScreenState extends State<GmailHomeScreen> {
  
  bool isLeftExpanded = false;
  bool isRightExpanded = false;
  final Duration _animationDuration = const Duration(milliseconds: 200);
  EmailModel? selectedEmail;

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          elevation: 1,
          shadowColor: Colors.black,
          backgroundColor: Colors.grey[50],
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/logo/gmail.jpg"),
          ),
          title: const Mainappbar(),
          // Ensure the AppBar doesn't constrain its children
          titleSpacing: 0,
          automaticallyImplyLeading: false,
        ),
      ),
      body: Consumer<Authprovider>(
        builder: (context, authProvider, child) {
          return Row(
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
              if (authProvider.emails == null)
                const Expanded(
                  flex: 5,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (authProvider.emails!.isEmpty)
                const Expanded(
                  flex: 5,
                  child: Center(child: Text('No emails found')),
                )
              else
                MailList(
                  emails: authProvider.emails!,
                  onEmailSelected: (email) {
                    setState(() {
                      selectedEmail = email;
                    });
                  },
                ),

              const VerticalDivider(thickness: 1, color: Colors.grey),

              // Email Content Section
              Flexible(flex: 7, child: Mailscreen(email: selectedEmail)),

              SizedBox(
                width: isRightExpanded ? 300 : 28,
                child: Rightsidebar(
                  isExpanded: isRightExpanded,
                  menuItems: chatItems,
                  onToggle: (expanded) {
                    setState(() {
                      isRightExpanded = expanded;
                    });
                  },
                  animationDuration: _animationDuration,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
