import 'package:factory2homes/models/shipping.dart';
import 'package:factory2homes/repository/repository.dart';

class ShippingService {
  Repository _repository;

  ShippingService(){
    _repository = Repository();
  }

  addShipping(Shipping shipping) async {
    return await _repository.httpPost('shipping', shipping.toJson());
  }
}