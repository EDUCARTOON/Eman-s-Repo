import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';
import '../core/app_shared_variables.dart';
import '../core/services/firebase_services.dart';
class BuildingtheKaabal extends StatefulWidget {
  const BuildingtheKaabal({super.key});

  @override
  State<BuildingtheKaabal> createState() => _KaabaBuildingQuizScreenState();
}

class _KaabaBuildingQuizScreenState extends State<BuildingtheKaabal> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> kaabaBuildingQuestions = [
    {
      'question': 'صواب أم خطأ: بدأ إبراهيم بناء الكعبة بمفرده.',
      'options': ['صواب', 'خطأ'],
      'correctAnswer': 'خطأ',
    },
    {
      'question': 'صواب أم خطأ: ساعد إسماعيل والده إبراهيم في بناء الكعبة.',
      'options': ['صواب', 'خطأ'],
      'correctAnswer': 'صواب',
    },
    {
      'question': 'صواب أم خطأ: استخدم إبراهيم وإسماعيل الحجارة فقط لبناء الكعبة.',
      'options': ['صواب', 'خطأ'],
      'correctAnswer': 'خطأ',
    },
    {
      'question': 'صواب أم خطأ: وضع جبريل عليه السلام الحجر الأسود في مكانه في الكعبة.',
      'options': ['صواب', 'خطأ'],
      'correctAnswer': 'صواب',
    },
    {
      'question': 'صواب أم خطأ: بنيت الكعبة من مادة واحدة فقط.',
      'options': ['صواب', 'خطأ'],
      'correctAnswer': 'خطأ',
    },
    {
      'question': 'صواب أم خطأ: أمر الله إبراهيم ببناء الكعبة على التوحيد.',
      'options': ['صواب', 'خطأ'],
      'correctAnswer': 'صواب',
    },
    {
      'question': 'صواب أم خطأ: هاجر هي أم إسماعيل.',
      'options': ['صواب', 'خطأ'],
      'correctAnswer': 'صواب',
    },
    {
      'question': 'صواب أم خطأ: سكنت قبيلة جرهم مع إبراهيم و إسماعيل بعد بناء الكعبة.',
      'options': ['صواب', 'خطأ'],
      'correctAnswer': 'صواب',
    },
    {
      'question': 'من ساعد إبراهيم في بناء الكعبة؟',
      'options': ['هاجر', 'إسماعيل', 'جبريل', 'جميع ما سبق (ب و ج)'],
      'correctAnswer': 'إسماعيل',
    },
    {
      'question': 'من أي مادة صنع الحجر الأسود؟',
      'options': ['الحجر', 'الخشب', 'الذهب', 'لا يُعرف'],
      'correctAnswer': 'الحجر',
    },
    {
      'question': 'ما هو اسم المكان الذي أمر الله إبراهيم ببناء الكعبة فيه؟',
      'options': ['مكة', 'المدينة', 'القدس', 'لا يُعرف'],
      'correctAnswer': 'مكة',
    },
    {
      'question': 'ما الذي طلبه إبراهيم من الله بعد الانتهاء من بناء الكعبة؟',
      'options': ['الثروة', 'السلطة', 'أن يبلغ دعوته الناس بالحج', 'الصحة'],
      'correctAnswer': 'أن يبلغ دعوته الناس بالحج',
    },
    {
      'question': 'من أي مكان نزل جبريل عليه السلام بالحجر الأسود؟',
      'options': ['من الأرض', 'من السماء', 'من البحر', 'لا يُعرف'],
      'correctAnswer': 'من السماء',
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
      lastScore = _prefs.getInt('kaabaQuizLastScore');
    });
  }

  _saveLastScore() async {
    await _prefs.setInt('kaabaQuizLastScore', correctAnswersCount);
  }

  void checkAnswer(String selectedOption) {
    if (quizFinished || selectedAnswer != null) return;

    setState(() {
      selectedAnswer = selectedOption;
      if (selectedAnswer == kaabaBuildingQuestions[currentQuestionIndex]['correctAnswer']) {
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
          if (currentQuestionIndex < kaabaBuildingQuestions.length - 1) {
            currentQuestionIndex++;
          } else {
            // ignore: prefer_conditional_assignment
            if (firstScore == null) {
              firstScore = correctAnswersCount;
            }
            quizFinished = true;
            _saveLastScore();
            FirebaseFile.addResult(email!, "Religion", "8-12", '$firstScore', 'بناء الكعبه');// حفظ النتيجة عند انتهاء الاختبار

          }
        });
      });
    });
  }

  String getResultMessage() {
    double percentage = correctAnswersCount / kaabaBuildingQuestions.length;
    if (percentage >= 0.8) {
      return '🎉 أنت بطل بناء الكعبة! 🕋';
    } else if (percentage >= 0.6) {
      return '👏 معرفة ممتازة ببناء الكعبة! 🧱';
    } else if (percentage >= 0.4) {
      return '👍 عمل جيد في معرفة بناء الكعبة! 👍';
    } else {
      return '📝 استمر في تعلم قصة بناء الكعبة! ✨';
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
        appBar: AppBar(
          automaticallyImplyLeading: false, // إزالة سهم الرجوع
          title: const Text(''), // إزالة العنوان
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFF3E0), Color(0xFFFBE9E7)],
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
                    'نتيجتك: $correctAnswersCount / ${kaabaBuildingQuestions.length}',
                    style: const TextStyle(fontSize: 22.0),
                  ),
                  if (firstScore != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '🎯 نتيجتك الأولى: $firstScore / ${kaabaBuildingQuestions.length}',
                        style: const TextStyle(fontSize: 18.0, color: Colors.purple),
                      ),
                    ),
                  if (lastScore != null && lastScore != firstScore)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '⭐ نتيجتك السابقة: $lastScore / ${kaabaBuildingQuestions.length}',
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
                        color: Colors.orange),
                  ),
                  const SizedBox(height: 25.0),
                  ElevatedButton.icon(
                    onPressed: _resetQuiz,
                    icon: const Icon(Icons.replay, color: Colors.white),
                    label: const Text('🔁 حاول مرة أخرى!', style: TextStyle(fontSize: 18, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('العودة إلى اختيار الاختبار'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final currentQuestion = kaabaBuildingQuestions[currentQuestionIndex];
    final questionText = currentQuestion['question'] as String;
    final optionsList = currentQuestion['options'] as List<String>;
    final correctAnswer = currentQuestion['correctAnswer'] as String;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // إزالة سهم الرجوع
        title: const Text(''), // إزالة العنوان
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFE0B2), Color(0xFFF57F17)],
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
                  color: const Color(0xFFFFCC80),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.orange, width: 3.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeInDown(
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          '🕋',
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
                                            : Colors.orangeAccent,
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
                        'السؤال ${currentQuestionIndex + 1} / ${kaabaBuildingQuestions.length}',
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
                  color: Colors.orangeAccent,
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
                  color: Colors.deepOrangeAccent,
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