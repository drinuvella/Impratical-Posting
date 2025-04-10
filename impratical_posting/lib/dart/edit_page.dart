import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:impratical_posting/dart/current_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditPage extends StatefulWidget {
  final String question;
  final String answer;

  EditPage({
    super.key,
    this.question = "", // 69 characters long 
    this.answer = "", // 420 characters long
  });

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  late String _question;
  late String _answer;

  @override
  void initState() {
    super.initState();
    _initFirebaseMessaging();
    _question = widget.question;
    _answer = widget.answer;
  }

  Future<void> _initFirebaseMessaging() async {

  FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();

    String? token = await messaging.getToken();
    if(token != null) {
      await _setFcmToken(token);
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await _setFcmToken(newToken);
    });
  }

  Future<void> _setFcmToken(String token) async {
    try {
      await Supabase.instance.client.from('NotificationTokens').insert({
        'fcm_token': token,
      });
    } catch (e) {
      print('Error setting FCM token: $e');
    }
  }
  
  void _updatePost() async {
    if(! _formKey.currentState!.validate())
      return;

    _formKey.currentState!.save();

    final supabase = Supabase.instance.client;

    final rowId = 'f6873045-8b16-40e9-80ed-8f3d0b95b8c0';

    try {
      final updates = <String, dynamic>{};

        updates['Question'] = _question;
        updates['Answer'] = _answer;

      if (updates.isNotEmpty) {
        final data = await supabase
            .from('QuestionAnswer')
            .update(updates)
            .eq('ID', rowId);
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CurrentPage(),
        ),
      );
    } catch (error) {
      print('Failed to update: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.125,
              child: _question.length>0 ?
                Text(
                  _question,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ):
                TextFormField(
                  validator: (value){
                  if (value == null || value.isEmpty){
                    return 'Please enter a question';
                  }
                  return null;
                },
                onSaved: (value){
                  _question = value!;
                },
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: "Enter you question here"
                  ),
                  maxLength: 69,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            SizedBox(height: MediaQuery.of(context).size.height*0.025),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.65,
              color: Color.fromRGBO(200, 30, 50, 1),
              child: 
              Center(
                child: 
                _answer.length>0 ?
                Text(
                  _answer,
                  maxLines: 16,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ):
                TextFormField(
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: "Enter your answer here"
                  ),
                  maxLength: 420,
                  maxLines: 16,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return 'Please enter an answer';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _answer = value!;
                  }
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(200, 30, 50, 1),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
              onPressed:_updatePost,
              child: Text(
                'Update page',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],),
        ),
      ),    
    );
  }
}
