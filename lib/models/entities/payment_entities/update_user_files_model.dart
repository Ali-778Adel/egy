import 'package:dio/dio.dart';

class UpdateUserFilesModel {
  final String? companyFiles;
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
  final String? userRefNum;
  final String?discountNotificationPath;

  UpdateUserFilesModel(
      {this.companyFiles,
      this.personalFiles,
      this.commissionerFiles,
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
      this.userRefNum,
        this.discountNotificationPath
      });

  Future<FormData> formData(
      {bool? isCommissioner,bool?liberalProfessions,bool? isThereDiscount, required int serviceId}) async {
    return FormData.fromMap({
      "userRefNum": userRefNum,
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
        isCommissioner?? await MultipartFile.fromFile(
                discountNotificationPath!,
                filename: 'companyfiles_7.png',
              )
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
      "commissionerfiles": isCommissioner!
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
}
