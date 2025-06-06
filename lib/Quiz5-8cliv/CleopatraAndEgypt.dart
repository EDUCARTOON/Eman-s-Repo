import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';

void main() {
  runApp(const CleopatraAndEgyptQuizApp());
}

class CleopatraAndEgyptQuizApp extends StatelessWidget {
  const CleopatraAndEgyptQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبار كليوباترا ومصر القديمة',
      theme: ThemeData(
        primarySwatch: Colors.amber,
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
    // True/False Quiz
    {
      'question': 'كانت كليوباترا آخر ملكة لمصر القديمة.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'كانت كليوباترا امرأة جميلة وذكية.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'تحدثت كليوباترا سبع لغات.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'كانت الأهرامات منازل بناها الفراعنة ليعيشوا فيها.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'خطأ',
    },
    {
      'question': 'دُفن الفراعنة وعائلاتهم في الأهرامات.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'لم يكن نهر النيل مهمًا في مصر القديمة.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'خطأ',
    },
    {
      'question': 'استخدم الأطباء في مصر القديمة أدوات في عملياتهم.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    // Multiple Choice Quiz
    {
      'question': 'ما هو اسم آخر ملكة لمصر القديمة؟',
      'options': ['نفرتيتي', 'حتشبسوت', 'كليوباترا', 'إيزيس'],
      'correctAnswer': 'كليوباترا',
    },
    {
      'question': 'بماذا اشتهرت كليوباترا؟',
      'options': ['جمالها فقط', 'ذكائها فقط', 'جمالها وذكائها', 'لا شيء مما سبق'],
      'correctAnswer': 'جمالها وذكائها',
    },
    {
      'question': 'كم لغة تحدثت كليوباترا؟',
      'options': ['ثلاث لغات', 'خمس لغات', 'سبع لغات', 'تسع لغات'],
      'correctAnswer': 'سبع لغات',
    },
    {
      'question': 'ما هي الأهرامات؟',
      'options': ['منازل', 'معابد', 'مقابر', 'أسواق'],
      'correctAnswer': 'مقابر',
    },
    {
      'question': 'ما هو نهر النيل؟',
      'options': [
        'أقصر نهر في أفريقيا',
        'أطول نهر في أفريقيا',
        'نهر في آسيا',
        'نهر في أوروبا'
      ],
      'correctAnswer': 'أطول نهر في أفريقيا',
    },
    {
      'question': 'ماذا فعل الأطباء في مصر القديمة؟',
      'options': [
        'شفوا جميع الأمراض',
        'كل طبيب عالج مرضًا مختلفًا',
        'لم يعالجوا أي أمراض',
        'لا شيء مما سبق'
      ],
      'correctAnswer': 'كل طبيب عالج مرضًا مختلفًا',
    },
    {
      'question': 'ماذا فعلوا بالجثث في مصر القديمة؟',
      'options': [
        'تركوها كما هي',
        'دفنوها دون تحضير',
        'حنطوها وحافظوا عليها',
        'لا شيء مما سبق'
      ],
      'correctAnswer': 'حنطوها وحافظوا عليها',
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
      return 'أنت خبير في تاريخ مصر القديمة وكليوباترا! 👑🇪🇬';
    } else if (percentage >= 0.6) {
      return 'معلومات رائعة عن الحضارة المصرية وملكتها الأخيرة! 🏺😊';
    } else if (percentage >= 0.4) {
      return 'محاولة ممتازة! استمر في استكشاف أسرار الماضي! 👍';
    } else {
      return 'هيا نتعلم المزيد عن كليوباترا وعظمة مصر القديمة! 🗺️😄';
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
              colors: [Color(0xFFFFC107), Color(0xFFFF9800)],
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
                        '⭐ النتيجة الأولى: $firstScore / ${questions.length}',
                        style: const TextStyle(fontSize: 18.0, color: Colors.purple),
                      ),
                    ),
                  if (lastScore != null && lastScore != firstScore)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '✨ النتيجة السابقة: $lastScore / ${questions.length}',
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
                colors: [Color(0xFFFFC107), Color(0xFFFFEE58)],
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
                  color: const Color(0xFFFFECB3),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.amber, width: 3.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeInDown(
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Icon(Icons.history, size: 40.0),
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
                                            : Colors.amberAccent,
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
              child: const Icon(Icons.temple_hindu, size: 50, color: Colors.amberAccent),
            ),
          ),
        ],
      ),
    );
  }
}