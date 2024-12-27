import 'package:flutter/material.dart';
import 'add_review_view.dart';

class AgentInformation extends StatefulWidget {
  const AgentInformation({super.key});

  @override
  _AgentInformationState createState() => _AgentInformationState();
}

class _AgentInformationState extends State<AgentInformation> {
  void _onSelected(BuildContext context, String choice) {
    switch (choice) {
      case 'Review':
        // Handle Review action
        showModalBottomSheet(
          context: context,
          builder: (context) => const ReviewContainer(),
        );
        break;
      case 'Report':
        // Handle Report action
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Agent Information',
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          const SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage:
                        AssetImage('assets/images/agent_image.jpg'),
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Name: Suresh',
                      style: TextStyle(fontSize: 18.0, color: Colors.blue),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        popupMenuTheme: const PopupMenuThemeData(
                          color: Colors.white,
                        ),
                      ),
                      child: PopupMenuButton<String>(
                        onSelected: (String choice) =>
                            _onSelected(context, choice),
                        itemBuilder: (BuildContext context) {
                          return {'Review', 'Report'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice,
                                  style: const TextStyle(color: Colors.black)),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
