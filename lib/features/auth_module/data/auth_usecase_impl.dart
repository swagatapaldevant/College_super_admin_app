import 'package:college_super_admin_app/core/network/apiHelper/api_endpoint.dart';
import 'package:college_super_admin_app/features/auth_module/data/auth_usecase.dart';

import '../../../core/network/apiClientRepository/api_client.dart';
import '../../../core/network/apiHelper/locator.dart';
import '../../../core/network/apiHelper/resource.dart';
import '../../../core/network/apiHelper/status.dart';
import '../../../core/services/localStorage/shared_pref.dart';

class AuthUsecaseImplementation extends AuthUsecase {
  final ApiClient _apiClient = getIt<ApiClient>();
  final SharedPref _pref = getIt<SharedPref>();

  @override
  Future<Resource> logIn({required Map<String, dynamic> requestData}) async {
    Map<String, String> header = {};
    Resource resource = await _apiClient.postRequest(
        url: ApiEndPoint.logIn, header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }
}
