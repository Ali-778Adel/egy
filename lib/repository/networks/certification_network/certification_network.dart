import 'package:dio/dio.dart';

import 'package:fl_egypt_trust/repository/networks/api_response.dart';
import 'package:fl_egypt_trust/repository/networks/network_constants.dart';
import 'package:retrofit/http.dart';

import '../../../models/entities/public_entities/certification_model.dart';
import '../../../models/entities/public_entities/certification_pin_model.dart';
import '../../../models/entities/public_entities/certification_type_model.dart';
import '../../../models/entities/public_entities/create_certification_model.dart';
import '../../../models/entities/public_entities/order_model.dart';

part 'certification_network.g.dart';

@RestApi(baseUrl: NetworkConstants.baseUrl)
abstract class CertificationClient {
  factory CertificationClient(Dio dio, {String baseUrl}) = _CertificationClient;

  @FormUrlEncoded()
  @POST(NetworkConstants.methodListCertificationsType)
  Future<ApiResponse<List<CertificationTypeModel>>> getCertificationTypes({ @Field('Lang') required String lang});



  @POST(NetworkConstants.methodReserveOrder)
  Future<ApiResponse<int>> reserveOrder({@Body() required CreateCertificationModel body});

  @FormUrlEncoded()
  @POST(NetworkConstants.methodUserCertifications)
  Future<ApiResponse<List<CertificationData>>> getActiveCertifications({@Field('Lang') required String lang});

  @FormUrlEncoded()
  @POST(NetworkConstants.methodInquiryOrder)
  Future<ApiResponse<OrderModel>> inquiryOrder({
    @Field('Lang') required String lang,
    @Field('NatID') required String natId,
  });


  @FormUrlEncoded()
  @POST(NetworkConstants.methodSendCertificationOtpPin)
  Future<ApiResponse<CertificationPinModel>> sendCertificationOtp({
    @Field('Lang') required String lang,
    @Field('MyCertSerial') required String certificationSerial,
    @Field('Otp')  String otp = '\$ecure0Tp',
  });



  @FormUrlEncoded()
  @POST(NetworkConstants.methodSendCertificationOtpRevoke)
  Future<ApiResponse<dynamic>> sendRevokeCertificationOtp({
    @Field('Lang') required String lang,
    @Field('MyCertSerial') required String certificationSerial,
  });


  @FormUrlEncoded()
  @POST(NetworkConstants.methodRevokeCertification)
  Future<ApiResponse<dynamic>> revokeCertification({
    @Field('Lang') required String lang,
    @Field('MyCertSerial') required String certificationSerial,
    @Field('RevokePassword') required String otp,
  });

}
