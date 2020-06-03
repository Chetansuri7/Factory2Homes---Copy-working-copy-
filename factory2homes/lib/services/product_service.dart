import 'package:factory2homes/repository/repository.dart';

class ProductService {
  Repository _repository;

  ProductService() {
    _repository = Repository();
  }

  getnewArrivalProducts() async {
    return await _repository.httpGet('get-all-new-arrival-products');
  }

  getProductsByCategory(int categoryId) async {
    return await _repository.httpGetById(
        "get-products-by-category", categoryId);
  }

  getProductsBySlider(int sliderId) async {
    return await _repository.httpGetBySliderId(
        "get-products-by-carousel-Slider-id", sliderId);
  }
}