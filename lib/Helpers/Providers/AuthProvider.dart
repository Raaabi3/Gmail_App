import 'package:flutter/widgets.dart';

import '../../Models/EmailModel.dart';

class Authprovider extends ChangeNotifier {
  String currentUserEmail = '10200053mbr@gmail.com';
  List<String> previousUserEmails = <String>[];
  List<EmailModel>? emailList;
  String _accessToken = '';
  String _refreshToken = '';
  DateTime _expiry = DateTime.now();

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;
  DateTime get expiry => _expiry;
  List<EmailModel>? get emails => emailList;

  void setemails(List<EmailModel>? emails) {
    emailList = emails;
    print("emails set");
    notifyListeners();
  }

  void setAccessToken(String token) {
    _accessToken = token;
    notifyListeners();
  }

  void setRefreshToken(String token) {
    _refreshToken = token;
    notifyListeners();
  }

  void setExpiry(DateTime expiry) {
    _expiry = expiry;
    notifyListeners();
  }
}
