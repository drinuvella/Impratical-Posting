import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:impratical_posting/dart/edit_page.dart';

class CurrentPage extends StatefulWidget {
  const CurrentPage({Key? key}) : super(key: key);

  @override
  _CurrentPageState createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  String question = 'Loading...';
  String answer = 'Loading...';
  
  @override
  void initState() {
    super.initState();
    _fetchQnA();
  }

  Future _fetchQnA() async {
    setState(() {
        question = 'Loading...';
        answer = 'Loading...';
      });
    try {
      final response = await Supabase.instance.client
          .from('QuestionAnswer')
          .select()
          .limit(1)
          .single();

      setState(() {
        question = response['Question'] ?? '';
        answer = response['Answer'] ?? '';
      });
    } catch (e) {
      setState(() {
        question = 'Error loading question';
        answer = 'Error loading answer';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.125,
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      question,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditPage(answer: answer),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              color: const Color.fromRGBO(200, 30, 50, 1),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      answer,
                      maxLines: 16,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditPage(question: question),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            IconButton(onPressed: _fetchQnA, icon: const Icon(Icons.refresh, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
