// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      nationalID: json['NationalID'] as String?,
      mobileNo: json['MobileNo'] as String?,
      userId: json['UserId'] as String?,
      email: json['Email'] as String?,
      accessToken: json['AccessToken'] as String?,
      hasCertificates: json['HasCertificates'] as bool?,
      picUrl: json['PicUrl'] as String?,
      userFullName: json['UserFullName'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'UserId': instance.userId,
      'AccessToken': instance.accessToken,
      'UserFullName': instance.userFullName,
      'Email': instance.email,
      'PicUrl': instance.picUrl,
      'HasCertificates': instance.hasCertificates,
      'NationalID': instance.nationalID,
      'MobileNo': instance.mobileNo,
    };
