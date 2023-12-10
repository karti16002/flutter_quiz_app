import 'package:flutter/material.dart';

// Question model
class Question {
  final String question;
  final List<String> options;
  final int answer;

  Question({
    required this.question,
    required this.options,
    required this.answer,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QUIZ(),
    );
  }
}

class QUIZ extends StatefulWidget {
  const QUIZ({Key? key}) : super(key: key);

  @override
  State<QUIZ> createState() => _QUIZState();
}

class _QUIZState extends State<QUIZ> {
  // List of questions
  final List<Question> questions = [
    Question(
      question: 'Which team won the first Cricket World Cup?',
      options: ['West-Indies', 'Australia', 'England', 'India'],
      answer: 0, // Index of the correct answer
    ),
    Question(
      question: 'On which date the Chandrayaan-3 was launched?',
      options: ['19 July', '23 August', '15 August', '14 July'],
      answer: 3,
    ),
     Question(
      question: 'What city is known as "The Eternal City"? ',
      options: ['Tokyo', 'Rome', 'California', 'Paris'],
      answer: 1,
    ),
     Question(
      question: 'What country has won the most World Cups?',
      options: ['Brazil', 'Argentina', 'India', 'Portugal'],
      answer: 0,
    ),
     Question(
      question: 'Which planet has the most moons?',
      options: ['Uranus', 'Jupiter', 'Saturn', 'Venus'],
      answer: 3,
    ),
    // ... Add more questions ...
  ];

  int _currentQuestionIndex = 0; // Current question index
  int _score = 0; // Score

  void _checkAnswer(int optionIndex) {
    if (_currentQuestionIndex < questions.length) {
      if (optionIndex == questions[_currentQuestionIndex].answer) {
        // Correct answer
        _score++;
      } else {
        // Wrong answer
      }
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= questions.length) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Quiz Completed!'),
              Text('Your score: $_score/${questions.length}'),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentQuestionIndex = 0;
                    _score = 0;
                  });
                },
                child: Text('Restart Quiz'),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Question ${_currentQuestionIndex + 1}/${questions.length}',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 20.0),
              Text(questions[_currentQuestionIndex].question),
              SizedBox(height: 20.0),
              for (int i = 0; i < questions[_currentQuestionIndex].options.length; i++)
                ElevatedButton(
                  onPressed: () => _checkAnswer(i),
                  child: Text(questions[_currentQuestionIndex].options[i]),
                ),
            ],
          ),
        ),
      );
    }
  }
}
