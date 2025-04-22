import 'dart:math';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const ChatBotApp());
}

class ChatBotApp extends StatelessWidget {
  const ChatBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Offline ChatBot for Students',
      home: ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  late stt.SpeechToText _speech;
  bool _isListening = false;
  final FlutterTts _flutterTts = FlutterTts();

  final List<String> allQuestions = [
    "ما هو الإسلام؟", "ما هي التكنولوجيا؟", "أين تقع الأهرامات؟",
    "ما هو السلوك؟", "ما هي القراءة؟", "ما هو الترفيه؟",
    "ما هو الفن؟", "ما هي الأسرة؟", "ما هو الحيوان؟",
    "ما هو الطعام الصحي؟", "ما هي الموسيقى؟", "ما هو الكتاب؟",
  ];

  late List<String> suggestedQuestions;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    suggestedQuestions = getRandomQuestions();
  }

  List<String> getRandomQuestions() {
    allQuestions.shuffle(Random());
    return allQuestions.take(6).toList();
  }

  Future<void> speak(String text) async {
    await _flutterTts.setLanguage("ar-EG");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.6);
    await _flutterTts.speak(text);
  }

  String getBotResponse(String message) {
    message = message.toLowerCase().trim();

    if (message.contains("السلام") || message.contains("مرحبا")) {
      return "وعليكم السلام! كيف أقدر أساعدك؟";
    } else if (message.contains("اسمك") || message.contains("مين انت")) {
      return "أنا شات بوت تعليمي للأطفال من سن 3 إلى 12 سنة.";
    } else if (message.contains("الاهرام") || message.contains("الاهرامات") || message.contains("تقع الأهرامات") || message.contains("أين تقع الأهرامات")) {
      return "تقع الأهرامات الثلاثة في منطقة الجيزة في مصر.";
    } else if (message.contains("عاصمة") && message.contains("مصر")) {
      return "عاصمة مصر هي القاهرة.";
    } else if ((message.contains("كم") || message.contains("عدد")) && message.contains("الكواكب")) {
      return "عدد كواكب المجموعة الشمسية هو 8.";
    } else if ((message.contains("أكبر") || message.contains("اكبر")) && message.contains("حيوان")) {
      return "أكبر حيوان في العالم هو الحوت الأزرق.";
    } else if (message.contains("شكرا") || message.contains("شكرًا")) {
      return "العفو! سعيد بمساعدتك 😊";
    } else if (message.contains("ما هو الحيوان")) {
      return "الحيوان هو كائن حي يتنفس ويتغذى.";
    } else if (message.contains("ما هي التكنولوجيا")) {
      return "التكنولوجيا هي استخدام المعرفة لصنع أدوات جديدة.";
    } else if (message.contains("ما هو السلوك")) {
      return "السلوك هو الطريقة التي يتصرف بها الشخص.";
    } else if (message.contains("ما هو الترفيه")) {
      return "الترفيه هو الأنشطة التي تسعد الناس.";
    } else if (message.contains("ما هو الدين")) {
      return "الدين هو مجموعة من المعتقدات والممارسات الروحية.";
    } else if (message.contains("ما هو الإسلام")) {
      return "الإسلام هو دين يتبع تعاليم القرآن.";
    } else if (message.contains("ما هي القراءة")) {
      return "القراءة هي عملية فهم الكتابة.";
    } else if (message.contains("ما هو الكتاب")) {
      return "الكتاب هو مجموعة من الصفحات المكتوبة.";
    } else if (message.contains("ما هو الفن")) {
      return "الفن هو تعبير عن الإبداع والجمال.";
    } else if (message.contains("ما هي الموسيقى")) {
      return "الموسيقى هي فن تنظيم الأصوات واللحن.";
    } else if (message.contains("ما هو الطعام الصحي")) {
      return "الطعام الصحي هو ما يساعد الجسم على النمو والبقاء بصحة جيدة.";
    } else if (message.contains("ما هي الأسرة")) {
      return "الأسرة هي مجموعة من الأشخاص المرتبطين ببعضهم البعض.";
    } else if (message.contains("your name") || message.contains("who are you")) {
      return "I'm an educational chatbot for kids!";
    } else if (message.contains("pyramids") || message.contains("where are the pyramids")) {
      return "The pyramids are located in Giza, Egypt.";
    } else if (message.contains("capital") && message.contains("egypt")) {
      return "The capital of Egypt is Cairo.";
    } else if (message.contains("how many") && message.contains("planets")) {
      return "There are 8 planets in the solar system.";
    } else if (message.contains("biggest") && message.contains("animal")) {
      return "The biggest animal in the world is the blue whale.";
    } else if (message.contains("thank you") || message.contains("thanks")) {
      return "You're welcome! 😊";
    } else if (message.contains("what is animal")) {
      return "An animal is a living creature that breathes and eats.";
    } else if (message.contains("what is technology")) {
      return "Technology is the use of knowledge to create new tools.";
    } else if (message.contains("what is behavior")) {
      return "Behavior is the way a person acts.";
    } else if (message.contains("what is entertainment")) {
      return "Entertainment is activities that make people happy.";
    } else if (message.contains("what is religion")) {
      return "Religion is a set of beliefs and spiritual practices.";
    } else if (message.contains("what is islam")) {
      return "Islam is a religion that follows the teachings of the Quran.";
    } else if (message.contains("what is reading")) {
      return "Reading is the process of understanding written text.";
    } else if (message.contains("what is a book")) {
      return "A book is a collection of written pages.";
    } else if (message.contains("what is art")) {
      return "Art is a form of creative expression and beauty.";
    } else if (message.contains("what is music")) {
      return "Music is the art of organizing sounds and melody.";
    } else if (message.contains("what is healthy food")) {
      return "Healthy food is what helps the body grow and stay well.";
    } else if (message.contains("what is family")) {
      return "Family is a group of people related to each other.";
    }

    return "آسف، لا أفهم هذا السؤال حتى الآن.\nSorry, I don't understand that question yet.";
  }

  void sendMessage(String message) {
    final response = getBotResponse(message);
    setState(() {
      _messages.add({"sender": "user", "message": message});
      _messages.add({"sender": "bot", "message": response});
    });
    speak(response);
    _controller.clear();
  }

  Widget _buildMessage(Map<String, String> message) {
    bool isUser = message['sender'] == 'user';
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isUser ? Colors.lightBlueAccent : Colors.orange[100],
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          message['message'] ?? '',
          style: TextStyle(color: isUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: suggestedQuestions.map((question) {
        return ActionChip(
          label: Text(question, style: const TextStyle(fontSize: 13)),
          backgroundColor: Colors.grey[200],
          onPressed: () => sendMessage(question),
        );
      }).toList(),
    );
  }

  Future<void> _simulateVoiceToText() async {
    var status = await Permission.microphone.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يجب السماح باستخدام المايكروفون")),
      );
      return;
    }

    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          localeId: 'ar_EG',
          onResult: (result) {
            setState(() {
              _controller.text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🤖 EduCartoon Bot"),
        backgroundColor: const Color(0xFF89A1C0),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildMessage(_messages[index]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(_isListening ? Icons.mic_off : Icons.mic, color: Colors.redAccent),
                  onPressed: _simulateVoiceToText,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: "✏️ اكتب سؤالك هنا...",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 22),
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        sendMessage(_controller.text.trim());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: _buildSuggestions(),
          ),
        ],
      ),
    );
  }
}

