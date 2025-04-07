import 'package:flutter/material.dart';
import 'package:impratical_posting/dart/current_page.dart';

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
  late String _question;
  late String _answer;

  @override
  void initState() {
    super.initState();
    _question = widget.question;
    _answer = widget.answer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
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
                  TextField(
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
                TextField(
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
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(200, 30, 50, 1),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CurrentPage(),
                    ),
                  );
              },
              child: Text(
                'Update page',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),    
    );
  }
}
