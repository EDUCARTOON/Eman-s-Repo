import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';
import '../core/app_shared_variables.dart';
import '../core/services/firebase_services.dart';
void main() {
  runApp(const HijriMonthsl());
}

class HijriMonthsl extends StatelessWidget {
  const HijriMonthsl({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبار الشهور الهجرية',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Readex Pro',
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
      'question': 'صحيح/خطأ: شهر محرم هو أول الشهور الهجرية.',
      'options': ['صحيح', 'خطأ'],
      'correctAnswer': 'صحيح',
    },
    {
      'question': 'صحيح/خطأ: يُسمى شهر صفر بـ "شهر الحزن".',
      'options': ['صحيح', 'خطأ'],
      'correctAnswer': 'خطأ',
    },
    {
      'question': 'صحيح/خطأ: وُلد النبي محمد ﷺ في شهر ربيع الأول.',
      'options': ['صحيح', 'خطأ'],
      'correctAnswer': 'صحيح',
    },
    {
      'question': 'صحيح/خطأ: شهر ربيع الثاني هو شهرٌ مبارك.',
      'options': ['صحيح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'صحيح/خطأ: شهر جمادى الأولى هو الشهر الخامس في السنة الهجرية.',
      'options': ['صحيح', 'خطأ'],
      'correctAnswer': 'صحيح',
    },
    {
      'question': 'صحيح/خطأ: شهر جمادى الثانية هو الشهر السادس في السنة الهجرية.',
      'options': ['صحيح', 'خطأ'],
      'correctAnswer': 'صحيح',
    },
    {
      'question': 'صحيح/خطأ: شهر شعبان هو شهرٌ من أشهر الحج.',
      'options': ['صحيح', 'خطأ'],
      'correctAnswer': 'خطأ',
    },
    {
      'question': 'صحيح/خطأ: شهر رمضان هو شهر الصيام والاحسان.',
      'options': ['صحيح', 'خطأ'],
      'correctAnswer': 'صحيح',
    },
    {
      'question': 'صحيح/خطأ: شهر شوال هو الشهر العاشر في السنة الهجرية.',
      'options': ['صحيح', 'خطأ'],
      'correctAnswer': 'صحيح',
    },
    {
      'question': 'صحيح/خطأ: يُحتفل بعيد الفطر في شهر شوال.',
      'options': ['صحيح', 'خطأ'],
      'correctAnswer': 'صحيح',
    },
    {
      'question': 'صحيح/خطأ: شهر ذو القعدة هو الشهر الحادي عشر في السنة الهجرية.',
      'options': ['صحيح', 'خطأ'],
      'correctAnswer': 'صحيح',
    },
    {
      'question': 'صحيح/خطأ: شهر ذو الحجة هو الشهر الثاني عشر في السنة الهجرية.',
      'options': ['صحيح', 'خطأ'],
      'correctAnswer': 'صحيح',
    },
    {
      'question': 'صحيح/خطأ: يُقام الحج في شهر ذو الحجة.',
      'options': ['صحيح', 'خطأ'],
      'correctAnswer': 'صحيح',
    },
    {
      'question': 'صحيح/خطأ: يُحتفل بعيد الأضحى في شهر ذو الحجة.',
      'options': ['صحيح', 'خطأ'],
      'correctAnswer': 'صحيح',
    },
    {
      'question': 'أي شهر هو شهر الصيام؟',
      'options': ['محرم', 'صفر', 'رمضان', 'شوال'],
      'correctAnswer': 'رمضان',
    },
    {
      'question': 'في أي شهر وُلد النبي محمد ﷺ؟',
      'options': ['ربيع الأول', 'ربيع الثاني', 'جمادى الأولى', 'جمادى الثانية'],
      'correctAnswer': 'ربيع الأول',
    },
    {
      'question': 'أي شهر يُحتفل فيه بعيد الفطر؟',
      'options': ['رمضان', 'شوال', 'ذو القعدة', 'ذو الحجة'],
      'correctAnswer': 'شوال',
    },
    {
      'question': 'أي شهر يُقام فيه الحج؟',
      'options': ['ذو القعدة', 'ذو الحجة', 'محرم', 'صفر'],
      'correctAnswer': 'ذو الحجة',
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
            // ignore: prefer_conditional_assignment
            if (firstScore == null) {
              firstScore = correctAnswersCount;
            }
            quizFinished = true;
            _saveLastScore();
            FirebaseFile.addResult(email!, "Religion", "8-12", '$firstScore', 'اختبار الشهور الهجرية');// حفظ النتيجة عند انتهاء الاختبار

          }
        });
      });
    });
  }

  String getResultMessage() {
    double percentage = correctAnswersCount / questions.length;
    if (percentage >= 0.8) {
      return '🎉 أنت بطل الشهور الهجرية! 💯';
    } else if (percentage >= 0.6) {
      return '👏 معرفة ممتازة بالشهور الهجرية! 🌙';
    } else if (percentage >= 0.4) {
      return '👍 عمل جيد في معرفة الشهور الهجرية! 👍';
    } else {
      return '📝 استمر في تعلم الشهور الهجرية! 🚀';
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
              colors: [Color(0xFFDCEDC8), Color(0x00c8e6c9)],
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
                border: Border.all(color: Colors.greenAccent, width: 3),
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
                        '🎯 نتيجتك الأولى في اختبار الشهور الهجرية: $firstScore / ${questions.length}',
                        style: const TextStyle(fontSize: 18.0, color: Colors.purple),
                      ),
                    ),
                  if (lastScore != null && lastScore != firstScore)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '⭐ نتيجتك السابقة في اختبار الشهور الهجرية: $lastScore / ${questions.length}',
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
                colors: [Color(0xFFF1F8E9), Color(0x00e8f5e9)],
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
                  color: const Color(0xFFFFF9C4),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.green, width: 3.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeInDown(
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          '🌙',
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
                                            : Colors.lightGreenAccent,
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
                  color: Colors.greenAccent,
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
                  color: Colors.lightGreen,
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