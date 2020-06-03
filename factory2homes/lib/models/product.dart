class Product {
  int productId;

  String productName;
  int productListPrice;
  int productSalePrice;
  int productDiscount;
  int productTax;
  String productPhoto;
  String productDescription;
  String productWarranty;

   int quantity;

  toMap() {
    var map = Map<String, dynamic>();
    map['productId'] = productId.toString();

    map['productName'] = productName.toString();
    map['productListPrice'] = productListPrice.toString();
    map['productSalePrice'] = productSalePrice.toString();
    map['productDiscount'] = productDiscount.toString();
    map['productTax'] = productTax;
    map['productPhoto'] = productPhoto;
    map['productDescription'] = productDescription;
    map['productWarranty'] = productWarranty;


    map['productQuantity'] = quantity;
    return map;
  }

  toJson() {
    return {
      'productId': productId.toString(),

      'productName': productName.toString(),
      'productListPrice': productListPrice,
      'productSalePrice': productSalePrice.toString(),
      'productSalePrice': productSalePrice.toString(),
      'productDiscount': productDiscount.toString(),
      'productTax': productTax,
      'productPhoto': productPhoto,
      'productDescription': productDescription,
      'productWarranty': productWarranty,


      'productQuantity' : quantity.toString(),
    };
  }
}
