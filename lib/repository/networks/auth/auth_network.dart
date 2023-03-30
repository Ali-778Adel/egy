import 'package:dio/dio.dart';
import 'package:fl_egypt_trust/repository/networks/api_response.dart';
import 'package:fl_egypt_trust/repository/networks/network_constants.dart';
import 'package:retrofit/http.dart';

import '../../../models/entities/public_entities/user_model.dart';

part 'auth_network.g.dart';

@RestApi(baseUrl: NetworkConstants.baseUrl)
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  @FormUrlEncoded()
  @POST(NetworkConstants.methodSystemOptions)
  Future<ApiResponse<dynamic>> systemOptions({
    @Field('Lang') required String lang,
    @Field('IOSAppVer')  String? iosVersion,
    @Field('AndroidAppVer') String? androidVersion,
  });




  @FormUrlEncoded()
  @POST(NetworkConstants.methodLogin)
  Future<ApiResponse<UserData>> login({
    @Field('Lang') required String lang,
    @Field('UserName') required String userName,
    @Field('Password') required String password,
  });


  @FormUrlEncoded()
  @POST(NetworkConstants.methodForgot)
  Future<ApiResponse<dynamic>> forgotPassword({
    @Field('Lang') required String lang,
    @Field('UserName') required String userName,
  });



  @FormUrlEncoded()
  @POST(NetworkConstants.methodForgotConfirm)
  Future<ApiResponse<dynamic>> confirmForgotPassword({
    @Field('Lang') required String lang,
    @Field('UserName') required String userName,
    @Field('ConfirmCode') required String otpCode,
    @Field('NewPassword') required String newPassword,
  });




  @FormUrlEncoded()
  @POST(NetworkConstants.methodUserChangePwd)
  Future<ApiResponse<dynamic>> changePassword({
    @Field('Lang') required String lang,
    @Field('UserName') required String userName,
    @Field('OldPassword') required String oldPassword,
    @Field('NewPassword') required String newPassword,
  });

  @FormUrlEncoded()
  @POST(NetworkConstants.methodCheckToken)
  Future<ApiResponse<dynamic>> checkSession({
    @Field('Lang') required String lang,
  });

  @FormUrlEncoded()
  @POST(NetworkConstants.methodRequestActivateToken)
  Future<ApiResponse<dynamic>> requestActivateToken({
    @Field('Lang') required String lang,
    @Field('MobileNo') required String mobileNo,
  });


  @FormUrlEncoded()
  @POST(NetworkConstants.methodActivateToken)
  Future<ApiResponse<dynamic>> activateToken({
    @Field('Lang') required String lang,
    @Field('MobileNo') required String mobileNo,
    @Field('OtpPwd') required String otpPwd,
    @Field('NewPwd') required String newPwd,
  });
}
