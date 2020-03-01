class ProductModel {

  String name, detail, pathUrl, code;

  ProductModel(this.name, this.detail, this.pathUrl, this.code);

  ProductModel.formSnapshot(Map<String, dynamic> map){
    name = map['Name'];
    detail = map['Detail'];
    pathUrl = map['Image'];
    code = map['Code'];
  }

} 