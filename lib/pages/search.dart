import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/grocery_item_tile.dart';
import 'package:groceryapp/model/home_model.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'intro_screen.dart';
import "home_page.dart";
import "cart_page.dart";
import 'package:groceryapp/model/cart_model.dart';
import 'account_page.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:groceryapp/pages/account_page.dart' as ac;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<CurvedNavigationBarState> _navigationBarKey =
      GlobalKey<CurvedNavigationBarState>();

  Future<List> _getOrders() async {
    String un = ac.username;
    if(un == "-"){return [];}
    else{
    var response;
    response = await http.get((Uri.parse(
        "http://10.0.2.2:5000/popuorders?UserID=${un}")));
    var jsondata = json.decode(response.body);
    List<ordersinfo> orders = [];
    for(int i = 0; i < jsondata['status'].length; i++){
      ordersinfo order = ordersinfo("${jsondata['status'][i][0]}",
          "${jsondata['status'][i][1]}","${jsondata['status'][i][2]}","${jsondata['status'][i][3]}");
      orders.add(order);
    }
    print(orders.length);
    return orders;}
  }

  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

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
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        titleSpacing: -12,
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AccountPage();
                },
              ),
            ),
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
                  return IntroScreen();
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

      body: Container(
        child: FutureBuilder(
          future: _getOrders(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(ac.username == "-"){
              return Container(
                  child: Center(
                      child: Text("Please create an account to view order history")
                  )
              );
            }
            else if(snapshot.data == null){
              return Container(
                child: Center(
                  child: Text("Loading")
                )
              );
            }
            else{
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                      title: Text("Bill: "+snapshot.data[index].billid),
                      subtitle: Text(" Total: "+snapshot.data[index].total+"PKR Subtotal: "+snapshot.data[index].subtotal+"PKR Discount: "+snapshot.data[index].discount+"PKR"),
                  );
                },
              );
            }
          }
        )
      )
    );
  }
} //onpressed:

class ordersinfo {
  final String billid;
  final String total;
  final String discount;
  final String subtotal;
  ordersinfo(this.billid, this.total, this.discount, this.subtotal);
}