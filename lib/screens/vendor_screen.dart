import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:food_delivery_app_admin/services/sidebar.dart';
import 'package:food_delivery_app_admin/widgets/vendor/vendor_datatable_widget.dart';

class vendorScreen extends StatefulWidget {
  static const String id = 'vendor-screen';
  @override
  State<vendorScreen> createState() => _vendorScreenState();
}

class _vendorScreenState extends State<vendorScreen> {
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Home Hygenic Food'),
      ),
      sideBar: _sideBar.sideBarMenus(context, vendorScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage kitchens',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Manage all the vendors Activities'),
              Divider(
                thickness: 5,
              ),
              vendorDataTable(),
              Divider(
                thickness: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
