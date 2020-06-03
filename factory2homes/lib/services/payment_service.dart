import 'package:factory2homes/models/payment.dart';
import 'package:factory2homes/repository/repository.dart';

class PaymentService {
  Repository _repository;

  PaymentService(){
    _repository = Repository();
  }

  makePayment(Payment payment) async {
    return await _repository.httpPost('make-payment', payment.toJson());
  }
}