
import 'dart:convert';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

import 'package:fl_egypt_trust/models/bloc/appointment/appointment_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/appointment/appointment_cubit_state.dart';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/branches/branches_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/branches/branches_cubit_state.dart';
import 'package:fl_egypt_trust/models/bloc/certification/action/certification_actions_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/certification/action/certification_actions_cubit_state.dart';
import 'package:fl_egypt_trust/models/bloc/certification/certification_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/certification/certification_cubit_state.dart';
import 'package:fl_egypt_trust/models/utils/language/languages.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/ui/screens/main/branches/blocs/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/follow_orders_login/bloc/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/follow_order_bloc/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_third_form_bloc/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/fawry_bloc/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_first_form_bloc/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_registeration_bloc/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_second_form_bloc/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/update_user_data_bloc/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment_auth/blocs/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/profile/bloc/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/redesign_home/redesign_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import 'di/dependency_injection.dart';
import 'main_directional_widget.dart';
import 'models/bloc/auth/auth_cubit_state.dart';
import 'models/bloc/settings_bloc/cubit_seetings_bloc.dart';
import 'models/utils/app_preference.dart';
import 'models/utils/language/l10n.dart';
import 'models/utils/settings/settings_model.dart';
import 'models/utils/themes/theme_dark_black.dart';
import 'models/utils/themes/theme_light.dart';
import 'models/utils/themes/themes_bloc/bloc.dart';
import 'ui/screens/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "Main Navigator");

final logger = Logger();
String? locale;



// typedef MyNativeFunc = Int32 Function(Pointer<Utf8>);
// typedef MyNativeFuncDart = int Function(Pointer<Utf8>);







void main() async {
  await initSl();
// try{
//   final lib = DynamicLibrary.open('libeSealSD.so');
//   final myFunc = lib.lookupFunction<MyNativeFunc, MyNativeFuncDart>('myNativeFunc');
//   print('Result: $myFunc');
//
// }catch(e){
//   print("e is $e");
// }

  runApp(Phoenix(child: const MyApp()));

}

Future<void> initSl() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  locale = (await AppPreference.instance.getLocale()).localeValue();
  await initDependencies().then((value) {});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PrefSettingsModelCubit>(
            create: (ctx) => PrefSettingsModelCubit(PrefSettingsModel(
                currentLocale:
                    Locale(locale ?? EnumLanguage.arabic.localeValue()),
                currentThemeMode: ThemeMode.light)),),
          BlocProvider<AppointmentCubit>(create: (ctx) => AppointmentCubit(AppointmentCubitState()),),
          BlocProvider<CertificationCubit>(create: (ctx) => CertificationCubit(CertificationCubitState()),),
          BlocProvider<CertificationActionsCubit>(create: (ctx) => CertificationActionsCubit(CertificationActionsCubitState()),),
          BlocProvider<BranchesCubit>(create: (ctx) => BranchesCubit(BranchesCubitState()),),
          BlocProvider<AuthCubit>(create: (ctx) => AuthCubit(AuthCubitState()),),
          BlocProvider<SystemCubit>(create: (ctx) => SystemCubit(SystemCubitState()),),
          BlocProvider<FawryBloc>(create: (context) => sl<FawryBloc>()),
          BlocProvider<PaymentFirstFormBloc>(create: (context) => sl<PaymentFirstFormBloc>()),
          BlocProvider<PaymentSecondFormStatesBloc>(create: (context) => sl<PaymentSecondFormStatesBloc>()),
          BlocProvider<PaymentSecondFormCitiesBloc>(create: (context) => sl<PaymentSecondFormCitiesBloc>()),
          BlocProvider<PaymentSecondFormSubscriptionsBloc>(create: (context) => sl<PaymentSecondFormSubscriptionsBloc>()),
          BlocProvider<PaymentRegistrationBloc>(create: (context) => sl<PaymentRegistrationBloc>()),
          BlocProvider<HomeViewBloc>(create: (context) => sl<HomeViewBloc>()),
          BlocProvider<PaymentThirdFormBloc>(create: (context) => sl<PaymentThirdFormBloc>()),
          BlocProvider<ThemeBloc>(create: (context) => sl<ThemeBloc>()),
          BlocProvider<PaymentFourthScreensTransBloc>(create:(context)=>sl<PaymentFourthScreensTransBloc>()),
          BlocProvider<PaymentAuthBloc>(create:(context)=>sl<PaymentAuthBloc>()),
          BlocProvider<BranchesBloc>(create:(context)=>sl<BranchesBloc>()),
          BlocProvider<ProfileTransBloc>(create:(context)=>sl<ProfileTransBloc>()),
          BlocProvider<FollowOrderBloc>(create:(context)=>sl<FollowOrderBloc>()),
          BlocProvider<PaymentUpdateUserDataBloc>(create:(context)=>sl<PaymentUpdateUserDataBloc>()),
          BlocProvider<FollowOrderLoginBloc>(create:(context)=>sl<FollowOrderLoginBloc>()),
        ],
        child: BlocBuilder<PrefSettingsModelCubit, PrefSettingsModel>(
          builder: (context, state) {
            return Sizer(builder: (BuildContext context,
                Orientation orientation, DeviceType deviceType) {
              return OKToast(
                child: MaterialApp(
                    navigatorKey: navigatorKey,
                    locale: state.currentLocale ??
                        Locale(EnumLanguage.arabic.localeValue()),
                    localizationsDelegates:
                        AppLocalizationsDelegate.localizationsDelegates,
                    localeResolutionCallback:
                        AppLocalizationsDelegate.localeResolutionCallback,
                    themeMode: state.currentThemeMode,
                    theme: lightTheme,
                    debugShowCheckedModeBanner: false,
                    darkTheme: darkBlackTheme,
                    supportedLocales: L10n.all,
                    initialRoute: ScreenSplash.id,
                    routes: {
                      ScreenSplash.id: (context) =>
                          const ScreenSplash(),
                    }),
              );
            });
          },
        ));
  }
}
