import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:fl_egypt_trust/models/bloc/settings_bloc/cubit_seetings_bloc.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/settings/settings_model.dart';
import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:fl_egypt_trust/ui/screens/main/active_certifications/screen_active_certifications.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/main/profile/screen_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main/redesign_home/pages/new_home_screen.dart';

class HomeNavigationScreen extends StatefulWidget {
  static const id = 'HomeScreen';

  const HomeNavigationScreen({Key? key}) : super(key: key);

  @override
  State<HomeNavigationScreen> createState() => _HomeNavigationScreenState();
}

class _HomeNavigationScreenState extends State<HomeNavigationScreen> {
  int _selectedBottomNavigationIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefSettingsModelCubit, PrefSettingsModel>(
        builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              NewHomeScreen(),
              ScreenActiveCertification(),
              ScreenProfile(),
            ],
          ),
          bottomNavigationBar: BubbleBottomBar(
            tilesPadding: const EdgeInsets.symmetric(vertical: 10.0),
            currentIndex: _selectedBottomNavigationIndex,
            items: [
              _bottomNavigationBarItem(
                  defaultIconData: Icons.home, label: appLocalization.home),
              _bottomNavigationBarItem(
                  defaultIconData: Icons.assignment_rounded,
                  label: appLocalization.activeCertification),
              _bottomNavigationBarItem(
                  defaultIconData: Icons.account_circle,
                  label: appLocalization.profile)
            ],
            onTap: (index) {
              setState(() {
               _reset(index ?? 0);
              });
            }, opacity: 0.2,
            hasNotch: true, //new
            hasInk: true, //new, gives a cute ink effect
            inkColor: Colors.black12, //optional, uses theme color if not specified
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
        );
      }
    );
  }

  _reset(int index){
    _selectedBottomNavigationIndex = index ;
    _pageController.jumpToPage(index);
  }
  BubbleBottomBarItem _bottomNavigationBarItem(
      {required IconData defaultIconData, required String label}) {
    return BubbleBottomBarItem(
      backgroundColor:Palette.mainBlue,
      icon: Icon(
        defaultIconData,
        color: UiConstants.colorInactive,
      ),
      activeIcon: Icon(
        defaultIconData,
        color: Palette.mainBlue,
      ),
      title: Text(
        label,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainBlue,fontWeight: FontWeight.w500 ),
      ),);
  }
}
