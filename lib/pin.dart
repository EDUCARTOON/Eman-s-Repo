import 'package:flutter/material.dart';
import 'package:flutter_application_3/profilekids.dart';

class Pin extends StatefulWidget {
  const Pin({super.key});

  @override
  _PinState createState() => _PinState();
}

class _PinState extends State<Pin> {
  List<String> pinList = ['', '', '', '']; // قائمة لتخزين الأرقام المدخلة

  void _addPin(String number) {
    for (int i = 0; i < pinList.length; i++) {
      if (pinList[i].isEmpty) {
        setState(() {
          pinList[i] = number; // إضافة الرقم إلى المربع الفارغ
        });
        break;
      }
    }
  }

  void _removePin() {
    for (int i = pinList.length - 1; i >= 0; i--) {
      if (pinList[i].isNotEmpty) {
        setState(() {
          pinList[i] = ''; // مسح الرقم من المربع
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF93AACF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Create New Pin',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
                width: 200,
                child: Image(
                  image: AssetImage('assets/img/photo_2024-11-22_20-18-14-removebg-preview.png'), // تأكد من إضافة الصورة في مجلد assets
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'To make sure your kids don\'t change their sensitive topics and sharing settings. You can lock the modification of these features with a secret number.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18, // تكبير حجم الخط
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // حدود المربع
                      borderRadius: BorderRadius.circular(10), // زوايا مدورة
                      color: Colors.white, // خلفية بيضاء
                    ),
                    child: Center(
                      child: Text(
                        pinList[index].isEmpty ? '*' : pinList[index], // عرض الرقم المدخل أو علامة النجمة
                        style: const TextStyle(
                          fontSize: 24, // حجم الخط
                          color: Colors.black, // لون الخط
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemCount: 12, // 10 أرقام + 2 لنجمة والصفر
                itemBuilder: (context, index) {
                  String buttonLabel;
                  if (index < 9) {
                    buttonLabel = '${index + 1}';
                  } else if (index == 9) {
                    buttonLabel = '0';
                  } else if (index == 10) {
                    buttonLabel = '*';
                  } else {
                    buttonLabel = '×'; // زر المسح
                  }

                  return TextButton(
                    onPressed: () {
                      if (buttonLabel == '×') {
                        _removePin(); // مسح الرقم
                      } else {
                        _addPin(buttonLabel); // إضافة الرقم
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent, // خلفية شفافة
                      padding: const EdgeInsets.all(20), // حجم الزر
                    ),
                    child: Text(
                      buttonLabel,
                      style: const TextStyle(
                        fontSize: 24, // حجم النص
                        color: Colors.black, // لون النص
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileKids()),
                    );
                    // هنا يمكنك إضافة الإجراء المطلوب عند الضغط على زر "Continue"
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
