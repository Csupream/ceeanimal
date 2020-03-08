import 'package:barcode_scan/barcode_scan.dart';
import 'package:ceeanimal/models/product_model.dart';
import 'package:ceeanimal/utility/my_constant.dart';
import 'package:ceeanimal/utility/normal_dialog.dart';
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
  List<String> details2 = List();
  List<ProductModel> productModels = List();

//Method
  @override
  void initState() {
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

          String detail2 = snapshot.data['Detail2'];
          detail2 = checkNull(detail2);

          String picture = snapshot.data['Image'];
          picture = checkNull(picture);

          String code = snapshot.data['Code'];
          code = checkNull(code);

          names.add(name);
          details.add(detail);
          details2.add(detail2);
          pictures.add(picture);
          codes.add(code);

          ProductModel model = ProductModel.formSnapshot(snapshot.data);
          productModels.add(model);
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
      width: MediaQuery.of(context).size.width * 0.4, //0.5
      height: MediaQuery.of(context).size.width * 0.3, //0.4
      padding: EdgeInsets.all(20.0),
      child: Image.network(pictures[index]),
    );
  }

  Widget showText(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5, //0.5
      //height: MediaQuery.of(context).size.width * 0.2, //0.4
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                names[index],
                style: MyConstant().titleH2,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(details[index]),
              ),
            ],
          ),
          // Row(
          //   children: <Widget>[
          //     Container(
          //       width: MediaQuery.of(context).size.width * 0.5,
          //       child: Text(details2[index]),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget showListView() {
    return ListView.builder(
      itemCount: names.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            routeToDetail(index, context);
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

  void routeToDetail(int index, BuildContext context) {
    MaterialPageRoute route =
        MaterialPageRoute(builder: (BuildContext buildContext) {
      return DetailProduct(
        name: productModels[index].name,
        detail: productModels[index].detail,
        detail2: productModels[index].detail2,
        pathUrl: productModels[index].pathUrl,
      );
    });
    Navigator.of(context).push(route);
  }

  Widget readCodeButton() {
    return IconButton(
      icon: Icon(Icons.monochrome_photos),
      onPressed: () {
        readCodeThread();
      },
    );
  }

  Future<void> readCodeThread() async {
    try {
      String string = await BarcodeScanner.scan();
      print('string = $string');

      bool status = true;
      int index = 0;

      for (var myModel in productModels) {
        if (string.toString() == myModel.code) {
          status = false;
          print('work');
          routeToDetail(index, context);
        }
        index++;
      }

      showStatus(status, string.toString());
    } catch (e) {}
  }

  void showStatus(bool status, String code) {
    if (status) {
      normalDialog(context, 'No Code', 'No Code = $code in myDatabase');
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[readCodeButton()],
        title: Text('List $currentCategory'),
      ),
      body: names.length == 0 ? showProcess() : showListView(),
    );
  }
}
