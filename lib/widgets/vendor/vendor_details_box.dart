import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app_admin/constants.dart';
import 'package:food_delivery_app_admin/services/firebase_services.dart';

class vendorDetailsBox extends StatefulWidget {
  final String uid;
  vendorDetailsBox(this.uid);

  @override
  _vendorDetailsBoxState createState() => _vendorDetailsBoxState();
}

class _vendorDetailsBoxState extends State<vendorDetailsBox> {
  FirebaseServices _services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _services.vendors.doc(widget.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width * .3,
                    child: ListView(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    snapshot.data['imageUrl'],
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data['shopName'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                Text(snapshot.data['dialog']),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 4,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Text(
                                      'Contact Number',
                                      style: kvendorDetailsTextStyle,
                                    ),
                                  )),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(':'),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: Text(snapshot.data['mobile']),
                                  )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Text(
                                      'Email',
                                      style: kvendorDetailsTextStyle,
                                    ),
                                  )),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(':'),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: Text(snapshot.data['email']),
                                  )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Text(
                                      'Address',
                                      style: kvendorDetailsTextStyle,
                                    ),
                                  )),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(':'),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: Text(snapshot.data['address']),
                                  )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Text(
                                      'To Pick Status',
                                      style: kvendorDetailsTextStyle,
                                    ),
                                  )),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(':'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        child: snapshot.data['isTopPicked']
                                            ? Chip(
                                                backgroundColor: Colors.green,
                                                label: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'Top Picked',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Chip(
                                                backgroundColor: Colors.red,
                                                label: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.remove_circle,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                      'Disable',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            Wrap(
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.greenAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              CupertinoIcons
                                                  .money_dollar_circle,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text('Total Revenue'),
                                            Text('12,000'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.greenAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.shopping_cart,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text('Active Orders'),
                                            Text('6'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.greenAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.shopping_bag,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text(' Total Orders'),
                                            Text('130'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.greenAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.grain_outlined,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text('Products'),
                                            Text('160 Products'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.greenAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.list_alt_outlined,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text('Statements'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: snapshot.data['accVerified']
                          ? Chip(
                              backgroundColor: Colors.green,
                              label: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'Enable',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                            )
                          : Chip(
                              backgroundColor: Colors.red,
                              label: Row(
                                children: [
                                  Icon(
                                    Icons.remove_circle,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'Disable',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            )),
                ],
              ),
            ),
          );
        });
  }
}
