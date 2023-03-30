//
//
// import 'package:fl_egypt_trust/models/bloc/branches/branches_cubit.dart';
// import 'package:fl_egypt_trust/models/bloc/branches/branches_cubit_state.dart';
// import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
// import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
// import 'package:fl_egypt_trust/ui/screens/main/profile/subs/branches/row_branch.dart';
// import 'package:fl_egypt_trust/ui/screens/widgets/row_dropdown.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../../models/entities/public_entities/city_model.dart';
//
// class ScreenBranches extends StatefulWidget{
//   const ScreenBranches({Key? key}) : super(key: key);
//
//   @override
//   _StateScreenBranches createState() =>_StateScreenBranches();
//
// }
//
// class _StateScreenBranches extends State<ScreenBranches>{
//
//
//   CityData? _selectedCityData;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _getCityBranches(null);
//   }
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//           systemOverlayStyle: SystemUiOverlayStyle.dark,
//         title: Text(appLocalization.ourBranches),
//       ),
//       body: BlocBuilder<BranchesCubit, BranchesCubitState>(
//         builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 20),
//                   child: Stack(
//                     alignment: Alignment.bottomCenter,
//                     children: [
//                       DropdownButtonFormField<CityData>(
//                         decoration: InputDecoration(
//                           labelText: appLocalization.selectCity,
//                           fillColor: UiConstants.colorTextFieldFill,
//                           filled: true,
//                           enabledBorder: const UnderlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 2,
//                                 color: UiConstants
//                                     .colorTextFieldEnabledUnderline),
//                           ),
//                         ),
//                         value: _selectedCityData ?? state.allCities?.first,
//                         items: state.allCities
//                             ?.map((e) => DropdownMenuItem<CityData>(
//                           child: RowDropdown(
//                             label: e.cityName ?? '',
//                           ),
//                           value: e,
//                         ))
//                             .toList(),
//                         onChanged: (CityData? value) {
//                           setState(() {
//
//                             _selectedCityData = value;
//                             _getCityBranches(value?.cityID == null
//                                 ? null
//                                 : int.parse(value?.cityID ?? '-1'));
//                           });
//                         },
//                       ),
//                       if (state.isCitiesLoading == true)
//                         const LinearProgressIndicator(
//                           minHeight: 2,
//                         ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: state.cityBranches?.length,
//                     itemBuilder : (_ , index){
//
//                         var branch = state.cityBranches?.elementAt(index);
//                         if(branch == null) return Container();
//                       return RowBranch(branchData: branch);
//                     },
//                     )
//                 )
//               ],
//             ),
//           );
//         }
//       ),
//     );
//   }
//
//   _getCityBranches(int? cityId) {
//
//     context.read<BranchesCubit>().getBranchesList(cityId);
//   }
// }