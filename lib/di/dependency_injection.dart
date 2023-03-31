import 'package:fawry_sdk/fawry_sdk.dart';
import 'package:fl_egypt_trust/data/local_data_source/home/home_local_data.dart';
import 'package:fl_egypt_trust/data/local_data_source/payment/payment_local_data.dart';
import 'package:fl_egypt_trust/data/remote_data_source/home/home_remote_data.dart';
import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/repository/networks/home_repo/home_network_repo.dart';
import 'package:fl_egypt_trust/repository/networks/payment/payment_network.dart';
import 'package:fl_egypt_trust/ui/screens/main/follow_orders_login/bloc/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/update_user_data_bloc/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/redesign_home/redesign_bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../data/local_data_source/branches/branches_local_data.dart';
import '../data/local_data_source/payment_auth/payment_auth_local_data/payment_auth_local_data.dart';
import '../data/local_data_source/profile/profile_local_data.dart';
import '../data/local_data_source/sd.dart';
import '../data/local_data_source/theme/them_local_data.dart';
import '../data/remote_data_source/branches/branches_remote_data.dart';
import '../data/remote_data_source/payment/payment_romte_data.dart';
import '../data/remote_data_source/payment_auth/payment_auth_remote_data.dart';
import '../data/remote_data_source/profile/profile_remote_data.dart';
import '../data/remote_data_source/theme/theme_remote_data.dart';
import '../data/services/dio/dio_client.dart';
import '../data/services/fawry_payment_service.dart';
import '../data/services/network_info.dart';
import '../models/utils/themes/themes_bloc/bloc.dart';
import '../repository/common_function/handle_dio_error_excptions.dart';
import '../repository/networks/branches_repo/branches_network_repo.dart';
import '../repository/networks/payment_auth/paymnet_auth_network_repo.dart';
import '../repository/networks/profile_repo/profile_network_repo.dart';
import '../repository/networks/theme_repo/theme_network_repo.dart';
import '../ui/screens/main/branches/blocs/bloc.dart';
import '../ui/screens/main/payment/bloc/fawry_bloc/bloc.dart';
import '../ui/screens/main/payment/bloc/follow_order_bloc/bloc.dart';
import '../ui/screens/main/payment/bloc/payment_first_form_bloc/bloc.dart';
import '../ui/screens/main/payment/bloc/payment_registeration_bloc/bloc.dart';
import '../ui/screens/main/payment/bloc/payment_second_form_bloc/bloc.dart';
import '../ui/screens/main/payment/bloc/payment_third_form_bloc/bloc.dart';
import '../ui/screens/main/payment_auth/blocs/bloc.dart';
import '../ui/screens/main/profile/bloc/bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  initPlugins();
  initServices();
  registerBlocs();
  registerRemoteSources();
  initRepos();
  registerUtils();
  registerLocalDataSources();
}

Future<void> initPlugins() async {
  sl.registerLazySingleton<FawrySdk>(() => FawrySdk.instance);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

Future<void> initServices() async {
  sl.registerLazySingleton<FarwryPaymentService>(() => FarwryPaymentService());
  sl.registerLazySingleton<DioClientService>(() => DioClientService());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton<AppPreference>(() =>AppPreference() );
}

/// register app blocs
void registerBlocs() {
  sl.registerFactory<FawryBloc>(() => FawryBloc(paymentNetworkRepo: sl()));
  sl.registerFactory<PaymentFirstFormBloc>(
      () => PaymentFirstFormBloc(paymentNetworkRepo: sl()));
  sl.registerFactory<PaymentSecondFormStatesBloc>(() => PaymentSecondFormStatesBloc(paymentNetwrokRepo: sl()));
  sl.registerFactory<PaymentSecondFormCitiesBloc>(() => PaymentSecondFormCitiesBloc(paymentNetwrokRepo: sl()));
  sl.registerFactory<PaymentSecondFormSubscriptionsBloc>(() => PaymentSecondFormSubscriptionsBloc( paymentNetworkRepo: sl()));
  sl.registerFactory<PaymentRegistrationBloc>(() => PaymentRegistrationBloc( paymentNetworkRepo: sl()));
  sl.registerFactory<HomeViewBloc>(() => HomeViewBloc( homeNetworkRepo: sl()));
  sl.registerLazySingleton<ThemeBloc>(() => ThemeBloc(themeNetworkRepo: sl()));
  sl.registerFactory<PaymentThirdFormBloc>(() => PaymentThirdFormBloc( paymentNetwrokRepo: sl()));
  sl.registerFactory<PaymentFourthScreensTransBloc>(() => PaymentFourthScreensTransBloc( paymentNetworkRepo: sl()));
  sl.registerFactory<PaymentAuthBloc>(() => PaymentAuthBloc(paymentAuthNetworkRepo: sl()));
  sl.registerFactory<BranchesBloc>(() => BranchesBloc( branchesNetworkRepo: sl()));
  sl.registerFactory<ProfileTransBloc>(() => ProfileTransBloc(profileNetworkRepo: sl()));
  sl.registerFactory<FollowOrderBloc>(() => FollowOrderBloc(paymentLocalData: sl(),paymentNetworkRepo: sl()));
  sl.registerFactory<PaymentUpdateUserDataBloc>(() => PaymentUpdateUserDataBloc(paymentNetworkRepo: sl()));
  sl.registerFactory<FollowOrderLoginBloc>(() => FollowOrderLoginBloc( paymentAuthNetworkRepo: sl()));

}

/// register app remote data sources
void registerRemoteSources() {
  sl.registerLazySingleton<PaymentRemoteData>(() => PaymentRemoteDataImpl());
  sl.registerLazySingleton<HomeRemoteData>(() => HomeRemoteDataImpl(homeLocalData: sl(), dioClientService: sl()));
  sl.registerLazySingleton<ThemeRemoteData>(() => ThemeRemoteDataImpl(dioClientService: sl()));
  sl.registerLazySingleton<PaymentAuthRemoteData>(() => PaymentAuthRemoteDataImpl());
  sl.registerLazySingleton<BranchesRemoteData>(() => BranchesRemoteDataImpl());
  sl.registerLazySingleton<ProfileRemoteData>(() => ProfileRemoteDataImpl(profileLocalData: sl(), dioClientService: sl()));
}

void registerLocalDataSources(){
  sl.registerLazySingleton<PaymentLocalData>(() =>PaymentLocalDataImpl() );
  sl.registerLazySingleton<HomeLocalData>(() =>HomeLocalDataImpl() );
  sl.registerLazySingleton<ThemeLocalData>(() => ThemeLocalDataImpl());
  sl.registerLazySingleton<PaymentAuthLocalData>(() => PaymentAuthLocalDataImpl());
  sl.registerLazySingleton<BranchesLocalData>(() => BranchesLocalDataImpl());
  sl.registerLazySingleton<ProfileLocalData>(() => ProfileLocalDataImpl());
  sl.registerLazySingleton<SDLocalData>(() => SDLocalDataImpl());
}

void initRepos() {
  sl.registerLazySingleton<PaymentNetworkRepo>(
      () => PaymentNetworkRepo(paymentRemoteData: sl(),appPreference: sl(),paymentLocalData: sl()));

  sl.registerLazySingleton<HomeNetworkRepo>(() => HomeNetworkRepo(homeRemoteData: sl(), homeLocalData: sl()));

  sl.registerLazySingleton<ThemeNetworkRepo>(() => ThemeNetworkRepo(themeLocalData: sl(),themeRemoteData: sl()));
  sl.registerLazySingleton<PaymentAuthNetworkRepo>(() => PaymentAuthNetworkRepo(paymentAuthRemoteData: sl()));
  sl.registerLazySingleton<BranchesNetworkRepo>(() =>BranchesNetworkRepo(branchesLocalData: sl(), branchesRemoteData: sl()));
  sl.registerLazySingleton<ProfileNetworkRepo>(() =>ProfileNetworkRepo(profileLocalData: sl(),profileRemoteData: sl()));


}

void registerUtils(){
  sl.registerLazySingleton<DioErrorsImpl>(() => DioErrorsImpl());
}
