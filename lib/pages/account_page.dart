import 'package:flutter/material.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'login_page.dart';

String username = "-";

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile icon
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.orange,
              backgroundImage: NetworkImage(
                "https://pbs.twimg.com/profile_images/1184635006701963265/g3-LmZv3_400x400.jpg",
              ),
            ),
            SizedBox(height: 16),
            // Name
            Text(
              username,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Phone number
            SizedBox(height: 8),
            // Total orders
            Text(
              "Total orders: 0",
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
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
              ),
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
