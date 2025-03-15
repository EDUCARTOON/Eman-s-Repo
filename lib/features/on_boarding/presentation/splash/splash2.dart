import 'package:flutter/material.dart';
import 'package:flutter_application_3/signup1.dart';

class Splash2 extends StatelessWidget {
  const Splash2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF93AACF), // تغيير لون الخلفية
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // زر Skip
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 20), // تقليل المسافة من الأعلى
            child: Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Signup1()),
                  );
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          const Spacer(), // لدفع العناصر للأسفل

          // الصورة
          Image.asset(
            'assets/img/Download_Book__Character__Glasses__Royalty-Free_Vector_Graphic-removebg-preview 1.png',
            width: 320, // حجم مناسب للصورة
            height: 320,
          ),

          const SizedBox(height: 0), // زيادة المسافة بعد الصورة

          // العناوين
          const Text(
            'Get Online Certificate',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 0),
          const Text(
            'Analyse your scores and Track your results',
            style: TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 100), // إنزال الزر لأسفل

          // زر "Get Started" محاذى لليمين
          Align(
            alignment: Alignment.centerRight, // محاذاة الزر لليمين
            child: Padding(
              padding: const EdgeInsets.only(right: 30), // مسافة من اليمين
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Signup1()),
                  );
                },
                child: Container(
                  width: 180,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 40), // مسافة صغيرة قبل نهاية الصفحة
        ],
      ),
    );
  }
}
