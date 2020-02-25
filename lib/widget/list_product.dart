import 'package:flutter/material.dart';

class ListProduct extends StatefulWidget {
  final String category;
  ListProduct({Key key, this.category}) : super(key: key);

  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {

//Field
String currentCategory = '';

//Method
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentCategory = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List $currentCategory'),
      ),
    );
  }
}
