import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/themes/app_general_trans.dart';
import 'package:fl_egypt_trust/models/utils/themes/app_icons.dart';
import 'package:fl_egypt_trust/ui/screens/bottom_navigations/bottom_navigation_handler.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/follow_order_bloc/events.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/payment_first_form_screen.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/payment_test.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/payment_third_screen.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/update_files_screen.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/connection_error%20widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../di/dependency_injection.dart';
import '../../../../../models/utils/themes/colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../bloc/follow_order_bloc/bloc.dart';
import '../bloc/follow_order_bloc/states.dart';

class FollowOrderArgs {
  final double? total;
  final bool? isCommissioner;
  final bool? isSignature;
  final bool? isThereDiscount;
  final bool? liberalProfessions;
  final String? userRefNumber;
  final String? merchantRefNumber;
  final String? customerMobile;
  final String? customerMail;

  FollowOrderArgs(
      {this.total,
      this.isCommissioner,
      this.isSignature,
      this.liberalProfessions,
      this.userRefNumber,
      this.customerMobile,
      this.customerMail,
      this.merchantRefNumber,
      this.isThereDiscount});
}

class FollowOrderScreen extends StatefulWidget {
  const FollowOrderScreen({Key? key}) : super(key: key);

  @override
  State<FollowOrderScreen> createState() => _FollowOrderScreenState();
}

class _FollowOrderScreenState extends State<FollowOrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FollowOrderBloc>(context).add(FollowOrderEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            context: context,
            pageTitle: AppGeneralTrans.followOrderTxt,
            onPop: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeNavigationScreen()),
                  (route) => false);
            }).call(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(16.sp),
          child: BlocBuilder<FollowOrderBloc, FollowOrderStates>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CachedNetworkImage(
                    imageUrl: AppIcons.followOrdersImage,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            LinearProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Text(
                    AppGeneralTrans.myOrdersTxt,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Palette.mainBlue,
                        fontSize: 18.sp,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w600),
                  ),
                  if (state.followOrdersResponseStatus ==
                      FollowOrdersResponseStatus.success)
                    SizedBox(
                      // height: 400,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.followOrdersModels!.length,
                          itemBuilder: (context, index) {
                            return _buildSection(
                              label: 'label',
                              state: state,
                              index: index,
                            );
                          }),
                    ),
                  if (state.followOrdersResponseStatus ==
                      FollowOrdersResponseStatus.loading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (state.followOrdersResponseStatus ==
                      FollowOrdersResponseStatus.error)
                    Center(
                      child: RetryContainer(
                        onRetry: () {
                          BlocProvider.of<FollowOrderBloc>(context)
                              .add(FollowOrderEvent());
                        },
                        errorMessage: AppGeneralTrans.tryAgainTxt,
                      ),
                    )
                ],
              );
            },
          ),
        ));
  }

  _buildSection(
      {required String label,
      required FollowOrderStates state,
      required int index,
      required}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.sp),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.sp)),
        ),
        color: Palette.mainGreen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// service type
                    Row(
                      children: [
                        Text(
                          '${AppGeneralTrans.serviceTypeTxt} :',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Palette.white),
                        ),
                        Expanded(
                          child: Text(
                            state.followOrdersModels![index].serviceId == 1
                                ? '${AppGeneralTrans.sealTxt} '
                                : '${AppGeneralTrans.signatureTxt} ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Palette.white),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.sp),
                      child: Divider(
                        color: Palette.white,
                      ),
                    ),

                    /// service status
                    Row(
                      children: [
                        Text(
                          '${AppGeneralTrans.serviceStatusTxt} :',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Palette.white),
                        ),
                        Expanded(
                          child: Text(
                            state.followOrdersModels![index].serviceStatusId ==
                                    1
                                ? '${AppGeneralTrans.newTxt}'
                                : '${AppGeneralTrans.reNewTxt}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Palette.white),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.sp),
                      child: Divider(
                        color: Palette.white,
                      ),
                    ),

                    /// national id
                     Wrap(
                       // crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.spaceBetween,
                       runAlignment: WrapAlignment.spaceBetween,
                       clipBehavior: Clip.antiAlias,
                       children: [
                         Text(
                           '${AppGeneralTrans.nationalIdTitleTxt}',
                           style: Theme.of(context)
                               .textTheme
                               .bodyLarge
                               ?.copyWith(
                                   fontWeight: FontWeight.bold,
                                   color: Palette.white),
                         ),
                         Text(
                           '${state.followOrdersModels![index].cardId}',
                           style: Theme.of(context)
                               .textTheme
                               .bodyLarge
                               ?.copyWith(
                                   fontWeight: FontWeight.bold,
                                   color: Palette.white),
                         ),
                       ],
                     ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.sp),
                      child: Divider(
                        color: Palette.white,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${AppGeneralTrans.oredreNumberTxt}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Palette.white),
                        ),
                        Text(
                          '${state.followOrdersModels![index].userRefNumber}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Palette.white),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.sp),
                      child: Divider(
                        color: Palette.white,
                      ),
                    ),

                    /// ref number
                    // if (state.followOrdersModels![index].status == 1 ||
                    //     state.followOrdersModels![index].status == 4)
                    Row(
                      children: [
                        Text(
                          AppGeneralTrans.refNumTxt,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Palette.white),
                        ),
                        Expanded(
                          child: FutureBuilder<String>(
                              future:
                                  getOrderRefNumber(state: state, index: index),
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data ??
                                      '${AppGeneralTrans.notPaidYetTxt} ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Palette.white),
                                );
                              }),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.sp),
                      child: Divider(
                        color: Palette.white,
                      ),
                    ),

                    ///total cost
                    Row(
                      children: [
                        Text(
                          AppGeneralTrans.totalTxt,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Palette.white),
                        ),
                        Text(
                          '${state.followOrdersModels![index].total}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Palette.white),
                        ),
                      ],
                    )
                  ],
                )),
            Column(
              children: [
                _buildAction(
                    title: '${state.followOrdersModels![index].notes}',
                    hint: AppGeneralTrans.orderStatusTxt),
                if (state.followOrdersModels![index].status == 2)
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: _buildButton(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateFilesScreen(),
                                    settings: RouteSettings(
                                        arguments: FollowOrderArgs(
                                            isCommissioner: state
                                                .followOrdersModels![index]
                                                .isCommissioner,
                                            isThereDiscount: state
                                                .followOrdersModels![index]
                                                .isDiscount,
                                            liberalProfessions: state
                                                .followOrdersModels![index]
                                                .isLiberalProfessions,
                                            isSignature:
                                                state.followOrdersModels![index]
                                                            .serviceId ==
                                                        1
                                                    ? false
                                                    : true))));
                          },
                          childTxt: AppGeneralTrans.editFilesTxt)),
                if (state.followOrdersModels![index].status == 1 ||
                    state.followOrdersModels![index].status == 4)
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: _buildButton(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PaymentSummaryScreenTest(),
                                    settings: RouteSettings(
                                        arguments: FollowOrderArgs(
                                      total: state
                                          .followOrdersModels![index].total!
                                          .toDouble(),
                                      userRefNumber: state
                                          .followOrdersModels![index]
                                          .userRefNumber,
                                      customerMobile: state
                                          .followOrdersModels![index]
                                          .customerMobile,
                                      customerMail: state
                                          .followOrdersModels![index]
                                          .customerMail,
                                      merchantRefNumber: state
                                          .followOrdersModels![index]
                                          .merchantRefNum,
                                    ))));
                          },
                          childTxt: AppGeneralTrans.completePaymentTxt)),
                if (state.followOrdersModels![index].status == 3)
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: _buildButton(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PaymentFirstFormScreen()));
                          },
                          childTxt: AppGeneralTrans.buySealTxt)),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildAction({required String title, required String hint}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 8.sp),
      child: Material(
        color: Colors.white,
        child: Container(
          constraints: const BoxConstraints(minHeight: 60),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: Text(
                  "$hint  ",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Palette.mainBlue, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Text(
                  "$title ",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Palette.mainGreen, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({required Function() onTap, required String childTxt}) {
    return ElevatedButton(
        onPressed: onTap,
        child: Text(
          childTxt,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Palette.mainGreen),
        ),
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(Size(40.sp, 30.sp)),
            backgroundColor: MaterialStateProperty.all<Color>(Palette.white),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: Palette.white)))));
  }

  Future<String> getOrderRefNumber({
    required FollowOrderStates state,
    required int index,
  }) async {
    final String refNumber = await sl<AppPreference>().getPaymentOrderRefNumber(
        merchantNumber: state.followOrdersModels![index].merchantRefNum!);
    if (refNumber.isNotEmpty) {
      return refNumber;
    } else {
      return '';
    }
  }
}
