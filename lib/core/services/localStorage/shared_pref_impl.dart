import 'dart:convert';
import 'package:college_super_admin_app/core/services/localStorage/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefImpl extends SharedPref {


  final String _languageId = "Language Id";
  final String _loginStatus = "loginStatus";
  final String _childId = "child id";
  final String _userType = "user type";
  final String _vowelId = "vowel id";
  final String _consonantId = "consonant id";
  final String _numericId = "numeric id";
  final String _userName = "user name";
  final String _currentLanguageName = "language name";


  final String _childrenListKey = "childrenList";
  final String _childrenCount = "childrenCount";




  final String _userId = "userId";
  final String _firebaseToken = "firebaseToken";
  final String _deviceIMEINo = "deviceImeiNo";
  final String _userAuthToken = "userAuthToken";
  final String _phoneCode = "phoneCode";
  final String _userAge = "userAge";
  final String _phoneNumber = "phoneNumber";
  final String _emailId = "emailId";
  final String _profileImage = "profileImg";
  final String _premimumStatus = "PremimumStatus";


  @override
  Future<String?> getLanguageId() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_languageId) ?? "";
  }

  @override
  void setLanguageId(String id) async{
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_languageId, id);
  }

  @override
  Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getBool(_loginStatus) ?? false;
  }

  @override
  void setLoginStatus(bool status) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setBool(_loginStatus, status);
  }

  @override
  Future<String> getUserAuthToken() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_userAuthToken) ?? "";
  }

  @override
  void setUserAuthToken(String token) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_userAuthToken, token);
  }

  @override
  Future<String> getChildId() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_childId) ?? "";
  }

  @override
  void setChildId(String childId) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_childId, childId);
  }


  @override
  Future<String> getUserType() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_userType) ?? "";
  }

  @override
  void setUserType(String userType) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_userType,userType );
  }

  @override
  Future<String> getVowelId() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_vowelId) ?? "";
  }

  @override
  void setVowelId(String vowelId) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_vowelId, vowelId);
  }

  @override
  Future<String> getConsonantId() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_consonantId) ?? "";
  }

  @override
  void setConsonantId(String consonantId) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_consonantId, consonantId);
  }

  @override
  Future<String> getNumericId() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_numericId) ?? "";
  }

  @override
  void setNumericId(String numericId) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_numericId, numericId);
  }

  @override
  Future<String> getUserName() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_userName) ?? "";
  }

  @override
  void setUserName(String userName) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_userName, userName);
  }

  @override
  Future<String> getCurrentLanguageName() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_currentLanguageName) ?? "";
  }

  @override
  void setCurrentLanguageName(String languageName) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_currentLanguageName, languageName);
  }








  @override
  void clearOnLogout() async {
    final SharedPreferences prefs = await super.prefs;
    for(String key in prefs.getKeys()) {

      prefs.
      remove(key);
      // }
    }
  }

  @override
  Future<void> setChildrenList(Map<String, String> childrenList) async {
    final SharedPreferences prefs = await super.prefs;
    String encodedChildrenList = jsonEncode(childrenList);
    prefs.setString(_childrenListKey, encodedChildrenList);
  }

  @override
  Future<Map<String, String>> getChildrenList() async {
    final SharedPreferences prefs = await super.prefs;
    String? encodedChildrenList = prefs.getString(_childrenListKey);

    if (encodedChildrenList != null) {
      Map<String, dynamic> decodedMap = jsonDecode(encodedChildrenList);
      return decodedMap.map((key, value) => MapEntry(key, value.toString())); // Ensure values are String
    }

    return {}; // Return empty map if no data exists
  }

  @override
  Future<String> getChildrenCount() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_childrenCount) ?? "";
  }

  @override
  void setChildrenCount(String childrenCount) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_childrenCount,childrenCount);
  }
















///////////////////////////////
  @override
  Future<bool> getPremimumStatus() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getBool(_premimumStatus) ?? false;
  }

  @override
  Future<int> getUserId() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getInt(_userId) ?? 0;
  }

  @override
  Future<String> getFirebaseToken() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_firebaseToken) ?? "";
  }

  @override
  Future<String> getDeviceIMEINo() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_deviceIMEINo) ?? "";
  }




  @override
  Future<String> getPhoneCode() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_phoneCode) ?? "";
  }

  @override
  Future<String> getAge() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_userAge) ?? "";
  }

  @override
  Future<String> getName() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_userName) ?? "";
  }

  /////////////////////////////////


  @override
  void setPremimumStatus(bool status) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setBool(_premimumStatus, status);
  }

  @override
  void setUserId(int rollId) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setInt(_userId, rollId);
  }

  @override
  void setFirebaseToken(String token) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_firebaseToken, token);
  }

  @override
  void setDeviceIMEINo(String token) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_deviceIMEINo, token);
  }



  @override
  void setPhoneCode(String data) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_phoneCode, data);
  }

  @override
  void setAge(String data) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_userAge, data);
  }

  @override
  void setName(String data) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_userName, data);
  }



  @override
  Future<String> getEmail() async{
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_emailId) ?? "";
  }

  @override
  Future<String> getPhone() async{
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_phoneNumber) ?? "";
  }

  @override
  void setEmail(String data) async{
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_emailId, data);
  }

  @override
  void setPhone(String data) async{
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_phoneNumber, data);
  }

  @override
  Future<String?> getProfileImage() async{
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_profileImage);
  }

  @override
  void setProfileImage(String data) async{
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_profileImage, data);
  }






}