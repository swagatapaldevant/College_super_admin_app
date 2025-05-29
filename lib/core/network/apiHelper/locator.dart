
import 'package:get_it/get_it.dart';

import '../../services/localStorage/shared_pref.dart';
import '../../services/localStorage/shared_pref_impl.dart';
import '../apiClientRepository/api_client.dart';
import '../apiClientRepository/api_client_impl.dart';
import '../networkRepository/network_client.dart';
import '../networkRepository/network_client_impl.dart';

final getIt = GetIt.instance;

void initializeDependency(){

  getIt.registerFactory<NetworkClient>(()=> NetworkClientImpl());
  getIt.registerFactory<SharedPref>(()=>SharedPrefImpl());
  getIt.registerFactory<ApiClient>(()=> ApiClientImpl());







}