class ProductModel {

  String name, detail, pathUrl, code, detail2;

  ProductModel(this.name, this.detail, this.pathUrl, this.code, this.detail2);

  ProductModel.formSnapshot(Map<String, dynamic> map){
    name = map['Name'];
    detail = map['Detail'];
    detail2 = map['Detail2'];
    pathUrl = map['Image'];
    code = map['Code'];
  }

} 