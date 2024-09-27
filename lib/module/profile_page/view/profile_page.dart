import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  // You can replace these with dynamic data as needed
  final String avatarUrl =
      'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y'; // Placeholder avatar
  final String userName = 'John Doe';
  final int earnedPoints = 38;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true, // Centers the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adds padding around the content
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centers children horizontally
          children: [
            SizedBox(height: 20), // Spacer
            // Circle Avatar
            CircleAvatar(
              radius: 60, // Size of the avatar
              backgroundImage: NetworkImage(avatarUrl),
              backgroundColor: Colors.grey.shade200, // Placeholder color
            ),
            SizedBox(height: 20), // Spacer
            // User Name
            Text(
              userName,
              style: TextStyle(
                fontSize: 24, // Font size
                fontWeight: FontWeight.bold, // Bold text
              ),
            ),
            SizedBox(height: 10), // Spacer
            // Earned Points
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centers children horizontally
              children: [
                Icon(
                  Icons.star, // Star icon
                  color: Colors.amber, // Icon color
                ),
                SizedBox(width: 5), // Spacer
                Text(
                  '$earnedPoints Points',
                  style: TextStyle(
                    fontSize: 18, // Font size
                    color: Colors.grey[700], // Text color
                  ),
                ),
              ],
            ),
            // Additional Content (Optional)
            // You can add more widgets here, such as buttons or user details
          ],
        ),
      ),
    );
  }
}
