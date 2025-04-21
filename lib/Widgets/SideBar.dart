import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final bool isExpanded;
  final List<Map<String, dynamic>> menuItems;
  final Function(bool) onToggle;

  const Sidebar({
    super.key, 
    required this.isExpanded, 
    required this.menuItems,
    required this.onToggle,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: widget.isExpanded ? 140 : 70,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: widget.menuItems.map((item) {
                return ListTile(
                  leading: Icon(item['icon']),
                  title: widget.isExpanded ? Text(item['label']) : null,
                  onTap: () {
                    widget.onToggle(!widget.isExpanded);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}