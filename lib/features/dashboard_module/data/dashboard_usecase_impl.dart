import 'package:college_super_admin_app/core/network/apiClientRepository/api_client.dart';
import 'package:college_super_admin_app/core/network/apiHelper/api_endpoint.dart';
import 'package:college_super_admin_app/core/network/apiHelper/locator.dart';
import 'package:college_super_admin_app/core/network/apiHelper/resource.dart';
import 'package:college_super_admin_app/core/network/apiHelper/status.dart';
import 'package:college_super_admin_app/core/services/localStorage/shared_pref.dart';
import 'package:college_super_admin_app/features/dashboard_module/data/dashboard_usecase.dart';

class DashboardUsecaseImplementation extends DashboardUsecase {
  final ApiClient _apiClient = getIt<ApiClient>();
  final SharedPref _pref = getIt<SharedPref>();

  @override
  Future<Resource> dashboardData({required Map<String, dynamic> requestData}) async {
    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer$token"
    };
    print("Bearer$token");
    Resource resource = await _apiClient.getRequest(
        url: ApiEndPoint.dashboard, header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }

  @override
  Future<Resource> getCourseList({required Map<String, dynamic> requestData}) async {
    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token"
      // "Authorization": "Bearer 1189|vKS1QsYNWLURVL6yQbRVx6cYpwlXfIkKHcTYlyw672146e7a"
    };
    print("Bearer$token");
    Resource resource = await _apiClient.getRequest(
        url: ApiEndPoint.getCourse, header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }

  @override
  Future<Resource> courseRevenueByCourse({required Map<String, dynamic> requestData, required String courseId}) async {
    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token"
      // "Authorization": "Bearer 1189|vKS1QsYNWLURVL6yQbRVx6cYpwlXfIkKHcTYlyw672146e7a"
    };
    print("Bearer$token");
    Resource resource = await _apiClient.getRequest(
        url: "${ApiEndPoint.courseRevenueByCourse}/$courseId", header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }
}