// import 'package:flutter/material.dart';
// import 'package:flutter_admin_scaffold/admin_scaffold.dart';
// import 'package:food_delivery_app_admin/services/sidebar.dart';

// class OrderScreen extends StatelessWidget {
//   static const String id = 'order-screen';

//   @override
//   Widget build(BuildContext context) {
//     SideBarWidget _sideBar = SideBarWidget();
//     return AdminScaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.greenAccent,
//         iconTheme: IconThemeData(color: Colors.white),
//         title: const Text('FoodiesHub App Dashboard'),
//       ),
//       sideBar: _sideBar.sideBarMenus(context, OrderScreen.id),
//       body: SingleChildScrollView(
//         child: Container(
//           alignment: Alignment.topLeft,
//           padding: const EdgeInsets.all(10),
//           child: Text(
//             'Manage Order',
//             style: TextStyle(
//               fontWeight: FontWeight.w700,
//               fontSize: 36,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
