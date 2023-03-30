
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';

import '../../entities/public_entities/branch_model.dart';
import '../../entities/public_entities/city_model.dart';

class BranchesCubitState {
  List<CityData>? allCities;
  List<BranchData>? cityBranches;

  bool? isCitiesLoading = false,
      isBranchesLoading = false;


  BranchesCubitState(
      {this.allCities,
      this.cityBranches,
        this.isCitiesLoading,
      });

  BranchesCubitState copyWith(
          {List<CityData>? allCities,
          List<BranchData>? cityBranches,
          bool? isCitiesLoading,
          }){
    allCities?.insert(0, CityData(cityName: appLocalization.allCities));
    return BranchesCubitState(
        allCities: this.allCities ??  allCities,
    cityBranches: cityBranches ?? this.cityBranches,
    isCitiesLoading: isCitiesLoading ?? this.isCitiesLoading,
    );
  }

}
