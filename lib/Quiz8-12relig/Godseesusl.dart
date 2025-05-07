
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';
import '../core/app_shared_variables.dart';
import '../core/services/firebase_services.dart';
void main() {
  runApp(const Godseesusl());
}

class Godseesusl extends StatelessWidget {
  const Godseesusl({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبار الله يرانا',
      theme: ThemeData(
        primarySwatch: Colors.orange,
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
    // أسئلة صح أو خطأ
    {
      'question': 'في القصة، أعطت المعلمة كل طفل تفاحة.',
      'options': ['✅ صح', '❌ خطأ'],
      'correctAnswer': '✅ صح',
    },
    {
      'question': 'أكل تامر التفاحة على سطح مبنى شاهق.',
      'options': ['✅ صح', '❌ خطأ'],
      'correctAnswer': '✅ صح',
    },
    {
      'question': 'أكل أحمد التفاحة في الصحراء.',
      'options': ['✅ صح', '❌ خطأ'],
      'correctAnswer': '✅ صح',
    },
    {
      'question': 'أكل خالد التفاحة في حديقة منزله.',
      'options': ['✅ صح', '❌ خطأ'],
      'correctAnswer': '✅ صح',
    },
    {
      'question': 'لم يكن مع أي من الأطفال أحد عندما أكلوا التفاحات.',
      'options': ['✅ صح', '❌ خطأ'],
      'correctAnswer': '❌ خطأ',
    },
    // أسئلة اختيار من متعدد
    {
      'question': 'أين أكل تامر تفاحته؟',
      'options': ['أ. في الفصل', 'ب. على سطح مبنى', 'ج. في الصحراء', 'د. في حديقة'],
      'correctAnswer': 'ب. على سطح مبنى',
    },
    {
      'question': 'من هم الأطفال الذين أكلوا تفاحاتهم بمفردهم؟',
      'options': ['أ. تامر', 'ب. أحمد', 'ج. خالد', 'د. جميع ما سبق'],
      'correctAnswer': 'د. جميع ما سبق',
    },
    {
      'question': 'هل الله يرى كل مكان؟',
      'options': ['أ. نعم', 'ب. لا'],
      'correctAnswer': 'أ. نعم',
    },
    {
      'question': 'أين يرى الله الناس؟',
      'options': ['أ. في الفصل الدراسي', 'ب. في أي مكان', 'ج. في الصحراء فقط', 'د. في الحديقة فقط'],
      'correctAnswer': 'ب. في أي مكان',
    },
    {
      'question': 'لماذا كان يجب على الأطفال أن يتذكروا أن الله يراهم؟',
      'options': ['أ. لأن الله قريب منهم', 'ب. لأن الله بعيد عنهم', 'ج. لأن الله يرانا في كل مكان', 'د. لأن الله لا يرانا'],
      'correctAnswer': 'ج. لأن الله يرانا في كل مكان',
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
            FirebaseFile.addResult(email!, "Religion", "5-15", '$firstScore', 'Days of the Week Quiz');// حفظ النتيجة عند انتهاء الاختبار

          }
        });
      });
    });
  }

  String getResultMessage() {
    double percentage = correctAnswersCount / questions.length;
    if (percentage >= 0.8) {
      return '🎉 ممتاز! أنت تتذكر أن الله يرانا دائمًا! 🥳';
    } else if (percentage >= 0.6) {
      return '👏 جيد جدًا! استمر في التفكير في مراقبة الله! 😊';
    } else if (percentage >= 0.4) {
      return '👍 محاولة جيدة! تذكر أن الله معك في كل مكان! 💪';
    } else {
      return '📚 لنتعلم أكثر عن أن الله يرانا! 😄';
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
              colors: [Color(0xFFFF9800), Color(0xFFFFC107)],
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
                colors: [Color(0xFFFF9800), Color(0xFFFFE0B2)],
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
                  color: const Color(0xFFFFFAF0),
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
                          '👁️',
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
                  color: Colors.amberAccent,
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