import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/themes/app_general_trans.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/payment_first_form_screen.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/connection_error%20widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';

import '../../../../../di/dependency_injection.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/toast_widget.dart';
import '../../payment/screens/follow_order_screen.dart';
import '../blocs/bloc.dart';
import '../blocs/states.dart';

class PaymentAuthScreen extends StatefulWidget {
  const PaymentAuthScreen({Key? key}) : super(key: key);

  @override
  State<PaymentAuthScreen> createState() => _PaymentAuthScreenState();
}

class _PaymentAuthScreenState extends State<PaymentAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context).call(),
      body: BlocListener<PaymentAuthBloc, PaymentAuthStates>(
        listener: (context, state) {
          switch (state.paymentAuthResponseStatus) {
            case PaymentAuthResponseStatus.loading:
              {
                debugPrint('loading');
                showDialog(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          Text('please wait ...')
                        ],
                      );
                    });
              }
              break;
            case PaymentAuthResponseStatus.error:
              {
                debugPrint('loading');
                Navigator.pop(context);
                showToastWidget(
                    CustomToastWidget(
                      toastContent: state.message,
                      toastStatus: ToastStatus.error,
                    ),
                    position: ToastPosition.bottom);
              }
              break;
            case PaymentAuthResponseStatus.success:
              {
                debugPrint('success');
                sl<AppPreference>().setUserPaymentToken(
                    userPaymentToken: state.paymentAuthModel!.token!);
                debugPrint(
                    'user token cached successfully ${state.paymentAuthModel!.token}');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FollowOrderScreen()),(route)=>false);
              }
              break;
            default:
              {
                return Navigator.pop(context);
              }
          }
        },
        child: BlocBuilder<PaymentAuthBloc, PaymentAuthStates>(
          builder: (context, state) {
            switch (state.paymentAuthResponseStatus) {
              case PaymentAuthResponseStatus.loading:
                {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              case PaymentAuthResponseStatus.error:
                {
                  return RetryContainer(
                    onRetry: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PaymentFirstFormScreen()),
                          (route) => false);
                    },
                    errorMessage:
                        '${AppGeneralTrans.uploadFilesErrorTxt} ',
                  );
                }
              default:
                {
                  return Container();
                }
            }
          },
        ),
      ),
    );
  }
}
