import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  bool? isConnect=false;
}

class NetworkInfoImpl implements NetworkInfo {

  @override
  bool ?isConnect=false;

  InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImpl({required this.internetConnectionChecker});

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;






}
