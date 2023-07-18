import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app_admin/services/firebase_services.dart';
import 'package:food_delivery_app_admin/widgets/vendor/vendor_details_box.dart';

class vendorDataTable extends StatefulWidget {
  @override
  _vendorDataTableState createState() => _vendorDataTableState();
}

class _vendorDataTableState extends State<vendorDataTable> {
  FirebaseServices _services = FirebaseServices();

  int tag = 0;
  List<String> options = [
    'All kitchens',
    'Enable kitchen ',
    'Disable kitchen',
    'Top Picked',
    // 'Top Rated',
  ];
  bool topPicked;
  bool active;

  filter(val) {
    if (val == 1) {
      setState(() {
        active = true;
      });
    }
    if (val == 2) {
      setState(() {
        active = false;
      });
    }
    if (val == 3) {
      setState(() {
        topPicked = true;
      });
    }
    if (val == 0) {
      setState(() {
        topPicked = null;
        active = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChipsChoice<int>.single(
          value: tag,
          onChanged: (val) {
            setState(() {
              tag = val;
            });
            filter(val);
          },
          choiceItems: C2Choice.listFrom<int, String>(
            activeStyle: (i, v) {
              return C2ChoiceStyle(
                  brightness: Brightness.dark, color: Colors.green);
            },
            source: options,
            value: (i, v) => i,
            label: (i, v) => v,
          ),
        ),
        Divider(
          thickness: 5,
        ),
        StreamBuilder(
            stream: _services.vendors
                .where('isTopPicked', isEqualTo: topPicked)
                .where('accVerified', isEqualTo: active)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  showBottomBorder: true,
                  dataRowHeight: 60,
                  headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                  //table headers
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text('Enable/Disable'),
                    ),
                    DataColumn(
                      label: Text('Top Picked'),
                    ),
                    DataColumn(
                      label: Text('kitchen Name'),
                    ),
                    DataColumn(
                      label: Text('Rating'),
                    ),
                    DataColumn(
                      label: Text('Total Sales'),
                    ),
                    DataColumn(
                      label: Text('Mobile'),
                    ),
                    DataColumn(
                      label: Text('Email'),
                    ),
                    DataColumn(
                      label: Text('View Details'),
                    ),
                  ],
                  rows: _vendorDetailsRows(snapshot.data, _services),
                ),
              );
            }),
      ],
    );
  }

  List<DataRow> _vendorDetailsRows(
      QuerySnapshot snapshot, FirebaseServices services) {
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      return DataRow(cells: [
        DataCell(
          IconButton(
            onPressed: () {
              services.updatevendorStatus(
                id: document.data()['uid'],
                status: document.data()['accVerified'],
              );
            },
            icon: document.data()['accVerified']
                ? Icon(
                    Icons.add_circle_outline,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
          ),
        ),
        DataCell(
          IconButton(
            onPressed: () {
              services.updatevendorsStatus(
                id: document.data()['uid'],
                status: document.data()['isTopPicked'],
              );
            },
            icon: document.data()['isTopPicked']
                ? Icon(
                    Icons.add_circle_outline,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
          ),
        ),
        DataCell(
          Text(document.data()['shopName']),
        ),
        DataCell(
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.grey,
              ),
              Text('4.5'),
            ],
          ),
        ),
        DataCell(Text('20,000')),
        DataCell(
          Text(document.data()['mobile']),
        ),
        DataCell(
          Text(document.data()['email']),
        ),
        DataCell(IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return vendorDetailsBox(document.data()['uid']);
                });
          },
        )),
      ]);
    }).toList();
    return newList;
  }
}
