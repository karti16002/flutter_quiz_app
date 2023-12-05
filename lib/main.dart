import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: QuizScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  bool _submitted = false;

  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Berlin', 'Madrid', 'Paris', 'Rome'],
      'correctIndex': 2,
    },
    {
      'question': 'Which programming language is Flutter based on?',
      'options': ['Dart', 'Java', 'Python', 'C++'],
      'correctIndex': 0,
    },
    {
      'question': 'What is the largest mammal in the world?',
      'options': ['Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'],
      'correctIndex': 1,
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Mars', 'Venus', 'Jupiter', 'Saturn'],
      'correctIndex': 0,
    },
    {
      'question': 'Who wrote "Romeo and Juliet"?',
      'options': [
        'Charles Dickens',
        'Jane Austen',
        'William Shakespeare',
        'Mark Twain'
      ],
      'correctIndex': 2,
    },
    {
      'question': 'What is the capital of Japan?',
      'options': ['Beijing', 'Seoul', 'Tokyo', 'Bangkok'],
      'correctIndex': 2,
    },
    // Add more questions...
  ];

  void _checkAnswer(int selectedIndex) {
    if (selectedIndex == questions[_currentIndex]['correctIndex']) {
      setState(() {
        _score++;
      });
    }
  }

  void _nextQuestion() {
    setState(() {
      if (_currentIndex < questions.length - 1) {
        _currentIndex++;
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  void _submitQuiz() {
    setState(() {
      _submitted = true;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quiz Results'),
        content: Text('Your Score: $_score / ${questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Continue', style: TextStyle(color: Colors.teal)),
          ),
          TextButton(
            onPressed: () {
              _restartQuiz(); // Call _restartQuiz when Restart Quiz is pressed
              Navigator.pop(context);
            },
            child: Text('Restart Quiz', style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
    );
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _submitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Quiz App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Add more drawer items...
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentIndex + 1}/${questions.length}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      questions[_currentIndex]['question'],
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    ...((questions[_currentIndex]['options'] as List<String>)
                        .asMap()
                        .entries
                        .map(
                          (entry) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ElevatedButton(
                              onPressed: _submitted
                                  ? null
                                  : () {
                                      _checkAnswer(entry.key);
                                      _nextQuestion();
                                    },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.teal,
                                textStyle: TextStyle(fontSize: 16),
                              ),
                              child: Text(entry.value),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      _previousQuestion();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                    ),
                    child:
                        Text('Previous', style: TextStyle(color: Colors.white)),
                  ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _submitted
                      ? null
                      : () {
                          _submitQuiz();
                        },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _submitted
                      ? () {
                          _restartQuiz();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                  child: Text('Restart', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (_submitted)
              Center(
                child: Text(
                  'Your Score: $_score / ${questions.length}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_submitted) {
            _nextQuestion();
          }
        },
        child: Icon(Icons.navigate_next),
        backgroundColor: Colors.teal,
      ),
    );
  }
}