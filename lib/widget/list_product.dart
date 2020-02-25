import 'package:barcode_scan/barcode_scan.dart';
import 'package:ceeanimal/widget/detail_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<String> names = List();
  List<String> details = List();
  List<String> pictures = List();
  List<String> codes = List();

//Method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentCategory = widget.category;
    readFirestore();
  }

  Future<void> readFirestore() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference =
        firestore.collection(currentCategory);
    await collectionReference.snapshots().listen((dataSnapshot) {
      List<DocumentSnapshot> documentSnapshots = dataSnapshot.documents;
      for (var snapshot in documentSnapshots) {
        //String name = snapshot.data['Name'];
        //print('name = $name');
        setState(() {
          String name = snapshot.data['Name'];
          name = checkNull(name);

          String detail = snapshot.data['Detail'];
          detail = checkNull(detail);

          String picture = snapshot.data['Image'];
          picture = checkNull(picture);

          String code = snapshot.data['Code'];
          code = checkNull(code);

          names.add(name);
          details.add(detail);
          pictures.add(picture);
          codes.add(code);
        });
      }
    });
  }

  String checkNull(String string) {
    if (string == null) {
      return 'No Data';
    } else {
      return string;
    }
  }

  Widget showProcess() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget showPicture(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.all(20.0),
      child: Image.network(pictures[index]),
    );
  }

  Widget showText(int index) {
    return Column(
      children: <Widget>[
        Text(names[index]),
        Text(details[index]),
      ],
    );
  }

  Widget showListView() {
    return ListView.builder(
      itemCount: names.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (BuildContext buildContext) {
              return DetailProduct(
                name: names[index],
                detail: details[index],
                pathUrl: pictures[index],
              );
            });
            Navigator.of(context).push(route);
          },
          child: Row(
            children: <Widget>[
              showPicture(index),
              showText(index),
            ],
          ),
        );
      },
    );
  }

  Widget readCodeButton() {
    return IconButton(
      icon: Icon(Icons.monochrome_photos),
      onPressed: () {
        readCodeThread();
      },
    );
  }

  Future<void> readCodeThread()async{
    try {

      String string = await BarcodeScanner.scan();
      print('string = $string');
      
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[readCodeButton()],
        title: Text('List $currentCategory'),
      ),
      body: names.length == 0 ? showProcess() : showListView(),
    );
  }
}
