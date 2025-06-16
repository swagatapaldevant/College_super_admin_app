
class ApiEndPoint{

  static final ApiEndPoint _instance = ApiEndPoint._internal();

  factory ApiEndPoint(){
    return _instance;
  }

  ApiEndPoint._internal();

  //static const baseurl = "http://192.168.29.243:8001/api";
  //static const baseurl = "http://192.168.29.243/college_him/college_him_api/public/api";
  static const baseurl = "https://devanthosting.cloud/him_v2/college_api/public/api";

  //auth module
  static const logIn =  "$baseurl/login";


  static const dashboard =  "$baseurl/app_dashboard";
  static const getCourse =  "$baseurl/getCourse";
  static const courseRevenueByCourse =  "$baseurl/course_wise_collection";
  static const getSession =  "$baseurl/getSession";
  static const getErpSettings =  "$baseurl/getErpSettings";
  static const dueCalculationApi =  "$baseurl/due_by_session";
  static const collectionBySession =  "$baseurl/collection_by_session";


}