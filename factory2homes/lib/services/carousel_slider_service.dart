import 'package:factory2homes/repository/repository.dart';

class CarouselSliderService{
  Repository _repository;
  CarouselSliderService(){
    _repository = Repository();
  }

  getCarouselSlider() async {
    return await _repository.httpGet('carouselslider');
  }

}