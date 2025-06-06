import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';

void main() {
  runApp(const UnderstandingEmotionsQuizAppEn());
}

class UnderstandingEmotionsQuizAppEn extends StatelessWidget {
  const UnderstandingEmotionsQuizAppEn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz: Understanding Emotions',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Kufam',
      ),
      home: const QuizScreenEn(),
    );
  }
}

class QuizScreenEn extends StatefulWidget {
  const QuizScreenEn({super.key});

  @override
  State<QuizScreenEn> createState() => _QuizScreenEnState();
}

class _QuizScreenEnState extends State<QuizScreenEn> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> questions = [
    // True or False
    {
      'question': 'True or False: The baby in the video only shows one emotion.',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': 'True or False: The baby\'s facial expressions match the emotions shown in the emojis.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    {
      'question': 'True or False: It\'s impossible to understand a baby\'s emotions.',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': 'True or False: The baby\'s emotions are always consistent and unchanging.',
      'options': ['True', 'False'],
      'correctAnswer': 'False',
    },
    {
      'question': 'True or False: Understanding emotions is important for building good relationships.',
      'options': ['True', 'False'],
      'correctAnswer': 'True',
    },
    // Multiple Choice
    {
      'question': 'Which emotion does the baby express first?',
      'options': ['a) Anger', 'b) Happiness', 'c) Sadness', 'd) Surprise'],
      'correctAnswer': 'b) Happiness',
    },
    {
      'question': 'What is the baby doing when it shows anger?',
      'options': ['a) Smiling', 'b) Crying', 'c) Crossing its arms', 'd) Winking'],
      'correctAnswer': 'c) Crossing its arms',
    },
    {
      'question': 'Which emotion is shown with a sticking-out tongue?',
      'options': ['a) Love', 'b) Sadness', 'c) Playfulness', 'd) Disgust'],
      'correctAnswer': 'c) Playfulness',
    },
    {
      'question': 'What does the baby do to express love?',
      'options': ['a) Shouts', 'b) Shows its tongue', 'c) Makes a heart shape with its hands', 'd) Cries'],
      'correctAnswer': 'c) Makes a heart shape with its hands',
    },
    {
      'question': 'Which emotion is shown with closed eyes and a downturned mouth?',
      'options': ['a) Happiness', 'b) Surprise', 'c) Sadness', 'd) Anger'],
      'correctAnswer': 'c) Sadness',
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
        feedbackMessage = 'Great job! You understand emotions well! 👍';
        correctAnswersCount++;
      } else {
        feedbackMessage = 'Not quite! Let\'s try again! 🤔';
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
      return 'You\'re an emotions expert! Excellent! 🎉';
    } else if (percentage >= 0.6) {
      return 'Good work! Keep learning about emotions! 😊';
    } else if (percentage >= 0.4) {
      return 'Nice try! Let\'s explore emotions further! 👍';
    } else {
      return 'It\'s okay! Learning about emotions is fun! 😄';
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
        appBar: AppBar(title: const Text('Quiz Finished')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    style: const TextStyle(fontSize: 18.0, color: Colors.blueAccent),
                  ),
                ),
              const SizedBox(height: 15.0),
              Text(
                getResultMessage(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber),
              ),
              const SizedBox(height: 25.0),
              ElevatedButton.icon(
                onPressed: _resetQuiz,
                icon: const Icon(Icons.replay, color: Colors.white),
                label: const Text('Try Again! 🔄', style: TextStyle(fontSize: 18, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
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
      );
    }

    final currentQuestion = questions[currentQuestionIndex];
    final questionText = currentQuestion['question'] as String;
    final optionsList = currentQuestion['options'] as List<String>;
    final correctAnswer = currentQuestion['correctAnswer'] as String;

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz: Understanding Emotions')),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 234, 210, 128), Color.fromARGB(255, 255, 253, 248)],
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
                  // ignore: deprecated_member_use
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.amber, width: 3.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeInDown(
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Icon(Icons.mood, size: 40.0, color: Colors.amber),
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
                                            : Colors.amber,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 15.0),
                                textStyle: const TextStyle(fontSize: 18.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(option)),
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
                              color: feedbackMessage == 'Great job! You understand emotions well! 👍'
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
              child: const Icon(Icons.mood, size: 50, color: Colors.amberAccent),
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: Spin(
              child: const Icon(Icons.face, size: 40, color: Colors.orangeAccent),
            ),
          ),
        ],
      ),
    );
  }
}