import 'package:factory2homes/repository/repository.dart';

class CategoryService{
  Repository _repository;
  CategoryService(){
    _repository = Repository();
  }
  
  getCategories() async {
    return await _repository.httpGet('categories');
  }
  getTopBannerCategories() async{
    return await _repository.httpGet('get-category-by-top-banner');
  }
  
}