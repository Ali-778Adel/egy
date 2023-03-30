


import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit_state.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/main/home/subs/appointments/screen_book_appointment.dart';
import 'package:fl_egypt_trust/ui/screens/main/home/subs/appointments/screen_reservation_inquiry.dart';
import 'package:fl_egypt_trust/ui/screens/main/home/subs/certifications/screen_certification.dart';
import 'package:fl_egypt_trust/ui/screens/main/home/subs/certifications/screen_order_inquiry.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/active_token_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScreenHome extends StatefulWidget{
  const ScreenHome({Key? key}) : super(key: key);

  @override
  _StateScreenHome createState() => _StateScreenHome();

}

class _StateScreenHome extends State<ScreenHome>{




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AuthCubit,AuthCubitState>(
        builder: (context, state) {
        return Scaffold(
            body: SafeArea(
              child: Stack(
                fit: StackFit.expand,
                children: [

                  Transform.translate(
                    offset: const Offset(100, -50),
                    child: Transform.scale(
                      scale: 1.5,
                      child: SvgPicture.asset(

                        'assets/drawable/ic_background.svg',

                      ),
                    ),
                  ),

                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: state.userData != null ? 30 : 0),
                            child: const ActivateTokenView(),
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [

                              Flexible(
                                flex: 1,
                                  child: Column(
                                children: [
                                  _HomeActionView(
                                      onTap: (){

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const ScreenBookAppointment()),
                                        );
                                      },
                                      height: 300,
                                      label: appLocalization.bookAppointment,
                                      icon: SvgPicture.asset('assets/drawable/ic_create_booking.svg'),
                                      backgroundColor: UiConstants.colorRed,
                                      labelColor: Colors.white
                                  ),

                                  const SizedBox(height: 20,),
                                  _HomeActionView(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const ScreenOrderInquiry()),
                                        );
                                      },
                                      height: 200,
                                      label: appLocalization.orderInquiry,
                                      icon: SvgPicture.asset('assets/drawable/ic_order_inquiry.svg'),
                                      backgroundColor: UiConstants.colorYellow,
                                      labelColor: UiConstants.colorTitle
                                  ),
                                ],
                              ),
                              ),
                              const SizedBox(width: 20,),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  children: [
                                    _HomeActionView(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const ScreenReservationInquiry()),
                                          );
                                        },
                                        height: 200,
                                        label: appLocalization.reservationInquiry,
                                        icon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset('assets/drawable/ic_reservation_inquiry.svg'),
                                        ),
                                        backgroundColor: UiConstants.colorOrange,
                                        labelColor: UiConstants.colorTitle
                                    ),

                                    const SizedBox(height: 20,),
                                    _HomeActionView(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ScreenCertification()),
                                          );
                                        },
                                        height: 300,
                                        label: appLocalization.createCertification,
                                        icon: SvgPicture.asset('assets/drawable/Ic_create_certification.svg'),
                                        backgroundColor: UiConstants.colorBabyBlue,
                                        labelColor: Colors.white
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            )
        );
      }
    );
  }




}




class _HomeActionView extends StatelessWidget{
  final VoidCallback onTap;
  final String label;
  final Widget icon;
  final Color backgroundColor;
  final Color labelColor;
  final double height;

  const _HomeActionView({required this.height ,required this.onTap , required this.label , required this.icon , required this.backgroundColor , required this.labelColor});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SizedBox(
      width: double.infinity,
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Center(child: icon)),
                    Text(
                      label,
                      style:  Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: UiConstants.colorTitle
                      ),

                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}