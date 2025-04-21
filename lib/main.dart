import 'package:flutter/material.dart';
import 'package:gmail_app/Models/AuthTokenModel.dart';
import 'package:gmail_app/Models/EmailModel.dart';
import 'package:gmail_app/Models/LabelModel.dart';
import 'package:gmail_app/Models/UserModel.dart';
import 'package:gmail_app/Views/AuthScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'Helpers/Providers/AuthProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(EmailModelAdapter());
  Hive.registerAdapter(LabelModelAdapter());

  await Hive.openBox<UserModel>('user');
  await Hive.openBox<EmailModel>('emails');
  await Hive.openBox<LabelModel>('labels');
  await Hive.openBox('auth');
  

  runApp(ChangeNotifierProvider(create: (_) => Authprovider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gmail Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Authscreen(),
    );
  }
}
