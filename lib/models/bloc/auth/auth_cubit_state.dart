

import '../../entities/public_entities/user_model.dart';

class AuthCubitState {
  bool? isLoginLoading;

  String? loginErrorMessage;
  String? loginSuccessMessage;
  UserData? userData;


  AuthCubitState({this.isLoginLoading , this.userData , this.loginErrorMessage , this.loginSuccessMessage});

  AuthCubitState copyWith({
    bool? isLoginLoading,
    UserData? userData,
    String? loginErrorMessage,
    String? loginSuccessMessage,
  }) =>
      AuthCubitState(
        isLoginLoading: isLoginLoading,
        userData: userData,
        loginErrorMessage: loginErrorMessage,
        loginSuccessMessage: loginSuccessMessage,
      );
}





class SystemCubitState {
  bool? isLoading;

  String? updateMessage;
  bool? isForceUpdate;
  bool? showUpdate;



  SystemCubitState({this.isLoading , this.isForceUpdate , this.showUpdate , this.updateMessage});

  SystemCubitState copyWith({
    bool? isLoading,

    String? updateMessage,
    bool? isForceUpdate,
    bool? showUpdate,
  }) =>
      SystemCubitState(
        isLoading: isLoading,
        updateMessage: updateMessage,
        isForceUpdate: isForceUpdate,
        showUpdate: showUpdate,
      );
}
