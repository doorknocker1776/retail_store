import 'package:flutter/material.dart';
import 'package:groceryapp/model/cart_model.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile icon
            CircleAvatar(
              radius: 48,
              backgroundImage: NetworkImage(
                "https://pbs.twimg.com/profile_images/1184635006701963265/g3-LmZv3_400x400.jpg",
              ),
            ),
            SizedBox(height: 16),
            // Name
            Text(
              "John Doe",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Email
            Text(
              "johndoe@example.com",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            // Phone number
            Text(
              "+1 123 456 7890",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            // Total orders
            Text(
              "Total orders: 20",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            // Edit button
            ElevatedButton(
              onPressed: () {
                // Navigate to the Edit Profile page
              },
              child: Text(
                "Edit Profile",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            // Recent purchases
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Order # $index"),
                    subtitle: Text("\PKR X"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}