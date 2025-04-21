import 'package:flutter/material.dart';

class MailList extends StatelessWidget {
  const MailList({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: ListView.builder(
        itemCount: 20,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 0.5),
              ),
              color: index.isEven ? Colors.blue[50] : Colors.white,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                highlightColor: Colors.blue[100],
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
                          const Icon(
                            Icons.circle,
                            size: 8,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Lisa Guerrero',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text("20:24", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Company goals for 2016',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Hello everyone I'm happy to share with our new company goal...",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}