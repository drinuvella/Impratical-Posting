import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:impratical_posting/dart/current_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Supabase.initialize(
    url: 'https://dsflgisqpeloidhntmsl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRzZmxnaXNxcGVsb2lkaG50bXNsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMjQyMjEsImV4cCI6MjA1OTYwMDIyMX0.yDODz1LuKBwYIr-JWkvwM7Yypjzm6Hl-EOMCiIoVijI',
  );
  runApp(const MainApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background message: ${message.notification?.title}");
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Impratical Posting',
      theme: ThemeData.dark(),
      home: const CurrentPage(),
    );
  }
}
