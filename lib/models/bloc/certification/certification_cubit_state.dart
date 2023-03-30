
import 'package:fl_egypt_trust/models/entities/public_entities/order_model.dart';

import '../../entities/public_entities/certification_model.dart';
import '../../entities/public_entities/certification_pin_model.dart';
import '../../entities/public_entities/certification_type_model.dart';

class CertificationCubitState {
  List<CertificationTypeModel>? certificationsTypes;

  bool? isSubmittingLoading = false,
      isServicesLoading = false,
      isSearchLoading = false,
      isCertificationActionLoading = false,
      isUserCertificationsLoading = false;
  CertificationPinModel? certificationPinModel;

  List<CertificationData>? userCertifications;

  String? submittingSuccessMessage,
      submittingFailMessage,
      userCertificationsErrorMessage;
  String? searchFailMessage;

  OrderModel? orderModel;

  CertificationCubitState(
      {this.certificationsTypes,
      this.isServicesLoading,
      this.isSubmittingLoading,
      this.submittingSuccessMessage,
      this.submittingFailMessage,
      this.isUserCertificationsLoading,
      this.userCertifications,
      this.isSearchLoading,
      this.searchFailMessage,
      this.userCertificationsErrorMessage,
      this.orderModel,
      this.certificationPinModel,
      this.isCertificationActionLoading});

  CertificationCubitState copyWith(
          {List<CertificationTypeModel>? certificationsTypes,
          List<CertificationData>? userCertifications,
          bool? isSubmittingLoading,
          bool? isUserCertificationsLoading,
          bool? isSearchLoading,
          String? userCertificationsErrorMessage,
          String? submittingFailMessage,
          String? searchFailMessage,
          String? submittingSuccessMessage,
          bool? isServicesLoading,
          OrderModel? orderModel,
          CertificationPinModel? certificationPinModel,
          bool? isCertificationActionLoading}) =>
      CertificationCubitState(
        submittingSuccessMessage: submittingSuccessMessage,
        submittingFailMessage: submittingFailMessage,
        certificationsTypes: certificationsTypes ?? this.certificationsTypes,
        isSubmittingLoading: isSubmittingLoading,
        isServicesLoading: isServicesLoading ?? this.isServicesLoading,
        isUserCertificationsLoading:
            isUserCertificationsLoading ?? this.isUserCertificationsLoading,
        userCertifications: userCertifications,
        userCertificationsErrorMessage: userCertificationsErrorMessage,
        searchFailMessage: searchFailMessage,
        isSearchLoading: isSearchLoading,
        orderModel: orderModel,
        certificationPinModel: certificationPinModel,
        isCertificationActionLoading: isCertificationActionLoading,
      );

  CertificationCubitState copyPinWith({
    CertificationPinModel? certificationPinModel,
  }) =>
      CertificationCubitState(
        certificationPinModel: certificationPinModel,
      );

  void reset() {
    certificationsTypes = null;
    isSubmittingLoading = false;
    isServicesLoading = false;
    isSearchLoading = false;
    isUserCertificationsLoading = false;
    userCertifications = null;
    submittingSuccessMessage = null;
    submittingFailMessage = null;
    userCertificationsErrorMessage = null;
    searchFailMessage = null;
  }
}
