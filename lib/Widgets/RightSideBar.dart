import 'package:flutter/material.dart';

class Rightsidebar extends StatefulWidget {
  final bool isExpanded;
  final List<Map<String, dynamic>> menuItems;
  final Function(bool) onToggle;
  final Duration animationDuration;

  const Rightsidebar({
    super.key, 
    required this.isExpanded, 
    required this.menuItems,
    required this.onToggle,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<Rightsidebar> createState() => _RightsidebarState();
}

class _RightsidebarState extends State<Rightsidebar> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.animationDuration,
      width: widget.isExpanded ? 200 : 70,
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(
              widget.isExpanded ? Icons.chevron_right : Icons.chevron_left,
            ),
            onPressed: () => widget.onToggle(!widget.isExpanded),
          ),
          if (widget.isExpanded)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Quick Access',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: ListView(
              children: widget.menuItems.map((item) {
                return ListTile(
                  leading: Icon(item['icon']),
                  title: widget.isExpanded ? Text(item['label']) : null,
                  onTap: () {},
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}