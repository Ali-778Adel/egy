import 'package:fl_egypt_trust/ui/screens/bottom_navigations/bottom_navigation_handler.dart';
import 'package:fl_egypt_trust/ui/screens/main/redesign_home/pages/new_home_screen_shimmer.dart';
import 'package:fl_egypt_trust/ui/screens/sd_screens/pages/qr_scanner.dart';
import 'package:fl_egypt_trust/ui/screens/main/redesign_home/redesign_bloc/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/redesign_home/redesign_bloc/events.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/connection_error%20widget.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'models/utils/themes/themes_bloc/bloc.dart';
import 'models/utils/themes/themes_bloc/events.dart';
import 'models/utils/themes/themes_bloc/states.dart';

class MainDirectionalWidget extends StatefulWidget {
  const MainDirectionalWidget({Key? key}) : super(key: key);

  @override
  State<MainDirectionalWidget> createState() => _MainDirectionalWidgetState();
}

class _MainDirectionalWidgetState extends State<MainDirectionalWidget> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ThemeBloc>(context).add(GetThemeEvent());
  }
  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 104),
        child: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical:8.sp,horizontal: 16.sp),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4.sp),
                height: 80.sp,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [

                        Spacer(),
                        FittedBox(
                          fit: BoxFit.fill,
                          child: Container(
                            height: 35.sp,
                            width: 94.sp,
                            child: Image.asset(
                              'assets/drawable/titleLogo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
      body: BlocConsumer<ThemeBloc,ThemeStates>(
          builder: (context,stat){
            switch(stat.themeResponseStatus){
              case ThemeResponseStatus.loading:{
                return const ShimmerHomeScreen();
              }
              case ThemeResponseStatus.error:{
                return Center(child: RetryContainer(onRetry: () {
                  BlocProvider.of<ThemeBloc>(context).add(GetThemeEvent());
                }, errorMessage: stat.message??'',));
              }
              case ThemeResponseStatus.success:{
                return Container();
              }
              default:{
                return const ShimmerHomeScreen();
              }
            }
          },
          listener: (context,state){
            if(state.themeResponseStatus==ThemeResponseStatus.success){
              BlocProvider.of<HomeViewBloc>(context).add(GetHomeTranslatorsEvent());
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomeNavigationScreen()), (route) => false);
            }

    },
          ),

    );
  }
}
