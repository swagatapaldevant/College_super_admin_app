import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPref {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  SharedPref();

  // for language id
  void setLanguageId(String id);
  Future<String?>getLanguageId();

  // for login or not
  void setLoginStatus(bool status);
  Future<bool> getLoginStatus();

  // for authentication token
  void setUserAuthToken(String authToken);
  Future<String> getUserAuthToken();

  // for candidate id
  void setChildId(String childId);
  Future<String?> getChildId();


  // for userType(child/parent)
  void setUserType(String userType);
  Future<String> getUserType();

  // for vowelId
  void setVowelId(String vowelId);
  Future<String> getVowelId();

  // for consonantId
  void setConsonantId(String consonantId);
  Future<String> getConsonantId();

  // for consonantId
  void setNumericId(String consonantId);
  Future<String> getNumericId();

  // for name(child/parent)
  void setUserName(String userName);
  Future<String?> getUserName();

  // for language name
  void setCurrentLanguageName(String languageName);
  Future<String?> getCurrentLanguageName();






  // store children list
  void setChildrenList(Map<String, String> childrenList);
  Future<Map<String, String>> getChildrenList();

  // store children count
  void setChildrenCount(String childrenCount);
  Future<String?> getChildrenCount();

  void clearOnLogout();





  void setPremimumStatus(bool status);
  Future<bool> getPremimumStatus();

  void setUserId(int rollId);
  Future<int> getUserId();

  void setFirebaseToken(String token);
  Future<String> getFirebaseToken();


  void setDeviceIMEINo(String token);
  Future<String> getDeviceIMEINo();



  void setPhoneCode(String data);

  Future<String> getPhoneCode();

  void setAge(String data);

  Future<String> getAge();

  void setName(String data);
  Future<String> getName();

  void setEmail(String data);
  Future<String> getEmail();


  void setPhone(String data);
  Future<String> getPhone();

  void setProfileImage(String data);
  Future<String?> getProfileImage();


}