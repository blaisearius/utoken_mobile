import 'package:uac_token_mobile/services/execute_request.dart';
import 'package:get_it/get_it.dart';
import 'package:uac_token_mobile/services/login_service.dart';

GetIt service_principal = GetIt.instance;

void setupServicePrincipal() {
  //service_principal.registerSingleton<LoginService>(LoginService());
  //service_principal.registerSingleton<ExecuteRequest>(ExecuteRequest());

  service_principal.registerLazySingleton(() => LoginService());
  service_principal.registerLazySingleton(() => ExecuteRequest());

}