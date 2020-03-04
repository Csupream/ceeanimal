import 'package:flutter/material.dart';

class DetailProduct extends StatefulWidget {
  final String name, detail, pathUrl, detail2;
  DetailProduct({Key key, this.name, this.detail, this.pathUrl, this.detail2})
      : super(key: key);

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  //Field
  String name = '', detail, pathUrl, detail2;

  //Method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.name;
    detail = widget.detail;
    detail2 = widget.detail2;
    pathUrl = widget.pathUrl;
  }

  Widget showImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4, //0.5
      child: Image.network(pathUrl),
    );
  }

  Widget showText(){
    return Text(detail);
  
  }
  Widget showText2(){
    return Text(detail2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail $name'),
      ),
      body: ListView(
        children: <Widget>[showImage(),showText(),showText2()],
      ),
    );
  }
}