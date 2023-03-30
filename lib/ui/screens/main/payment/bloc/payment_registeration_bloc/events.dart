import 'package:dio/dio.dart';

abstract class PaymentRegistrationEvents{}

class PostUserDataEvent extends PaymentRegistrationEvents{
  final FormData?requestBody;
  PostUserDataEvent({this.requestBody});
}

class GetFourthFormTransDataEvent extends PaymentRegistrationEvents{}