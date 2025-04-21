import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isExpanded = false;

  void toggleDrawer() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.inbox, 'label': 'Inbox'},
    {'icon': Icons.send, 'label': 'Sent'},
    {'icon': Icons.archive, 'label': 'Archive'},
    {'icon': Icons.delete, 'label': 'Trash'},
    {'icon': Icons.settings, 'label': 'Settings'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Row(
          children: [
            Image.asset("assets/logo/gmail.jpg", width: 30),
            SizedBox(width: 10),
            Text("Gmail"),
            SizedBox(width: 100),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search mail",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.display_settings),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                ),
              ),
            ),
            SizedBox(width: 100),
            Icon(Icons.info_outline),
            SizedBox(width: 20),
            Icon(Icons.settings_outlined),
            SizedBox(width: 20),
            Icon(Icons.grid_on),
            SizedBox(width: 20),
            CircleAvatar(),
          ],
        ),
        leading: IconButton(
          icon: Icon(isExpanded ? Icons.menu_open : Icons.menu),
          onPressed: toggleDrawer,
        ),
      ),
      body: Row(
        children: [
          // Left Drawer Panel
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: isExpanded ? 200 : 70,
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children:
                        menuItems.map((item) {
                          return ListTile(
                            leading: Icon(item['icon']),
                            title: isExpanded ? Text(item['label']) : null,
                            onTap: () {
                              // Handle navigation
                            },
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Checkbox(value: false, onChanged: null,),
                          Icon(Icons.arrow_drop_down,size: 20,),
                          SizedBox(width: 20),
                          Icon(Icons.refresh,size: 20,),
                          SizedBox(width: 20),
                          Icon(Icons.more_vert,size: 20,),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    /*
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Icon(Icons.inbox),
                          SizedBox(width: 10),
                          Text("Inbox"),
                        ],
                      ),
                    ),*/
                    Expanded(
                      child: ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Divider(thickness: 1, color: Colors.grey[300]),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    Checkbox(value: false, onChanged: null),
                                    SizedBox(width: 10),
                                    Icon(Icons.star_border,color: Colors.grey,size: 20,),
                                    SizedBox(width: 10),
                                    SizedBox(
                                      width: 200,
                                      child: Text("Email $index"),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "This is email subject for item $index This is email subject for item $index This is email subject for item $index This is email subject for item $index This is email subject for item $index",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("10:30 AM",style: TextStyle(fontWeight: FontWeight.bold),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
