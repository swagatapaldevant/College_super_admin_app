
import '../../../core/network/apiHelper/resource.dart';

abstract class AuthUsecase{

  Future<Resource> logIn({required Map<String, dynamic> requestData});




}