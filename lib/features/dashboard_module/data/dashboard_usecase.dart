import 'package:college_super_admin_app/core/network/apiHelper/resource.dart';

abstract class DashboardUsecase{

  Future<Resource> dashboardData({required Map<String, dynamic> requestData});
  Future<Resource> getCourseList({required Map<String, dynamic> requestData});
  Future<Resource> courseRevenueByCourse({required Map<String, dynamic> requestData, required String courseId});
  Future<Resource> getSessionList({required Map<String, dynamic> requestData});
  Future<Resource> getErpSettings({required Map<String, dynamic> requestData});
  Future<Resource> getAllDueData({required Map<String, dynamic> requestData});
  Future<Resource> getAllCourseDetailsData({required Map<String, dynamic> requestData});
  Future<Resource> getAllCollectionBySession({required Map<String, dynamic> requestData});




}