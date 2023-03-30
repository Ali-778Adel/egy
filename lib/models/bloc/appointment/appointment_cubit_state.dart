

import '../../entities/public_entities/branch_available_time.dart';
import '../../entities/public_entities/branch_model.dart';
import '../../entities/public_entities/city_model.dart';
import '../../entities/public_entities/reservation_model.dart';
import '../../entities/public_entities/service_type.dart';

class AppointmentCubitState {
  List<CityData>? allCities;
  List<BranchData>? cityBranches;
  List<ServiceTypeData>? branchServices;
  List<BranchAvailableTimeData>? branchAvailableTimes;

  bool? isCitiesLoading = false,
      isBranchesLoading = false,
      isAvailableTimesLoading = false,
      isSubmittingLoading = false,
      isCancelLoading = false,
      isSearchLoading = false,
      isServicesLoading = false;

  String? availableTimeMessage;

  String? submittingSuccessMessage;
  String? submittingFailMessage;
  String? searchFailMessage;

  ReservationModel? reservationModel;

  AppointmentCubitState(
      {this.allCities,
      this.branchAvailableTimes,
      this.branchServices,
      this.cityBranches,
        this.isAvailableTimesLoading,
        this.isBranchesLoading,
        this.isCitiesLoading,
        this.isServicesLoading,
        this.isSubmittingLoading,
        this.isCancelLoading,
        this.availableTimeMessage,
        this.submittingFailMessage,
        this.submittingSuccessMessage,
        this.searchFailMessage,
        this.isSearchLoading,
        this.reservationModel,
      });

  AppointmentCubitState copyWith(
          {List<CityData>? allCities,
          List<BranchData>? cityBranches,
          List<ServiceTypeData>? branchServices,
          List<BranchAvailableTimeData>? branchAvailableTimes,
          bool? isCitiesLoading,
          bool? isBranchesLoading,
          bool? isAvailableTimesLoading,
          bool? isSubmittingLoading,
          bool? isCancelLoading,
          bool? isSearchLoading,
          String? availableTimeMessage,
          String? submittingFailMessage,
          String? submittingSuccessMessage,
          String? searchFailMessage,
            ReservationModel? reservationModel,
          bool? isServicesLoading}) =>
      AppointmentCubitState(
        allCities: allCities ?? this.allCities,
        cityBranches: cityBranches ?? this.cityBranches,
        branchServices: branchServices ?? this.branchServices,
        branchAvailableTimes: branchAvailableTimes ?? this.branchAvailableTimes,
        isCitiesLoading: isCitiesLoading ?? this.isCitiesLoading,
        isSearchLoading: isSearchLoading ?? this.isSearchLoading,
        isBranchesLoading: isBranchesLoading ?? this.isBranchesLoading,
        isAvailableTimesLoading: isAvailableTimesLoading ?? this.isAvailableTimesLoading,
        isSubmittingLoading: isSubmittingLoading ,
        isCancelLoading: isCancelLoading ,
        isServicesLoading: isServicesLoading ?? this.isServicesLoading,
        availableTimeMessage: availableTimeMessage ?? this.availableTimeMessage,
        submittingSuccessMessage: submittingSuccessMessage ,
        searchFailMessage: searchFailMessage ,
        submittingFailMessage: submittingFailMessage ,
        reservationModel: reservationModel,

      );

  void reset() {
    allCities = null;
    cityBranches = null;
    branchServices = null;
    branchAvailableTimes = null;

    isCitiesLoading = false;
        isBranchesLoading = false;
        isAvailableTimesLoading = false;
        isSubmittingLoading = false;
    isCancelLoading = false;
        isSearchLoading = false;
        isServicesLoading = false;

    availableTimeMessage = null;

    submittingSuccessMessage = null;
    searchFailMessage = null;
    submittingFailMessage = null;

  }
}
