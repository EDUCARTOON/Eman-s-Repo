import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';

void main() {
  runApp(const PillarsofIslam());
}

class PillarsofIslam extends StatelessWidget {
  const PillarsofIslam({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبار أركان الإسلام',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Kufam', // يمكنك اختيار خط عربي مناسب
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
    // الركن الأول: الشهادة
    {
      'question': 'مين ربنا اللي خلقنا وبيحبنا؟',
      'options': ['التلفزيون', 'الله', 'المدرسه'],
      'correctAnswer': 'الله',
    },
    {
      'question': 'مين نبي الإسلام اللي بنحبه كتير؟',
      'options': ['موسي', 'محمد', 'عيسي'],
      'correctAnswer': 'محمد',
    },
    {
      'question': 'لما نقول: "لا إله إلا الله محمد رسول الله"، إحنا بنقول إيه؟',
      'options': ['نحب المدرسه', 'نحب الاكل', 'نؤمن بالله ونحب نبينا محمد'],
      'correctAnswer': 'نؤمن بالله ونحب نبينا محمد',
    },
    // الركن الثاني: الصلاة
    {
      'question': 'إحنا بنصلي كم مرة في اليوم؟',
      'options': ['ثلاث مرات', 'مرتين', 'خمس مرات'],
      'correctAnswer': 'خمس مرات',
    },
    {
      'question': 'لما نصلي، بنحكي مع مين؟',
      'options': ['اصدقائنا', 'المدرسه', 'الله'],
      'correctAnswer': 'الله',
    },
    {
      'question': 'إحنا بنصلي على سجادة ولا على سرير؟😄',
      'options': ['علي السرير', 'علي السجاده', 'علي الكنبه'],
      'correctAnswer': 'علي السجاده',
    },
    {
      'question': 'بنصلي خمس مرات في اليوم؟',
      'options': ['صح', 'غلط'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'لما نصلي، نحكي مع التلفزيون؟',
      'options': ['صح', 'غلط'],
      'correctAnswer': 'غلط',
    },
    // الركن الثالث: الزكاة
    {
      'question': 'لو عندي لعبتين وصاحبي ما عنده ولا لعبة، أعمل إيه؟',
      'options': ['اعطيه لعبه', 'احتفظ بلعبتي', 'اخبيها'],
      'correctAnswer': 'اعطيه لعبه',
    },
    {
      'question': 'ليه بنعطي الفقراء؟',
      'options': ['علشان نحب بعض ونساعد', 'علشان نلعب', 'علشان نضحك'],
      'correctAnswer': 'علشان نحب بعض ونساعد',
    },
    {
      'question': 'لازم نساعد الفقراء؟',
      'options': ['صح', 'غلط'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'نخلي كل الألعاب لأنفسنا؟',
      'options': ['صح', 'غلط'],
      'correctAnswer': 'غلط',
    },
    // الركن الرابع: الصوم
    {
      'question': 'في رمضان، إحنا بنصوم عن الأكل والشرب من إمتى؟',
      'options': ['من العصر للمغرب', 'من الفجر للمغرب', 'من الليل للنهار'],
      'correctAnswer': 'من الفجر للمغرب',
    },
    {
      'question': 'لما نصوم، نحاول نكون إزاي؟',
      'options': ['طيبين وصبورين', 'نغضب ونزعّل الناس', 'نضرب إخوتنا'],
      'correctAnswer': 'طيبين وصبورين',
    },
    {
      'question': 'في رمضان ناكل كتير طول اليوم؟',
      'options': ['صح', 'غلط'],
      'correctAnswer': 'غلط',
    },
    {
      'question': 'لازم نكون طيبين وقت الصيام؟',
      'options': ['صح', 'غلط'],
      'correctAnswer': 'صح',
    },
    // الركن الخامس: الحج
    {
      'question': 'الناس بيروحوا فين لما يروحوا الحج؟',
      'options': ['المدينة', 'مكة', 'الرياض'],
      'correctAnswer': 'مكة',
    },
    {
      'question': 'ليه الناس بيلبسوا لبس أبيض في الحج؟',
      'options': ['علشان يلعبوا', 'علشان يكونوا زي بعض', 'علشان يكونوا مشهورين'],
      'correctAnswer': 'علشان يكونوا زي بعض',
    },
    {
      'question': 'في الحج كل الناس بيلبسوا لبس مختلف؟',
      'options': ['صح', 'غلط'],
      'correctAnswer': 'غلط',
    },
    {
      'question': 'بيروحوا مكة في الحج؟',
      'options': ['صح', 'غلط'],
      'correctAnswer': 'صح',
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
        feedbackMessage = '✨ إجابة صحيحة! 👍';
        correctAnswersCount++;
      } else {
        feedbackMessage = '😔 حاول مرة أخرى! 🤔';
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
      return '🎉 ممتاز! أنت تعرف أركان الإسلام جيدًا! 🥳';
    } else if (percentage >= 0.6) {
      return '👏 جيد جدًا! استمر في التعلم! 😊';
    } else if (percentage >= 0.4) {
      return '👍 محاولة جيدة! تدرب أكثر! 💪';
    } else {
      return '📚 لنتعلم أكثر عن أركان الإسلام! 😄';
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
              colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
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
                border: Border.all(color: Colors.amberAccent, width: 3),
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
                        '⭐ نتيجتك الأولى: $firstScore / ${questions.length}',
                        style: const TextStyle(fontSize: 18.0, color: Colors.purple),
                      ),
                    ),
                  if (lastScore != null && lastScore != firstScore)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '✨ نتيجتك السابقة: $lastScore / ${questions.length}',
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
                        color: Colors.amber),
                  ),
                  const SizedBox(height: 25.0),
                  ElevatedButton.icon(
                    onPressed: _resetQuiz,
                    icon: const Icon(Icons.replay, color: Colors.white),
                    label: const Text('🔁 حاول مرة أخرى!', style: TextStyle(fontSize: 18, color: Colors.white)),
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
                colors: [Color(0xFFFFD700), Color(0xFFFFFACD)],
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
                  color: const Color(0xFFFFF8DC),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.amber, width: 3.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeInDown(
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          '🕌',
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
                                            : Colors.yellowAccent,
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
                              color: feedbackMessage == '✨ إجابة صحيحة! 👍'
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
                  color: Colors.amberAccent,
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
                  color: Colors.yellowAccent,
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