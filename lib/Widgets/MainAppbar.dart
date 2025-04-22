import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Helpers/Providers/AuthProvider.dart';

class Mainappbar extends StatefulWidget {
  const Mainappbar({super.key});

  @override
  State<Mainappbar> createState() => _MainappbarState();
}

class _MainappbarState extends State<Mainappbar> {
  bool _isDropdownOpen = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _dropdownOverlayEntry; 
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Authprovider>(context);
    final currentEmail = authProvider.currentUserEmail;
    final previousEmails = authProvider.previousUserEmails ?? [];
    final otherEmails =
        previousEmails.where((email) => email != currentEmail).toList();

    return Row(
      children: [
        const Text("Gmail"),
        const SizedBox(width: 50),
        _navButton("Mail"),
        _navButton("Address book"),
        _navButton("NotePad"),
        _navButton("Files"),
        _navButton("Manage"),
        const Spacer(),
        if (currentEmail != null)
          CompositedTransformTarget(
            link: _layerLink,
            child: GestureDetector(
              onTap: () {
                if (_isDropdownOpen) {
                  _removeDropdown();
                } else {
                  _showDropdown();
                }
                setState(() {
                  _isDropdownOpen = !_isDropdownOpen;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      currentEmail,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      _isDropdownOpen
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(width: 8),
        const CircleAvatar(),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isDropdownOpen) {
      _showDropdown();
    }
  }

  void _showDropdown() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _dropdownOverlayEntry = OverlayEntry(
      builder:
          (context) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _removeDropdown();
              setState(() {
                _isDropdownOpen = false;
              });
            },
            child: Stack(
              children: [
                Positioned(
                  left: offset.dx,
                  top: offset.dy + size.height,
                  width: 250,
                  child: CompositedTransformFollower(
                    link: _layerLink,
                    showWhenUnlinked: false,
                    offset: Offset(0, size.height),
                    child: Material(
                      elevation: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: _buildDropdownContent(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );

    overlay.insert(_dropdownOverlayEntry!);
  }

  void _removeDropdown() {
    _dropdownOverlayEntry?.remove();
    _dropdownOverlayEntry = null;
  }

  Widget _buildDropdownContent() {
    final authProvider = Provider.of<Authprovider>(context);
    final currentEmail = authProvider.currentUserEmail;
    final previousEmails = authProvider.previousUserEmails ?? [];
    final otherEmails =
        previousEmails.where((email) => email != currentEmail).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAccountItem(currentEmail!, isCurrent: true),
        if (otherEmails.isNotEmpty) ...[
          const Divider(height: 1),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Other accounts',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          ...otherEmails.map((email) => _buildAccountItem(email)),
        ],
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.add, size: 20, color: Colors.blue),
          title: const Text(
            'Add another account',
            style: TextStyle(fontSize: 13),
          ),
          onTap: () {
            setState(() => _isDropdownOpen = false);
            _addNewEmail(context);
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          minLeadingWidth: 24,
          dense: true,
        ),
      ],
    );
  }

  Widget _buildAccountItem(String email, {bool isCurrent = false}) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 14,
        backgroundColor: Colors.grey,
        child: Icon(Icons.person, size: 16, color: Colors.white),
      ),
      title: Text(
        email,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing:
          isCurrent
              ? const Icon(Icons.check, size: 16, color: Colors.blue)
              : null,
      onTap: () {
        setState(() => _isDropdownOpen = false);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      minLeadingWidth: 24,
      dense: true,
    );
  }

  void _addNewEmail(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Add New Email"),
            content: const Text("Implement your add logic here."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          ),
    );
  }

  Widget _navButton(String title) => TextButton(
    onPressed: () {},
    child: Text(title, style: const TextStyle(color: Colors.grey)),
  );
}
