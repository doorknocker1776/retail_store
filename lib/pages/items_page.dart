import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/grocery_item_tile.dart';
import 'cart_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import "account_page.dart";
import "search.dart";
import 'package:groceryapp/pages/home_page.dart';
import 'package:groceryapp/model/items_model.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'intro_screen.dart';

String type = "";
List X = [];

class itemspage extends StatefulWidget {
  final GlobalKey<CurvedNavigationBarState> _navigationBarKey =
      GlobalKey<CurvedNavigationBarState>();

  @override
  State<StatefulWidget> createState() {
    return new itemspageState();
  }
}

void listmaker(var t, int i) {
  X.add([
    t['status'][i][0],
    '${t['status'][i][1]}',
    "lib/images/${t['status'][i][0].toLowerCase()}.png",
    Colors.grey
  ]);
}

class itemspageState extends State<itemspage> {
  final GlobalKey<CurvedNavigationBarState> _navigationBarKey =
      GlobalKey<CurvedNavigationBarState>();
  int index = 0;
  Future<List> _getItems() async {
    if (type == "elec") {
      var response;
      response = await http.get((Uri.parse("http://10.0.2.2:5000/populate")));
      var jsondata = json.decode(response.body);
      List<itemsinfo> items = [];
      for (int i = 0; i < jsondata['status'].length; i++) {
        listmaker(jsondata, i);
        itemsinfo item = itemsinfo(
            "${jsondata['status'][i][0]}",
            "${jsondata['status'][i][1]}",
            "lib/images/${jsondata['status'][i][0].toLowerCase()}.png");
        items.add(item);
      }

      return items;
    } else if (type == "grocer") {
      var response;
      response = await http.get((Uri.parse("http://10.0.2.2:5000/populate1")));
      var jsondata = json.decode(response.body);
      List<itemsinfo> items = [];
      for (int i = 0; i < jsondata['status'].length; i++) {
        listmaker(jsondata, i);

        itemsinfo item = itemsinfo(
            "${jsondata['status'][i][0]}",
            "${jsondata['status'][i][1]}",
            "lib/images/${jsondata['status'][i][0].toLowerCase()}.png");
        items.add(item);
      }
      return items;
    } else if (type == "fash") {
      var response;
      response = await http.get((Uri.parse("http://10.0.2.2:5000/populate2")));
      var jsondata = json.decode(response.body);
      List<itemsinfo> items = [];
      for (int i = 0; i < jsondata['status'].length; i++) {
        listmaker(jsondata, i);

        itemsinfo item = itemsinfo(
            "${jsondata['status'][i][0]}",
            "${jsondata['status'][i][1]}",
            "lib/images/${jsondata['status'][i][0].toLowerCase()}.png");
        items.add(item);
      }
      return items;
    } else if (type == "nuu") {
      var response;
      response = await http.get((Uri.parse("http://10.0.2.2:5000/populate3")));
      var jsondata = json.decode(response.body);
      List<itemsinfo> items = [];
      for (int i = 0; i < jsondata['status'].length; i++) {
        listmaker(jsondata, i);

        itemsinfo item = itemsinfo(
            "${jsondata['status'][i][0]}",
            "${jsondata['status'][i][1]}",
            "lib/images/${jsondata['status'][i][0].toLowerCase()}.png");
        items.add(item);
      }
      return items;
    }
    return [];
  }

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
            style: GoogleFonts.openSans(
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
                future: _getItems(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(child: Center(child: Text("Loading")));
                  } else {
                    return GridView.builder(
                      padding: const EdgeInsets.all(20),
                      //physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.2,
                      ),
                      itemBuilder: (context, index) {
                        return GroceryItemTile(
                          itemName: snapshot.data[index].name,
                          itemPrice: snapshot.data[index].price + " PKR",
                          imagePath: snapshot.data[index].loc,
                          color: snapshot.data[index].color,
                          onPressed: () {
                            List Item = [
                              snapshot.data[index].name,
                              snapshot.data[index].price,
                              snapshot.data[index].loc,
                              snapshot.data[index].color
                            ];
                            Provider.of<CartModel>(context, listen: false)
                                .addItemToCart(Item);
                          },
                        );
                      },
                    );
                  }
                })));
  }
}

class itemsinfo {
  final String name;
  final String price;
  final String loc;
  var color = Colors.grey;
  itemsinfo(this.name, this.price, this.loc);
}
