import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';

void main() {
  runApp(const HealthyEatingHabitsQuizApp());
}

class HealthyEatingHabitsQuizApp extends StatelessWidget {
  const HealthyEatingHabitsQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz: Healthy Eating Habits',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Kufam',
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
    // Part 1: True or False
    {
      'question': 'True or False: Eating vegetables is good for your health.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': 'True or False: Pizza is a healthy food choice.',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': 'True or False: Fruits are a good source of vitamins.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': 'True or False: Hamburgers are a healthy food choice.',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': 'True or False: Eating grains provides your body with carbs and nutrients.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': 'True or False: Potato chips are a healthy snack.',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': 'True or False: Fish is a good source of protein.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': 'True or False: Pastries are a healthy dessert.',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': 'True or False: Drinking milk makes you strong.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    // Part 2: Multiple Choice
    {
      'question': 'Which of the following is a healthy food?',
      'options': ['a) Pizza', 'b) Vegetables', 'c) Chips', 'd) Pastry'],
      'correctAnswer': 'b) Vegetables',
    },
    {
      'question': 'Which of the following is a good source of vitamins?',
      'options': ['a) Burger', 'b) Fruits', 'c) Chips', 'd) Candy'],
      'correctAnswer': 'b) Fruits',
    },
    {
      'question': 'Which of the following provides carbs and nutrients?',
      'options': ['a) Soda', 'b) Grains', 'c) Ice cream', 'd) Cookies'],
      'correctAnswer': 'b) Grains',
    },
    {
      'question': 'Which of the following is a good source of protein?',
      'options': ['a) Cake', 'b) Fish', 'c) French fries', 'd) Soda'],
      'correctAnswer': 'b) Fish',
    },
    {
      'question': 'Which of the following is a healthy drink?',
      'options': ['a) Juice', 'b) Soda', 'c) Milk', 'd) Sweet tea'],
      'correctAnswer': 'c) Milk',
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
      lastScore = _prefs.getInt('lastScore');
    });
  }

  _saveLastScore() async {
    await _prefs.setInt('lastScore', correctAnswersCount);
  }

  void checkAnswer(String selectedOption) {
    if (quizFinished || selectedAnswer != null) return;

    setState(() {
      selectedAnswer = selectedOption;
      if (selectedAnswer == questions[currentQuestionIndex]['correctAnswer']) {
        feedbackMessage = '🍎 You know your healthy foods! 👍';
        correctAnswersCount++;
      } else {
        feedbackMessage = '🍔 Hmm, not quite! Let\'s try again! 🤔';
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
          }
        });
      });
    });
  }

  String getResultMessage() {
    double percentage = correctAnswersCount / questions.length;
    if (percentage >= 0.8) {
      return '🥦 You have excellent healthy eating habits! Keep it up! 🌟';
    } else if (percentage >= 0.6) {
      return '🥕 Great job! You understand the basics of healthy eating! 😊';
    } else if (percentage >= 0.4) {
      return '🍇 Good effort! Let\'s learn more about making healthy choices! 👍';
    } else {
      return '🍕 Time to explore more nutritious and delicious options! 😄';
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
              colors: [Color(0xFF81C784), Color(0x00aed581)],
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
                border: Border.all(color: Colors.green, width: 3),
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
                        '⭐ First score: $firstScore / ${questions.length}',
                        style: const TextStyle(fontSize: 18.0, color: Colors.purple),
                      ),
                    ),
                  if (lastScore != null && lastScore != firstScore)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '✨ Previous score: $lastScore / ${questions.length}',
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
                        color: Colors.green),
                  ),
                  const SizedBox(height: 25.0),
                  ElevatedButton.icon(
                    onPressed: _resetQuiz,
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: const Text('Try Again! 🔄', style: TextStyle(fontSize: 18, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
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
                colors: [Color(0xFF81C784), Color(0x00c8e6c9)],
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
                  color: const Color(0x00e8f5e9),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.green, width: 3.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeInDown(
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Icon(Icons.restaurant, size: 40.0, color: Colors.green),
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
                                            : Colors.green,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 15.0),
                                textStyle: const TextStyle(fontSize: 18.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(option.replaceAll(RegExp(r'^[a-d]\) '), '')),
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
                              color: feedbackMessage == '🍎 You know your healthy foods! 👍'
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
              child: const Icon(Icons.restaurant, size: 50, color: Colors.greenAccent),
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: Spin(
              child: const Icon(Icons.fastfood, size: 40, color: Colors.orangeAccent),
            ),
          ),
        ],
      ),
    );
  }
}