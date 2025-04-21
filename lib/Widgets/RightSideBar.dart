import 'package:flutter/material.dart';

import '../Models/ChatMessage.dart';
import 'ChatBubble.dart';
import 'GradientText.dart';

class Rightsidebar extends StatefulWidget {
  final bool isExpanded;
  final Function(bool) onToggle;
  final Duration animationDuration;
  final List<Map<String, dynamic>> menuItems; // Add this line

  const Rightsidebar({
    super.key,
    required this.isExpanded,
    required this.onToggle,
    this.animationDuration = const Duration(milliseconds: 200),
    required this.menuItems, // Accept menuItems
  });

  @override
  State<Rightsidebar> createState() => _RightsidebarState();
}

class _RightsidebarState extends State<Rightsidebar> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: _messageController.text, isMe: true));
      _messageController.clear();
    });

    // Simulate bot reply after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add(
          ChatMessage(
            text: "Thanks for your message! We'll get back to you soon.",
            isMe: false,
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.animationDuration,
      width: widget.isExpanded ? 300 : 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        children: [
          // Header with collapse button
          Container(
            height: 50,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                widget.isExpanded
                    ? IconButton(
                      icon: Icon(Icons.chevron_right),
                      color: Colors.white,
                      onPressed: () => widget.onToggle(!widget.isExpanded),
                    )
                    : GestureDetector(
                      onTap: () => widget.onToggle(!widget.isExpanded),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.5),
                          child: Image.asset("assets/logo/gemini.png", width: 25),
                        ),
                      ),
                    ),

                if (widget.isExpanded) ...[
                  const Text(
                    'Chat with Gemini',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ],
            ),
          ),
          if (widget.isExpanded)
            Expanded(
              child:
                  _messages.isEmpty
                      ? Center(
                        child: GradientText(
                          'Welcome Mohamed!',
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.red],
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        reverse: false,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          return ChatBubble(
                            message: message.text,
                            isMe: message.isMe,
                          );
                        },
                      ),
            )
          else
            const Spacer(),

          // Input area (only visible when expanded)
          if (widget.isExpanded)
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Ask Gemini...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.black),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
