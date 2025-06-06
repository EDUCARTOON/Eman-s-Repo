import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';

void main() {
  runApp(const GodSeesUsQuizApp());
}

class GodSeesUsQuizApp extends StatelessWidget {
  const GodSeesUsQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبار: الله يرانا',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Amiri',
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
    // صح أم خطأ
    {
      'question': 'صح أم خطأ: أعطت المعلمة كل طفل تفاحة ليأكلها في مكان لا يراه أحد فيه.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'صح أم خطأ: أكل تامر التفاحة على سطح المنزل مع أصدقائه.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'خطأ',
    },
    {
      'question': 'صح أم خطأ: أكل أحمد التفاحة في الصحراء مع عائلته.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'خطأ',
    },
    {
      'question': 'صح أم خطأ: أكل خالد التفاحة في حديقته مع أصدقائه.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'خطأ',
    },
    {
      'question': 'صح أم خطأ: لم يجد مالك مكانًا لا يراه الله فيه.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    // اختر الإجابة الصحيحة
    {
      'question': 'أين أكل تامر التفاحة؟',
      'options': ['أ. في المدرسة.', 'ب. فوق سطح المنزل.', 'ج. في الصحراء.', 'د. في الحديقة.'],
      'correctAnswer': 'ب. فوق سطح المنزل.',
    },
    {
      'question': 'أين أكل أحمد التفاحة؟',
      'options': ['أ. في المدرسة.', 'ب. فوق سطح المنزل.', 'ج. في الصحراء.', 'د. في الحديقة.'],
      'correctAnswer': 'ج. في الصحراء.',
    },
    {
      'question': 'أين أكل خالد التفاحة؟',
      'options': ['أ. في المدرسة.', 'ب. فوق سطح المنزل.', 'ج. في الصحراء.', 'د. في الحديقة.'],
      'correctAnswer': 'د. في الحديقة.',
    },
    {
      'question': 'ماذا قال مالك بعد أن أكل التفاحة؟',
      'options': ['أ. الله لا يرانا.', 'ب. الله يرانا في كل مكان.', 'ج. أنا لا أرى الله.', 'د. أين أكلت التفاحة؟'],
      'correctAnswer': 'ب. الله يرانا في كل مكان.',
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
        feedbackMessage = 'أحسنت! 👍';
        correctAnswersCount++;
      } else {
        feedbackMessage = 'حاول مرة أخرى! 🤔';
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
      return 'ما شاء الله! إجابات ممتازة! ✨';
    } else if (percentage >= 0.6) {
      return 'عمل جيد! استمر هكذا! 😊';
    } else if (percentage >= 0.4) {
      return 'محاولة طيبة! لنتعلم أكثر! 👍';
    } else {
      return 'لا بأس، حاول مرة أخرى وستتحسن! 😄';
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
        appBar: AppBar(title: const Text('انتهى الاختبار')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ZoomIn(
                child: const Text(
                  '🎉 انتهى الاختبار! 🎉',
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'نتيجتك: $correctAnswersCount / ${questions.length}',
                style: const TextStyle(fontSize: 22.0),
              ),
              if (firstScore != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '⭐ نتيجتك الأولى: $firstScore / ${questions.length}',
                    style: const TextStyle(fontSize: 18.0, color: Colors.purple),
                  ),
                ),
              if (lastScore != null && lastScore != firstScore)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '✨ نتيجتك السابقة: $lastScore / ${questions.length}',
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
                    color: Colors.teal),
              ),
              const SizedBox(height: 25.0),
              ElevatedButton.icon(
                onPressed: _resetQuiz,
                icon: const Icon(Icons.replay, color: Colors.white),
                label: const Text('إعادة الاختبار 🔄', style: TextStyle(fontSize: 18, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
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
      appBar: AppBar(title: const Text('اختبار: الله يرانا')),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade300, Colors.teal.shade100],
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
                  border: Border.all(color: Colors.teal, width: 3.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeInDown(
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Icon(Icons.visibility, size: 40.0, color: Colors.teal),
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
                                            : Colors.teal,
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
                              color: feedbackMessage == 'أحسنت! 👍'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        'السؤال ${currentQuestionIndex + 1} / ${questions.length}',
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
              child: const Icon(Icons.visibility, size: 50, color: Colors.tealAccent),
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: Spin(
              child: const Icon(Icons.lightbulb_outline, size: 40, color: Colors.yellowAccent),
            ),
          ),
        ],
      ),
    );
  }
}