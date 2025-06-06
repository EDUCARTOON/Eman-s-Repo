import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';

void main() {
  runApp(const Technologytool());
}

class Technologytool extends StatelessWidget {
  const Technologytool({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Technology Tools Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Kufam', // You can choose a clear font
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
    // True or False
    {
      'question': 'A computer is a machine used for many things, including browsing the internet, working, and playing video games.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': 'A monitor is used to listen to music and sounds.',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': 'A mouse is used to select items and move the cursor on the screen.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': 'A keyboard is used to type letters and numbers.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': 'Speakers are used to see each other on the screen during video calls.',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': 'A webcam is used to record our voice so others can hear us during video calls.',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': 'A microphone is used to see each other on the screen during video calls.',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': 'A laptop is a computer you can take anywhere.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': 'A printer is used to put text and images from the computer onto paper.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': 'A scanner is used to put text and images from paper onto the computer.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': 'A flash drive is also called a pen drive.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    // Multiple Choice
    {
      'question': 'Which of these is used to type?',
      'options': ['Mouse', 'Monitor', 'Keyboard', 'Printer'],
      'correctAnswer': 'Keyboard',
    },
    {
      'question': 'Which of these is used to see each other during video calls?',
      'options': ['Microphone', 'Speakers', 'Webcam', 'Flash drive'],
      'correctAnswer': 'Webcam',
    },
    {
      'question': 'Which of these is used to listen to music?',
      'options': ['Mouse', 'Monitor', 'Keyboard', 'Speakers'],
      'correctAnswer': 'Speakers',
    },
    {
      'question': 'Which of these is used to save files and copy them from one computer to another?',
      'options': ['Printer', 'Scanner', 'Flash drive', 'Webcam'],
      'correctAnswer': 'Flash drive',
    },
    {
      'question': 'Which of these is used to put documents and images from paper to the computer?',
      'options': ['Printer', 'Scanner', 'Flash drive', 'Microphone'],
      'correctAnswer': 'Scanner',
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
      return '🎉 Excellent! You know your tech tools! 🥳';
    } else if (percentage >= 0.6) {
      return '👏 Very good! Keep learning! 😊';
    } else if (percentage >= 0.4) {
      return '👍 Good try! Practice more! 💪';
    } else {
      return '📚 Let\'s learn more about tech tools! 😄';
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
              colors: [Color(0xFF64B5F6), Color(0xFF1E88E5)],
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
                border: Border.all(color: Colors.blueAccent, width: 3),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ZoomIn(
                    child: const Text(
                      '🎊 Quiz Finished! 🎊',
                      style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
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
                        style: const TextStyle(fontSize: 18.0, color: Colors.purple),
                      ),
                    ),
                  if (lastScore != null && lastScore != firstScore)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '✨ Previous Score: $lastScore / ${questions.length}',
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
                        color: Colors.blue),
                  ),
                  const SizedBox(height: 25.0),
                  ElevatedButton.icon(
                    onPressed: _resetQuiz,
                    icon: const Icon(Icons.replay, color: Colors.white),
                    label: const Text('🔁 Try Again!', style: TextStyle(fontSize: 18, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
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
                colors: [Color(0xFF64B5F6), Color(0xFFE3F2FD)],
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
                  color: const Color(0xFFE1F5FE),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.blue, width: 3.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeInDown(
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Icon(Icons.computer, size: 40.0),
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
                                            : Colors.lightBlueAccent,
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
              child: const Icon(Icons.accessibility_new, size: 50, color: Colors.blueAccent),
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: Spin(
              child: const Icon(Icons.settings, size: 40, color: Colors.lightBlueAccent),
            ),
          ),
        ],
      ),
    );
  }
}