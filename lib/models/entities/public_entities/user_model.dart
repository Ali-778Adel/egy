import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserData {


  @JsonKey(name: 'UserId')
  String? userId;

  @JsonKey(name: 'AccessToken')
  String? accessToken;

  @JsonKey(name: 'UserFullName')
  String? userFullName;

  @JsonKey(name: 'Email')
  String? email;

  @JsonKey(name: 'PicUrl')
  String? picUrl;

  @JsonKey(name: 'HasCertificates')
  bool? hasCertificates;

  @JsonKey(name: 'NationalID')
  String? nationalID;

  @JsonKey(name: 'MobileNo')
  String? mobileNo;



  UserData({
      this.nationalID,
    this.mobileNo,
    this.userId,
    this.email,
    this.accessToken,
    this.hasCertificates,
    this.picUrl,
    this.userFullName,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

