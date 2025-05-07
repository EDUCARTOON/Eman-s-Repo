import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';

import '../core/app_shared_variables.dart';
import '../core/services/firebase_services.dart';

void main() {
  runApp(const Shape());
}

class Shape extends StatelessWidget {
  const Shape({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shapes Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
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
      'question': 'يُظهر الفيديو شكلًا دائريًا.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'يُظهر الفيديو شكلًا بيضاويًا.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'خطأ',
    },
    {
      'question': 'يُظهر الفيديو شكلًا مثلثًا.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'يُظهر الفيديو شكلًا مربعًا.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'يُظهر الفيديو شكلًا مستطيلًا.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'يُظهر الفيديو شكلًا مكعبًا.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'يُظهر الفيديو شكلًا اسطوانيًا.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'يُظهر الفيديو شكلًا هرميًا.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'أيّ من الأشكال التالية له ثلاث زوايا؟',
      'options': ['المربع', 'الدائرة', 'المثلث', 'المستطيل'],
      'correctAnswer': 'المثلث',
    },
    {
      'question': 'أيّ من الأشكال التالية له أربعة جوانب متساوية؟',
      'options': ['المربع', 'المستطيل', 'المثلث', 'الهرم'],
      'correctAnswer': 'المربع',
    },
    {
      'question': 'أيّ من الأشكال التالية ليس له زوايا؟',
      'options': ['المربع', 'المستطيل', 'المثلث', 'الدائرة'],
      'correctAnswer': 'الدائرة',
    },
    {
      'question': 'أيّ من الأشكال التالية يشبه شكل علبة الكبريت؟',
      'options': ['الاسطوانة', 'المكعب', 'الهرم', 'المثلث'],
      'correctAnswer': 'المكعب',
    },
    {
      'question': 'أيّ من الأشكال التالية يشبه شكل البالون؟',
      'options': ['المربع', 'المستطيل', 'المثلث', 'الدائرة'],
      'correctAnswer': 'الدائرة',
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
        feedbackMessage = '✨ أحسنت! ✅';
        correctAnswersCount++;
      } else {
        feedbackMessage = '😔 حاول مرة أخرى! ✏️';
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
            firstScore ??= correctAnswersCount;
            quizFinished = true;
            _saveLastScore();
            FirebaseFile.addResult(email!, "Education", "5-15", '$firstScore', 'Shapes Quiz');// حفظ النتيجة عند انتهاء الاختبار

          }
        });
      });
    });
  }

  String getResultMessage() {
    double percentage = correctAnswersCount / questions.length;
    if (percentage >= 0.8) {
      return '🎉 أنت بطل الأشكال! 💯';
    } else if (percentage >= 0.6) {
      return '👏 معرفة ممتازة بالأشكال! 📐';
    } else if (percentage >= 0.4) {
      return '👍 عمل جيد مع الأشكال! 👍';
    } else {
      return '📝 استمر في تعلم الأشكال! 🚀';
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
              colors: [Color(0xFFFFDAB9), Color(0xFFFFE4B5)],
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
                      '🎊 انتهى الاختبار! 🎊',
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
                        '🎯 نتيجتك الأولى في اختبار الأشكال: $firstScore / ${questions.length}',
                        style: const TextStyle(fontSize: 18.0, color: Colors.purple),
                      ),
                    ),
                  if (lastScore != null && lastScore != firstScore)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '⭐ نتيجتك السابقة في اختبار الأشكال: $lastScore / ${questions.length}',
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
                    label: const Text('🔁 حاول مرة أخرى!', style: TextStyle(fontSize: 18, color: Colors.white)),
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
                colors: [Color(0xFFFFDAB9), Color(0xFFF0FFF0)],
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
                  border: Border.all(color: Colors.blue, width: 3.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeInDown(
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          '📐',
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
                              color: feedbackMessage == '✨ أحسنت! ✅'
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
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
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
                  color: Colors.deepPurpleAccent,
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