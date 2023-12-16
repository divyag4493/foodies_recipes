class AddNewItemModel {
  int? id;
  String? itemName;
  String? itemMeal;
  String? itemPrice;
  String? itemDesc;
  String? itemLink;
  String? itemImage;

  AddNewItemModel(
      {this.itemName,
      this.itemMeal,
      this.itemPrice,
      this.itemDesc,
      this.itemLink,
      this.itemImage});

  factory AddNewItemModel.fromJson(Map<String, dynamic> json) {
    return AddNewItemModel(
      itemName: json['itemName'],
      itemMeal: json['itemMeal'],
      itemPrice: json['itemPrice'],
      itemDesc: json['itemDesc'],
      itemLink: json['itemLink'],
      itemImage: json['itemImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'itemMeal': itemMeal,
      'itemPrice': itemPrice,
      'itemDesc': itemDesc,
      'itemLink': itemLink,
      'itemImage':itemImage
    };
  }
}
