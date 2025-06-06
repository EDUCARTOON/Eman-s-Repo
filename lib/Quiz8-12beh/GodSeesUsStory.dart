import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';

void main() {
  runApp(const GodSeesUsStoryQuizApp());
}

class GodSeesUsStoryQuizApp extends StatelessWidget {
  const GodSeesUsStoryQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبار: قصة الله يرانا',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
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
      'question': 'صح أم خطأ: القصة تُبيّن أن الله يرانا فقط في الأماكن العامة.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'خطأ',
    },
    {
      'question': 'صح أم خطأ: اختيار الأطفال لأماكن منعزلة لأكل التفاح يدل على محاولتهم إخفاء أفعالهم عن الله.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    {
      'question': 'صح أم خطأ: نجح جميع الأطفال في إيجاد مكان لا يراهم الله فيه.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'خطأ',
    },
    {
      'question': 'صح أم خطأ: تُشير نهاية القصة إلى أن الله لا يرى إلا السلوكيات السيئة.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'خطأ',
    },
    {
      'question': 'صح أم خطأ: يُمكن اعتبار القصة قصةً رمزيةً تُعلّم الأطفال عن أهمية الصدق والأمانة.',
      'options': ['صح', 'خطأ'],
      'correctAnswer': 'صح',
    },
    // اختر الإجابة الصحيحة
    {
      'question': 'ما هو الهدف الرئيسي من القصة؟',
      'options': ['أ. تسلية الأطفال.', 'ب. تعليم الأطفال عن أنواع التفاح.', 'ج. تثقيف الأطفال بأن الله يرانا في كل مكان.', 'د. وصف أماكن مختلفة.'],
      'correctAnswer': 'ج. تثقيف الأطفال بأن الله يرانا في كل مكان.',
    },
    {
      'question': 'ما هو الشعور الذي يُفترض أن يُشعره الأطفال بعد سماع القصة؟',
      'options': ['أ. الخوف من الله فقط.', 'ب. الراحة والاطمئنان من الله.', 'ج. الوعي بأن الله يرانا في كل مكان، مما يدفعنا للتصرف بشكل صحيح.', 'د. الحرية في التصرف دون قيود.'],
      'correctAnswer': 'ج. الوعي بأن الله يرانا في كل مكان، مما يدفعنا للتصرف بشكل صحيح.',
    },
    {
      'question': 'لماذا لم ينجح مالك في إيجاد مكان لا يراه الله فيه؟',
      'options': ['أ. لأنه لم يبحث جيدًا.', 'ب. لأن الله يرى كل شيء في كل مكان.', 'ج. لأنه كان في مكان مُزدحم.', 'د. لأنه لم يكن مُخلصًا في البحث.'],
      'correctAnswer': 'ب. لأن الله يرى كل شيء في كل مكان.',
    },
    {
      'question': 'ما هو الدرس المُستفاد من قصة مالك؟',
      'options': ['أ. يجب علينا دائمًا إخفاء أفعالنا عن الآخرين.', 'ب. لا يوجد مكان نستطيع فيه الهروب من مسؤوليتنا.', 'ج. يجب علينا دائمًا التصرف بشكل صحيح لأن الله يرانا في كل مكان.', 'د. يجب علينا التصرّف فقط عندما يُراقبنا الآخرون.'],
      'correctAnswer': 'ج. يجب علينا دائمًا التصرف بشكل صحيح لأن الله يرانا في كل مكان.',
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
      return 'ما شاء الله! فهم ممتاز للقصة! ✨';
    } else if (percentage >= 0.6) {
      return 'عمل جيد! استيعاب رائع! 😊';
    } else if (percentage >= 0.4) {
      return 'محاولة طيبة! لنراجع القصة معًا! 👍';
    } else {
      return 'لا بأس، قراءة متأنية أخرى ستساعدك! 😄';
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
        appBar: AppBar(title: const Text('انتهى اختبار القصة')),
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
                    color: Colors.deepOrange),
              ),
              const SizedBox(height: 25.0),
              ElevatedButton.icon(
                onPressed: _resetQuiz,
                icon: const Icon(Icons.replay, color: Colors.white),
                label: const Text('إعادة الاختبار 🔄', style: TextStyle(fontSize: 18, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
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
      appBar: AppBar(title: const Text('اختبار: قصة الله يرانا')),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 68, 51, 46), Color.fromARGB(255, 153, 101, 86)],
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
                  border: Border.all(color: Colors.deepOrange, width: 3.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeInDown(
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Icon(Icons.book, size: 40.0, color: Colors.deepOrange),
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
                                            : Colors.deepOrange,
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
              child: const Icon(Icons.book, size: 50, color: Colors.orangeAccent),
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