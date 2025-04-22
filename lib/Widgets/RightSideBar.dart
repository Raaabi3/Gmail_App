import 'package:flutter/material.dart';
import '../Models/ChatMessage.dart';
import 'ChatBubble.dart';
import 'GradientText.dart';

class Rightsidebar extends StatefulWidget {
  final bool isExpanded;
  final Function(bool) onToggle;
  final Duration animationDuration;
  final List<Map<String, dynamic>> menuItems;

  const Rightsidebar({
    super.key,
    required this.isExpanded,
    required this.onToggle,
    this.animationDuration = const Duration(milliseconds: 200),
    required this.menuItems,
  });

  @override
  State<Rightsidebar> createState() => _RightsidebarState();
}

class _RightsidebarState extends State<Rightsidebar> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
  if (_messageController.text.trim().isEmpty) return;

  setState(() {
    _messages.add(ChatMessage(text: _messageController.text, isMe: true));
    _messageController.clear();
  });

  _scrollController.animateTo(
    _scrollController.position.maxScrollExtent + 100,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOut,
  );

  Future.delayed(const Duration(seconds: 1), () {
    setState(() {
      _messages.add(
        ChatMessage(
          text: "Thanks for your message! We'll get back to you soon.",
          isMe: false,
        ),
      );
    });
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  });
}


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: widget.animationDuration,
          right: widget.isExpanded ? 0 : -300,
          top: 0,
          bottom: 0,
          child: Material(
            elevation: 4,
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(left: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Column(
                children: [
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
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          color: Colors.white,
                          onPressed: () => widget.onToggle(false),
                        ),
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
                          icon: const Icon(Icons.more_vert),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child:
                        _messages.isEmpty
                            ? Center(
                              child: GradientText(
                                'Welcome Mohamed!',
                                gradient: const LinearGradient(
                                  colors: [Colors.blue, Colors.red],
                                ),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                            : ListView.builder(
                              controller: _scrollController,

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
                  ),
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
            ),
          ),
        ),
        !widget.isExpanded
            ? Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height * 0.4,
              child: GestureDetector(
                onTap: () => widget.onToggle(!widget.isExpanded),
                child: Container(
                  width: 24,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(-2, 0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Text(
                        'Gemini',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            : Container(),
      ],
    );
  }
}
