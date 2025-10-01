import 'package:flutter/material.dart';



class UserScreen extends StatelessWidget {
  const UserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: PopupMenuButton<String>(
        onSelected: (String value) {
          // Handle menu selection
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You selected: $value')),
          );
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'Option 1',
            child: Text('Option 1'),
          ),
          const PopupMenuItem<String>(
            value: 'Option 2',
            child: Text('Option 2'),
          ),
          const PopupMenuItem<String>(
            value: 'Option 3',
            child: Text('Option 3'),
          ),
        ],
        child: ElevatedButton(
          onPressed: null, // Required for PopupMenuButton child
          child: Text('Show Menu'),
        ),
      ),
    );
  }
}