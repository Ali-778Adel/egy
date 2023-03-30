

import '../../../entities/public_entities/certification_pin_model.dart';

class CertificationActionsCubitState {


  CertificationPinModel? certificationPinModel;
  bool? isActionLoading;
  bool? isRevokeActionLoading;
  String? actionSuccessMessage , actionFailMessage;

  CertificationActionsCubitState({
    this.certificationPinModel,
    this.isActionLoading,
    this.isRevokeActionLoading,
    this.actionSuccessMessage,
    this.actionFailMessage
  });

  CertificationActionsCubitState copyWith({

  CertificationPinModel? certificationPinModel,
  bool? isActionLoading,
  bool? isRevokeActionLoading,
  String? actionSuccessMessage ,String? actionFailMessage
          }) =>
      CertificationActionsCubitState(
        certificationPinModel: certificationPinModel,
        isActionLoading: isActionLoading,
        isRevokeActionLoading: isRevokeActionLoading,
        actionSuccessMessage: actionSuccessMessage,
        actionFailMessage: actionFailMessage,
      );


}
