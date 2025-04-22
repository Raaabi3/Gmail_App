import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gmail_app/Views/GmailHomeScreen.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:googleapis_auth/auth_io.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';



void saveToken(AccessCredentials credentials) async {
  final box = await Hive.openBox('auth');
  await box.put('accessToken', credentials.accessToken.data);
  await box.put('refreshToken', credentials.refreshToken);
  await box.put('expiry', credentials.accessToken.expiry.toIso8601String());
}

Future<String> getTokenFilePath() async {
  final dir = await getApplicationDocumentsDirectory();
  return '${dir.path}/google_tokens.json';
}

Future<void> saveTokens(AccessCredentials credentials) async {
  final file = File(await getTokenFilePath());
  final jsonStr = jsonEncode({
    'accessToken': credentials.accessToken.data,
    'expiry': credentials.accessToken.expiry.toIso8601String(),
    'refreshToken': credentials.refreshToken,
    'scopes': credentials.scopes,
  });
  await file.writeAsString(jsonStr);
  print("Tokens saved.");
}

Future<AccessCredentials?> loadTokens() async {
  try {
    final file = File(await getTokenFilePath());
    if (!await file.exists()) return null;

    final jsonStr = await file.readAsString();
    final data = jsonDecode(jsonStr);
    return AccessCredentials(
      AccessToken(
        'Bearer',
        data['accessToken'],
        DateTime.parse(data['expiry']),
      ),
      data['refreshToken'],
      List<String>.from(data['scopes']),
    );
  } catch (e) {
    print("Failed to load tokens: $e");
    return null;
  }
}


void checkSavedTokenAndLogin(BuildContext context) async {
  final creds = await loadTokens();
  if (creds != null) {
    if (creds.accessToken.expiry.isAfter(DateTime.now())) {
      print("Using saved credentials...");
      final authClient = authenticatedClient(http.Client(), creds);
      final gmailApi = gmail.GmailApi(authClient);
      final profile = await gmailApi.users.getProfile("me");
      print("Logged in as: ${profile.emailAddress}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => GmailHomeScreen()),
      );
    } else {
      print("Saved credentials expired.");
      await clearSavedTokens();
    }
  } else {
    print("No saved credentials found.");
  }
}
Future<void> clearSavedTokens() async {
  final file = File(await getTokenFilePath());
  if (await file.exists()) await file.delete();

  final box = await Hive.openBox('auth');
  await box.clear();
}



