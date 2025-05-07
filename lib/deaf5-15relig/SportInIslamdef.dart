import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/app_constant.dart';
import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:flutter_application_3/core/services/firebase_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart'; // إضافة مكتبة الرسوم المتحركة

void main() {
  runApp(const SportInIslamdef());
}

class SportInIslamdef extends StatelessWidget {
  const SportInIslamdef({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'كويز الرياضة في الإسلام',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Cairo',
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
      'question': 'صح/خطأ: يُشجع الإسلام على ممارسة الرياضة للحفاظ على الصحة.',
      'options': ['صح', 'غلط'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'صح/خطأ: الاشتراك في نادي الفروسية مجاني تمامًا.',
      'options': ['صح', 'غلط'],
      'correctAnswer': 'غلط',
    },
    {
      'question': 'صح/خطأ: يُظهر الفيديو أهمية العناية بالجسد من خلال الغذاء الصحي وممارسة الرياضة.',
      'options': ['صح', 'غلط'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'صح/خطأ: لم يذكر الفيديو أي رياضات محددة.',
      'options': ['صح', 'غلط'],
      'correctAnswer': 'غلط',
    },
    {
      'question': 'ما الذي حدث للدراجة إذا أهملتها وتركتها دون استخدام؟',
      'options': ['لم يحدث شيء.', 'العجلات تعطلت، والدراجة صدأت.', 'أصبحت الدراجة أسرع.', 'لا شيء مما سبق.'],
      'correctAnswer': 'العجلات تعطلت، والدراجة صدأت.',
    },
    {
      'question': 'ماذا يمثل ممارسة الرياضة في هذا الفيديو؟',
      'options': ['مضيعة للوقت.', 'عمل عبادة يُثاب عليه.', 'شيء غير مهم.', 'لا شيء مما سبق.'],
      'correctAnswer': 'عمل عبادة يُثاب عليه.',
    },
    {
      'question': 'ما هي بعض الرياضات التي يُشجع عليها الإسلام والتي ذُكرت في الفيديو؟',
      'options': ['كرة القدم، السلة، التنس.', 'الرمي، السباحة، ركوب الخيل.', 'الجري، القفز، الركض.', 'لا شيء مما سبق.'],
      'correctAnswer': 'الرمي، السباحة، ركوب الخيل.',
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
      lastScore = _prefs.getInt('sportIslamLastScore');
    });
  }

  _saveLastScore() async {
    await _prefs.setInt('sportIslamLastScore', correctAnswersCount);
  }

  void checkAnswer(String selectedOption) {
    if (quizFinished || selectedAnswer != null) return;

    setState(() {
      selectedAnswer = selectedOption;
      if (selectedAnswer == questions[currentQuestionIndex]['correctAnswer']) {
        feedbackMessage = '✨ إجابة صحيحة! ✨';
        correctAnswersCount++;
      } else {
        feedbackMessage = '😔 إجابة خاطئة.';
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
            FirebaseFile.addResult(email!, "Religion", "5-15", '$firstScore', 'كويز الرياضة في الإسلام');// حفظ النتيجة عند انتهاء الاختبار
          }
        });
      });
    });
  }

  String getResultMessage() {
    double percentage = correctAnswersCount / questions.length;
    if (percentage >= 0.8) {
      return '🎉 بطل! حافظ على نشاطك وصحتك! 🎉';
    } else if (percentage >= 0.6) {
      return '👏 ممتاز! الرياضة مهمة في حياتنا! 🌟';
    } else if (percentage >= 0.4) {
      return '👍 جيد! استمر في التعلم عن أهمية الرياضة! 👍';
    } else {
      return '💪 لا تستسلم! حاول مرة أخرى لتكون أكثر معرفة! 💪';
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
                        '🎯 أول نتيجة حصلت عليها: $firstScore / ${questions.length}',
                        style: const TextStyle(fontSize: 18.0, color: Colors.purple),
                      ),
                    ),
                  if (lastScore != null && lastScore != firstScore)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '⭐ آخر نتيجة سابقة: $lastScore / ${questions.length}',
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
                    label: const Text('🔁 إعادة الاختبار', style: TextStyle(fontSize: 18, color: Colors.white)),
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
                          '🏃', // رمز تعبيري للرياضة
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
                              color: feedbackMessage == '✨ إجابة صحيحة! ✨'
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