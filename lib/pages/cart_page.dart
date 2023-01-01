import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'intro_screen.dart';
import 'home_page.dart';
import 'search.dart';
import "payment.dart" as payment;
import 'login_page.dart' as login;
import 'signup.dart';
import 'account_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPage();
}

class _CartPage extends State<CartPage> {
  int index = 2;
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 158, 22),
        leading: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Icon(
            Icons.location_on,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Islamabad, Pakistan',
          style: GoogleFonts.openSans(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        titleSpacing: -12,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AccountPage();
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.person,
                size: 32.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        index: index,
        backgroundColor: Colors.white,
        color: Colors.orange,
        animationDuration: Duration(milliseconds: 450),
        onTap: (index) => Future.delayed(Duration(milliseconds: 550), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                if (index == 0) {
                  return HomePage();
                } else if (index == 1) {
                  return SearchPage();
                }
                return CartPage();
              },
            ),
          );
        }),
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.wysiwyg,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ],
      ),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Let's order fresh items for you
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
              ),
              // list view of cart
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: value.cartItems.length,
                    padding: EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            leading: Image.asset(
                              value.cartItems[index][2],
                              height: 36,
                            ),
                            title: Text(
                              value.cartItems[index][0],
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                              '\PKR' + value.cartItems[index][1],
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () {
                                  Provider.of<CartModel>(context, listen: false)
                                      .removeItemFromCart(index);
                                }),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // total amount + pay now

              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: SizedBox(
                  height: 120,
                  width: 700,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.redAccent,
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "SubTotal: ${value.calculateTotal()}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Discount: ${value.discount()}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 8),
                            // total price
                            Text(
                              'Total PKR ${value.calculateTotal() - value.discount()}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        // pay now
                        SizedBox(
                          width: 135,
                          height: 60,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.orange,
                                ),
                                padding: const EdgeInsets.all(12),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          Colors.white)),
                                  onPressed: () {
                                    if (value.calculateTotal() == 0) {
                                      showErrorMessage(
                                          "Cannot place order with an empty cart!");
                                    } else {
                                      if (login.isloggedin == false) {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return RegisterPage(onTap: null);
                                              },
                                            ));
                                      } else if (login.isloggedin == true) {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return payment.PaymentPage();
                                              },
                                            ));
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Pay Now",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
