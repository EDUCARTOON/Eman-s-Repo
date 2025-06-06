import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';

void main() {
  runApp(const CaringForAnimalsQuizApp());
}

class CaringForAnimalsQuizApp extends StatelessWidget {
  const CaringForAnimalsQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caring for Animals Quiz',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Kufam', // Choose a clear font
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
      'question': 'It\'s okay to give a cat cookies as a treat.',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': 'Cats need a lot of love and attention.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': 'You should always wash your hands after handling animals.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question':
          'It\'s fine to leave a cat alone all day without food or water.',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': 'Cats enjoy being petted gently.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    // Part 2: Multiple Choice
    {
      'question': 'What is the best food for a cat?',
      'options': ['Cookies', 'Chocolate', 'Cat food', 'Pizza'],
      'correctAnswer': 'Cat food',
    },
    {
      'question': 'What should you do if a cat seems sick?',
      'options': [
        'Ignore it',
        'Tell an adult',
        'Give it medicine',
        'Give it more cookies'
      ],
      'correctAnswer': 'Tell an adult',
    },
    {
      'question': 'What is a good way to show a cat you care?',
      'options': [
        'Yelling at it',
        'Ignoring it',
        'Giving it gentle pets and attention',
        'Pulling its tail'
      ],
      'correctAnswer': 'Giving it gentle pets and attention',
    },
    {
      'question': 'Where should a cat\'s food and water be kept?',
      'options': [
        'On the floor',
        'In a clean bowl',
        'In a dirty bowl',
        'In a box'
      ],
      'correctAnswer': 'In a clean bowl',
    },
    {
      'question': 'What should you NOT do to a cat?',
      'options': [
        'Pet it gently',
        'Talk to it softly',
        'Hurt it or scare it',
        'Give it fresh water'
      ],
      'correctAnswer': 'Hurt it or scare it',
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
        feedbackMessage = '✨ Correct! 👍';
        correctAnswersCount++;
      } else {
        feedbackMessage = '😔 Try again! 🤔';
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
      return '🐾 You\'re a great animal carer! 🌟';
    } else if (percentage >= 0.6) {
      return '💖 Wonderful! You care about animals! 😊';
    } else if (percentage >= 0.4) {
      return '🌱 Good effort! Let\'s learn more about caring for animals! 💪';
    } else {
      return '📚 Every creature deserves our kindness! Let\'s learn how to care for them! 😄';
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
              colors: [Color(0xFF80CBC4), Color(0xFF26A69A)],
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
                border: Border.all(color: Colors.tealAccent, width: 3),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ZoomIn(
                    child: const Text(
                      '🐾 Quiz Finished! 🐾',
                      style: TextStyle(
                          fontSize: 26.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Your Score: $correctAnswersCount / ${questions.length}',
                    style: const TextStyle(fontSize: 22.0),
                  ),
                  if (firstScore != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '⭐ First Score: $firstScore / ${questions.length}',
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.purple),
                      ),
                    ),
                  if (lastScore != null && lastScore != firstScore)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '✨ Previous Score: $lastScore / ${questions.length}',
                        style:
                            const TextStyle(fontSize: 18.0, color: Colors.blue),
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
                    label: const Text('🔁 Try Again!',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
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
                colors: [Color(0xFF80CBC4), Color(0xFFE0F2F1)],
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
                  color: const Color(0xFFE0F7FA),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.teal, width: 3.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeInDown(
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Icon(Icons.pets, size: 40.0),
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
                                backgroundColor: option == correctAnswer &&
                                        selectedAnswer == option
                                    ? Colors.greenAccent
                                    : (selectedAnswer == option &&
                                            option != correctAnswer)
                                        ? Colors.redAccent
                                        : Colors.tealAccent,
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
                              color: feedbackMessage == '✨ Correct! 👍'
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
                        style:
                            const TextStyle(fontSize: 16.0, color: Colors.grey),
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
              child: const Icon(Icons.heart_broken,
                  size: 50, color: Colors.tealAccent),
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: Spin(
              child:
                  const Icon(Icons.healing, size: 40, color: Colors.tealAccent),
            ),
          ),
        ],
      ),
    );
  }
}
