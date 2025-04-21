import 'package:flutter/widgets.dart';

class Authprovider extends ChangeNotifier{

  String _accessToken = '';
  String _refreshToken = '';
  DateTime _expiry = DateTime.now();

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;
  DateTime get expiry => _expiry;

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