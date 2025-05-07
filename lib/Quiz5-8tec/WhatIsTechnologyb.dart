import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart'; // Adding animation library
import '../core/app_shared_variables.dart';
import '../core/services/firebase_services.dart';
void main() {
  runApp(const WhatIsTechnologyb());
}

class WhatIsTechnologyb extends StatelessWidget {
  const WhatIsTechnologyb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Technology Tools 2 (Ages 5-8)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial', // A common and readable English font
      ),
      home: const QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> questions = [
    {
      'question': '🎮 Are computers ONLY for playing video games?',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': '🖥️ Does the monitor HELP us see pictures and data on the computer?',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': '🖱️ Is the mouse ONLY for moving the arrow on the screen?',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': '⌨️ Does the keyboard ONLY have letters and numbers?',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': '📢 Are speakers ONLY for playing music?',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': '📹 Do we use a webcam to make video calls?',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': '🎤 Is the microphone ONLY for recording sound?',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': '💻 Can a laptop (a computer we can carry) go ANYWHERE?',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': '🖨️ Does the printer put words and pictures on paper?',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': '📠 Does the scanner put paper documents and pictures INTO the computer?',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': '❓ Which of these is NOT usually used with a computer?',
      'options': ['🖱️ Mouse', '⌨️ Keyboard', '✂️ Scissors', '📢 Speakers'],
      'correctAnswer': '✂️ Scissors',
    },
    {
      'question': '💾 What is another name for a flash drive?',
      'options': ['💿 Hard disk', '🔋 Battery', '🔑 Pen drive', '🔌 Charger'],
      'correctAnswer': '🔑 Pen drive',
    },
    {
      'question': '📹 What does a webcam do?',
      'options': ['🖨️ Printing documents', '📞 Making video calls', '💾 Saving files', '🎶 Playing music'],
      'correctAnswer': '📞 Making video calls',
    },
    {
      'question': '📠 Which tool puts paper documents and pictures into the computer?',
      'options': ['🖨️ Printer', '🎤 Microphone', '📠 Scanner', '💾 Flash drive'],
      'correctAnswer': '📠 Scanner',
    },
    {
      'question': '🛠️ Which of these can work with BOTH a computer and a laptop?',
      'options': ['🎤 Microphone', '🖱️ Mouse', '⌨️ Keyboard', '✅ All of the above'],
      'correctAnswer': '✅ All of the above',
    },
  ];

  int currentQuestionIndex = 0;
  String? selectedAnswer;
  String? feedbackMessage;
  int correctAnswersCount = 0;
  int? firstScore;
  bool quizFinished = false;
  late SharedPreferences _prefs;
  AnimationController? _animationController;
  Animation<double>? _animation;
  int? lastScore;

  @override
  void initState() {
    super.initState();
    _loadLastScore();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  _loadLastScore() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      lastScore = _prefs.getInt('techQuiz2Ages5to8LastScore');
    });
  }

  _saveLastScore() async {
    await _prefs.setInt('techQuiz2Ages5to8LastScore', correctAnswersCount);
  }

  void checkAnswer(String selectedOption) {
    if (quizFinished || selectedAnswer != null) return;

    setState(() {
      selectedAnswer = selectedOption;
      if (selectedAnswer == questions[currentQuestionIndex]['correctAnswer']) {
        feedbackMessage = '🌟 You got it! That\'s right! 🌟';
        correctAnswersCount++;
      } else {
        feedbackMessage = '🤔 Not quite! Let\'s think about it!';
      }

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          selectedAnswer = null;
          feedbackMessage = null;
          _animationController!.reset();
          _animationController!.forward();
          if (currentQuestionIndex < questions.length - 1) {
            currentQuestionIndex++;
          } else {
            // ignore: prefer_conditional_assignment
            if (firstScore == null) {
              firstScore = correctAnswersCount;
            }
            quizFinished = true;
            _saveLastScore();
            FirebaseFile.addResult(email!, "Religion", "5-15", '$firstScore', 'Days of the Week Quiz');// حفظ النتيجة عند انتهاء الاختبار
// Save the score when the quiz ends
          }
        });
      });
    });
  }

  String getResultMessage() {
    double percentage = correctAnswersCount / questions.length;
    if (percentage >= 0.8) {
      return '🚀 You are a technology expert! Keep learning! 🚀';
    } else if (percentage >= 0.6) {
      return '💡 Great job! You know a lot about computer tools! 💡';
    } else if (percentage >= 0.4) {
      return '👍 You\'re doing great! Keep exploring technology! 👍';
    } else {
      return '🌱 Keep trying! Every question helps you learn something new! 🌱';
    }
  }

  void _resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      correctAnswersCount = 0;
      quizFinished = false;
      _animationController!.reset();
      _animationController!.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (quizFinished) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFE4B5), Color(0xFFFFDAB9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orangeAccent, width: 3),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ZoomIn(
                    child: const Text(
                      '🎉 Quiz Finished! 🎉',
                      style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Your score: $correctAnswersCount / ${questions.length}',
                    style: const TextStyle(fontSize: 22.0),
                  ),
                  if (firstScore != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '🥇 First try score: $firstScore / ${questions.length}',
                        style: const TextStyle(fontSize: 18.0, color: Colors.purple),
                      ),
                    ),
                  if (lastScore != null && lastScore != firstScore)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '⭐ Previous best: $lastScore / ${questions.length}',
                        style: const TextStyle(fontSize: 18.0, color: Colors.blue),
                      ),
                    ),
                  const SizedBox(height: 15.0),
                  Text(
                    getResultMessage(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal),
                  ),
                  const SizedBox(height: 25.0),
                  ElevatedButton.icon(
                    onPressed: _resetQuiz,
                    icon: const Icon(Icons.replay, color: Colors.white),
                    label: const Text('🔁 Try Again!', style: TextStyle(fontSize: 18, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final currentQuestion = questions[currentQuestionIndex];
    final questionText = currentQuestion['question'] as String;
    final optionsList = currentQuestion['options'] as List<String>;
    final correctAnswer = currentQuestion['correctAnswer'] as String;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF87CEEB), Color(0xFFF0FFF0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: ScaleTransition(
              scale: _animation!,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFACD),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.brown, width: 3.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeInDown(
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          '🛠️', // Tools emoji
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        questionText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...optionsList.map((option) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElasticIn(
                            child: ElevatedButton(
                              onPressed: selectedAnswer == null
                                  ? () => checkAnswer(option)
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    option == correctAnswer && selectedAnswer == option
                                        ? Colors.greenAccent
                                        : (selectedAnswer == option &&
                                                option != correctAnswer)
                                            ? Colors.redAccent
                                            : Colors.lightGreen,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 15.0),
                                textStyle: const TextStyle(fontSize: 18.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(option),
                            ),
                          ),
                        )),
                    if (feedbackMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: BounceInDown(
                          child: Text(
                            feedbackMessage!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: feedbackMessage!.contains('got it')
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        'Question ${currentQuestionIndex + 1} / ${questions.length}',
                        style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Pulse(
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: Spin(
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}