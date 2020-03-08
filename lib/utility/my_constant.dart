import 'package:flutter/material.dart';

class MyConstant {
  
//Field
List<String> banners = ['images/banner1.png'];
List<String> categorys = ['BangKaeo', 'Saiberia','ThaiRidgeback'];

Widget mySizebox = SizedBox(
  height: 10.0, 
  width: 5.0,
  );

  TextStyle titleH1 = TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey.shade700,
      );
      TextStyle titleH2 = TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent.shade700,
      );
       TextStyle titleH3 = TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        color: Colors.cyan.shade700,
      );
      TextStyle titleH4 = TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );
     

//Method
MyConstant();

}