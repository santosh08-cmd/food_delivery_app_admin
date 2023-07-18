import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:food_delivery_app_admin/screens/HomeScreen.dart';
import 'package:food_delivery_app_admin/screens/login_screen.dart';


class AuthService {
  //Handle Authentication
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  //Sign Out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Sign in
  signIn(email, password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      print('Signed in');
    }).catchError((e) {
      print(e);
    });
  }
}

class FirebaseServices{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference banners = FirebaseFirestore.instance.collection('slider');
  CollectionReference vendors = FirebaseFirestore.instance.collection('vendors');
  CollectionReference category = FirebaseFirestore.instance.collection('category');
  FirebaseStorage storage = FirebaseStorage.instance;

//banner
  Future<String>uploadBannerImageToDb(url) async{
    String downloadUrl = await storage.ref(url).getDownloadURL();
    if(downloadUrl!=null){
      firestore.collection('slider').add({
        'image' : downloadUrl,

      });
    }
    return downloadUrl;
  }

  deleteBannerImageFromDb(id)async{
    firestore.collection('slider').doc(id).delete();
  }

//vendor
  updatevendorStatus({id, status})async{
    vendors.doc(id).update({
      'accVerified' : status ? false : true

    });
    

  }

  updatevendorsStatus({id, status})async{

    vendors.doc(id).update({
      'isTopPicked' : status ? false : true

    });


  }

  //category
  Future<String>uploadCategoryImageToDb(url,catName) async{
    String downloadUrl = await storage.ref(url).getDownloadURL();
    if(downloadUrl!=null){
      category.doc(catName).set({
        'image' : downloadUrl,
        'name':catName,

      });
    }
    return downloadUrl;
  }











  Future<void> confirmDeleteDialog({title,message,context,id}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text('Cancel'),
              onPressed: ()async {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:  Text('Delete'),
              onPressed: ()async {
                deleteBannerImageFromDb(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialog({title,message,context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[

            TextButton(
              child:  Text('Ok'),
              onPressed: ()async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }





}

