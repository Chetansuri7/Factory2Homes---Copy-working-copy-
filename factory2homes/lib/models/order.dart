import 'package:factory2homes/models/product.dart';

class Order {
  int id;
  int quantity;
  double amount;
  int productId;
  Product product = Product();
}