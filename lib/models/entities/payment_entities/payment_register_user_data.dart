import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class PaymentRegistrationUserDataModel {
  final int? serviceId;
  final int? servicesStatus;
  final int? stateId;
  final int? cityId;
  final int? userId;
  final String? address;
  final String? cardId;
  final String? email;
  final String? mobileNumber;
  final String? companyName;
  final int? comorderCount;
  final String? isThereDiscount;
  final String? facebook;
  final String? whats;
  final int? subscriptionId;
  final String? isCount;
  final double? total;
  final String? isCommissioner;
  final String? commissionerName;
  final String? commissionerPhone;
  final String? commisionerCardId;
  final String? issuanceTaxDate;
  final String? taxCardDate;
  final String? discountUpload;
  final bool? liberalProfessions;
  final String? companyFiles;
  final String?taxNumber;
  final String? personalFiles;
  final String? commissionerFiles;
  final String? pdfPath;
  final String? taxCardPath;
  final String? valueAddedCardPath;
  final String? issuanceRequestPath;
  final String? firstContractImagePath;
  final String? secondContractImagePath;
  final String? registerPersonCardPath;
  final String? nationalCardPath;
  final String? singleContractImagePath;
  final String? commissionImagePath;
  final String? commissionerNationalCardImagePath;
  final String? discountNotificationPath;

  PaymentRegistrationUserDataModel({
    this.serviceId,
    this.stateId,
    this.cityId,
    this.companyName,
    this.address,
    this.email,
    this.cardId,
    this.commisionerCardId,
    this.commissionerFiles,
    this.commissionerName,
    this.commissionerPhone,
    this.comorderCount,
    this.companyFiles,
    this.taxNumber,
    this.discountUpload,
    this.facebook,
    this.isCommissioner,
    this.isCount,
    this.issuanceTaxDate,
    this.isThereDiscount,
    this.liberalProfessions,
    this.mobileNumber,
    this.personalFiles,
    this.servicesStatus,
    this.subscriptionId,
    this.taxCardDate,
    this.total,
    this.userId,
    this.whats,
    this.pdfPath,
    this.taxCardPath,
    this.valueAddedCardPath,
    this.issuanceRequestPath,
    this.firstContractImagePath,
    this.secondContractImagePath,
    this.registerPersonCardPath,
    this.nationalCardPath,
    this.singleContractImagePath,
    this.commissionImagePath,
    this.commissionerNationalCardImagePath,
    this.discountNotificationPath
  });

  Future<FormData> formData({String? isCommissioner}) async {
    return FormData.fromMap({
      "services": serviceId,
      "serviceStatus": servicesStatus,
      "states": stateId,
      "cities": cityId,
      "address": address,
      "cardId": cardId,
      "email": email,
      "mobile": mobileNumber,
      "comcompany": companyName,
      "VATEG":taxNumber,
      "comorderCount": comorderCount,
      "isTherediscount": isThereDiscount,
      "facebook": facebook,
      "whats": whats,
      "comSubscriptionId": subscriptionId,
      'comdiscount': discountUpload,
      "total": total,
      "isCommissioner": isCommissioner,
      "commissioner": commissionerName,
      "commissionerMobile": commissionerPhone,
      "commissionerCardId": commisionerCardId,
      "issuanceTaxDate": issuanceTaxDate,
      "taxCardDate": taxCardDate,
      "discountUpload": discountUpload,
      "liberalProfessions": liberalProfessions,
      "companyfiles": serviceId == 1
          ? [
             liberalProfessions?? await MultipartFile.fromFile(pdfPath!,
                  filename: 'companyfiles_0.png'),
              await MultipartFile.fromFile(
                taxCardPath!,
                filename: 'companyfiles_1.png',
              ),
              await MultipartFile.fromFile(
                taxCardPath!,
                filename: 'companyfiles_2.png',
              ),
              await MultipartFile.fromFile(
                taxCardPath!,
                filename: 'companyfiles_3.png',
              ),
              await MultipartFile.fromFile(
                taxCardPath!,
                filename: 'companyfiles_4.png',
              ),
              await MultipartFile.fromFile(
                taxCardPath!,
                filename: 'companyfiles_5.png',
              ),
              MultipartFile.fromFile(
                taxCardPath!,
                filename: 'companyfiles_6.png',
              ),
            isThereDiscount??  await MultipartFile.fromFile(
                discountNotificationPath!,
                filename: 'companyfiles_7.png',
              ),

            ]
          : [],
      "personalfiles": serviceId == 2
          ? [
              await MultipartFile.fromFile(
                issuanceRequestPath!,
                filename: 'personalfiles_0.png',
              ),
              await MultipartFile.fromFile(
                nationalCardPath!,
                filename: 'personalfiles_1.png',
              ),
              await MultipartFile.fromFile(singleContractImagePath!,
                  filename: 'personalfiles_2.png')
            ]
          : [],
      "commissionerfiles": isCommissioner=='True'
          ? [
              await MultipartFile.fromFile(
                commissionImagePath!,
                filename: 'commissionerfiles_0.png',
              ),
              await MultipartFile.fromFile(
                commissionerNationalCardImagePath!,
                filename: 'commissionerfiles_1.png',
              ),
            ]
          : [],
    });
  }

// Map<String,dynamic>toJson(){
//  return {
//    "services":serviceId,
//    "serviceStatus":servicesStatus,
//    "states":stateId,
//    "cities":cityId,
//    "userId":userId,
//    "address":address,
//    "cardId":cardId,
//    "email":email,
//    "mobile":mobileNumber,
//    "comcompany":companyName,
//    "comorderCount":comorderCount,
//    "isTherediscount":isThereDiscount,
//    "facebook":facebook,
//    "whast":whats,
//    "isCount":isCount,
//    "total":total,
//    "isCommissioner":isCommissioner,
//    "commissioner":commissionerName,
//    "commissionerMobile":commissionerPhone,
//    "commissionerCardId":commisionerCardId,
//    "comSubscriptionId":subscriptionId,
//    "issuanceTaxDate":issuanceTaxDate,
//    "taxCardDate":taxCardDate,
//    "discountUpload":discountUpload,
//    "liberalProfessions":liberalProfessions,
//    "companyfiles":comorderCount,
//    "personalfiles":personalFiles,
//    "commissionerfiles":commissionerFiles,
//
//  } ;
// }
}
