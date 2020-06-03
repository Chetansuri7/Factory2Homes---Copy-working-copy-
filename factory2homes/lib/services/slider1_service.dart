import 'package:factory2homes/repository/repository.dart';

class Slider1Service{
  Repository _repository;
  Slider1Service(){
    _repository = Repository();
  }
  
  getSlider1() async {
    return await _repository.httpGet('sliders1');
  }

}