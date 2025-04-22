import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../Controllers/MailController.dart';
import '../Models/EmailModel.dart';

import 'package:flutter/material.dart';

class MailList extends StatefulWidget {
  final List<EmailModel> emails;
  final Function(EmailModel) onEmailSelected;

  const MailList({
    super.key,
    required this.emails,
    required this.onEmailSelected,
  });

  @override
  State<MailList> createState() => _MailListState();
}

class _MailListState extends State<MailList> {
  String _sortOption = "Newest First";
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  List<EmailModel> _filteredEmails = [];
  Set<int> _selectedEmails = {}; 
  bool _selectAll = false;

  @override
  void initState() {
    super.initState();
    _filteredEmails = List.from(widget.emails);
    _searchController.addListener(_handleSearch);
  }

  void _handleSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredEmails =
          widget.emails.where((email) {
            return email.sender.toLowerCase().contains(query) ||
                email.subject.toLowerCase().contains(query) ||
                email.body.toLowerCase().contains(query);
          }).toList();
      _applySort(); 
    });
  }

  void _applySort() {
    _filteredEmails.sort((a, b) {
      if (_sortOption == 'Newest First') {
        return b.receivedAt.compareTo(a.receivedAt);
      } else {
        return a.receivedAt.compareTo(b.receivedAt);
      }
    });
  }

  void _toggleSelectAll() {
    setState(() {
      if (_selectAll) {
        _selectedEmails.clear();
      } else {
        _selectedEmails = Set.from(
          List.generate(_filteredEmails.length, (index) => index),
        );
      }
      _selectAll = !_selectAll;
    });
  }

  void _toggleSelectEmail(int index) {
    setState(() {
      if (_selectedEmails.contains(index)) {
        _selectedEmails.remove(index);
      
      } else {
        _selectedEmails.add(index); 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 5,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search mail...",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _selectAll,
                        onChanged: (_) => _toggleSelectAll(),
                      ),
                      const Spacer(),
                      const Text(
                        "Sort:",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: _sortOption,
                        items:
                            ['Newest First', 'Oldest First'].map((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _sortOption = value;
                              _applySort();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final email = _filteredEmails[index];
                final isSelected = _selectedEmails.contains(index);
final emailDate = email.receivedAt;
final formatted = formatEmailTimestamp(emailDate);
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 5,
                  ),
                  child: Container(
                    color: email.isRead ? Colors.grey[200] : Colors.white,
                    child: InkWell(
                      onTap: () => widget.onEmailSelected(email),
                      onLongPress:
                          () =>
                              _toggleSelectEmail(index), 
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                isSelected
                                    ? Checkbox(
                                      value: isSelected,
                                      onChanged:
                                          (_) => _toggleSelectEmail(index),
                                    )
                                    : SizedBox(),
                                Icon(
                                  email.isRead
                                      ? Icons.check_circle
                                      : Icons.circle,
                                  size: 8,
                                  color:
                                      email.isRead
                                          ? Colors.grey
                                          : Colors.blueAccent,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  extractNameFromSender(email.sender),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  formatted,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              email.subject,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              email.body,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }, childCount: _filteredEmails.length),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
