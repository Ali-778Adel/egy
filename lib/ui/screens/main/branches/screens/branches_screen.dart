import 'dart:async';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_cities_model.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_second_form_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../../models/entities/public_entities/city_model.dart';
import '../../../../../models/entities/payment_entities/paymnet_states_model.dart';
import '../../../../../models/utils/themes/colors.dart';
import '../../../widgets/branch_map.dart';
import '../../../widgets/cities_drop_down.dart';
import '../../../widgets/connection_error widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/states_drop_down.dart';
import '../../payment/bloc/payment_second_form_bloc/events.dart';
import '../../payment/bloc/payment_second_form_bloc/states.dart';
import '../blocs/bloc.dart';
import '../blocs/events.dart';
import '../blocs/states.dart';


class BranchesSectionData{
  final PaymentStatesModel? selectedStateObject;
  final PaymentCitiesModel? selectedCityObject;
  final String?cityHint;

  BranchesSectionData({
  this.selectedStateObject,
  this.selectedCityObject,
    this.cityHint,
});
}

BranchesSectionData branchesSectionData=BranchesSectionData();

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({Key? key}) : super(key: key);

  @override
  _StateScreenBranches createState() => _StateScreenBranches();
}

class _StateScreenBranches extends State<BranchesScreen> {
  PaymentStatesModel? selectedStateObject;
  PaymentCitiesModel? selectedCityObject;

  String cityHint = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedStateObject=branchesSectionData.selectedStateObject;
    selectedCityObject=branchesSectionData.selectedCityObject;
    cityHint=branchesSectionData.cityHint??'';
    if(selectedStateObject==null){

      BlocProvider.of<PaymentSecondFormStatesBloc>(context)
          .add(GetSecondFormStatesDataEvent());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    branchesSectionData=BranchesSectionData(
      selectedCityObject: selectedCityObject,
      selectedStateObject: selectedStateObject,
      cityHint: cityHint

    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(context: context).call(),
      body:
          BlocBuilder<BranchesBloc, BranchesStates>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              /// states field
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    BlocBuilder<PaymentSecondFormStatesBloc,
                        GetSecondFormStatesDataState>(builder: (context, stat) {
                      if (stat.secondFormResponseStatus ==
                          SecondFormResponseStatus.success) {
                        return PaymentStatesDropDown(
                          selectedStateObject: selectedStateObject,
                          // selectedCitiesModel: selectedCityObject,
                          fieldHint: stat.publicTranslatorEntity!
                              .where(
                                  (element) => element.key == 'governorateTxt')
                              .first
                              .val!,
                          onChanged: (val) {
                            setState(() {
                              branchesSectionData=BranchesSectionData(selectedStateObject: val);
                              selectedStateObject = val;
                              selectedCityObject != null
                                  ? selectedCityObject = null
                                  : null;
                              cityHint = stat.publicTranslatorEntity!
                                  .where((element) => element.key == 'cityTxt')
                                  .first
                                  .val!;
                              BlocProvider.of<PaymentSecondFormCitiesBloc>(
                                      context)
                                  .add(GetSecondFormCitiesDataEvent(
                                      stateId: selectedStateObject!.stateId!));
                            });
                          },
                        );
                      } else if (stat.secondFormResponseStatus ==
                          SecondFormResponseStatus.error) {
                        return RetryContainer(
                          onRetry: () {},
                          errorMessage: stat.message!,
                        );
                      } else {
                        return const LinearProgressIndicator(
                          minHeight: 2,
                        );
                      }
                    }),
                    if (state is GetBranchesStates &&
                        state.branchesResponseStatus ==
                            BranchesResponseStatus.loading)
                      const LinearProgressIndicator(
                        minHeight: 2,
                      ),
                  ],
                ),
              ),

              /// cities field
              if (selectedStateObject != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      BlocBuilder<PaymentSecondFormCitiesBloc,
                              GetSecondFormCitiesDataState>(
                          builder: (context, stat) {
                        if (stat.secondFormResponseStatus ==
                            SecondFormResponseStatus.success) {
                          return PaymentCitiesDropDown(
                            selectedCityObject: selectedCityObject,
                            // selectedCitiesModel: selectedCityObject,
                            fieldHint: cityHint,
                            onChanged: (val) {
                              setState(() {
                                selectedCityObject = val;
                                 branchesSectionData=BranchesSectionData(selectedCityObject: val);
                                BlocProvider.of<BranchesBloc>(context).add(
                                    GetBranchesEvent(
                                        stateId:
                                            '${selectedStateObject!.stateId}',
                                        cityId:
                                            '${selectedCityObject!.cityId}'));
                              });
                            },
                          );
                        } else if (stat.secondFormResponseStatus ==
                            SecondFormResponseStatus.error) {
                          return RetryContainer(
                            onRetry: () {},
                            errorMessage: stat.message!,
                          );
                        } else {
                          return const LinearProgressIndicator(
                            minHeight: 2,
                          );
                        }
                      }),
                      if (state is GetBranchesStates &&
                          state.branchesResponseStatus ==
                              BranchesResponseStatus.loading)
                        const LinearProgressIndicator(
                          minHeight: 2,
                        ),
                    ],
                  ),
                ),
             if(selectedCityObject!=null)
              Expanded(
                  child: ListView.builder(
                    scrollDirection:Axis.vertical,
                shrinkWrap: false,
                itemCount: state is GetBranchesStates &&
                        state.branchesResponseStatus ==
                            BranchesResponseStatus.success
                    ? state.branchesModels!.isNotEmpty?
                    state.branchesModels!.length:1
                    : 1,
                itemBuilder: (_, index) {
                  if (state is GetBranchesStates &&
                      state.branchesResponseStatus ==
                          BranchesResponseStatus.loading) {
                    return const LinearProgressIndicator(
                      minHeight: 2,
                    );
                  }
                  if (state is GetBranchesStates &&
                      state.branchesResponseStatus ==
                          BranchesResponseStatus.error) {
                    return RetryContainer(
                        onRetry: () {
                          BlocProvider.of<BranchesBloc>(context).add(
                              GetBranchesEvent(
                                  stateId:
                                  '${selectedStateObject!.stateId}',
                                  cityId:
                                  '${selectedCityObject!.cityId}'));                        }, errorMessage: state.message!);
                  }
                  if (state is GetBranchesStates &&
                      state.branchesResponseStatus ==
                          BranchesResponseStatus.success &&
                      state.branchesModels!.isNotEmpty) {
                     print('falseweeeeeeeeeeeeeeeeeeeeee');
                      return BranchMapWidget(
                          branchData: state.branchesModels![index],
                          lat: double.parse(
                              state.branchesModels![index].latitude!),
                          lng: double.parse(
                              state.branchesModels![index].longitude!.substring(
                                  0,
                                  state.branchesModels![index].longitude!
                                          .contains(',')
                                      ? state.branchesModels![index].longitude!
                                          .indexOf(',')
                                      : state.branchesModels![index].longitude!
                                          .length)));

                  }
                  if(state is GetBranchesStates &&
                      state.branchesResponseStatus ==
                          BranchesResponseStatus.success
                      &&
                      state.branchesModels!.isEmpty) {
                    return  Container(
                      height: 200,
                      child: Center(
                        child: RichText(


                          text: TextSpan(
                          text:'لا يوجد فروع لدينا فى هذة المدينة من فضلك اختر اقرب مدينة اليك.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Palette.colorRed),
                          ),
                        ),
                      ),
                    );
                  }

                  return Container();
                },
              )),
            ],
          ),
        );
      }),
    );
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Widget _buildMap() {
    CameraPosition _kGooglePlex = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

    CameraPosition _kLake = const CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(37.43296265331129, -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }

}
