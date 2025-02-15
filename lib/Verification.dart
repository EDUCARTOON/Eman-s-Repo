import 'package:flutter/material.dart';
import 'package:flutter_application_3/newpassword.dart';
import 'new_password_page.dart'; // تأكد من استيراد الصفحة الجديدة

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<Verification> {
  final List<String> _code = List.filled(4, ''); // قائمة لتمثيل الأرقام المدخلة

  void _onDigitPressed(String digit) {
    for (int i = 0; i < _code.length; i++) {
      if (_code[i].isEmpty) {
        setState(() {
          _code[i] = digit;
        });
        break;
      }
    }
  }

  void _onDeletePressed() {
    for (int i = _code.length - 1; i >= 0; i--) {
      if (_code[i].isNotEmpty) {
        setState(() {
          _code[i] = '';
        });
        break;
      }
    }
  }

  void _onVerifyPressed() {
    // الانتقال إلى صفحة إنشاء كلمة المرور
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Newpassword()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFF93AACF),
      appBar: AppBar(
        title: const Text('Verification'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Verification',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Code has been sent to ........@gmail.com',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: Text(
                      _code[index],
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            const Text(
              'Resend Code in 59s',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onVerifyPressed,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.white, // لون الزر
                  side: const BorderSide(color: Color(0xFF6200EE)), // حدود الزر
                ),
                child: const Text(
                  'Verify',
                  style: TextStyle(color: Color(0xFF6200EE), fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: 11, // الأرقام من 0 إلى 9 + زر المسح
              itemBuilder: (context, index) {
                if (index == 10) {
                  return ElevatedButton(
                    onPressed: _onDeletePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, // إزالة الشكل
                      elevation: 0,
                    ),
                    child: const Icon(
                      Icons.clear, // علامة المسح
                      color: Colors.red,
                      size: 40, // حجم أكبر
                    ),
                  );
                }
                return ElevatedButton(
                  onPressed: () => _onDigitPressed('$index'), // الأرقام من 0 إلى 9
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // إزالة الشكل
                    elevation: 0,
                  ),
                  child: Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    child: Text(
                      '$index',
                      style: const TextStyle(color: Color(0xFF6200EE), fontSize: 24),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}