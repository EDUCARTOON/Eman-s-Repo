import 'package:flutter/material.dart';
import 'package:flutter_application_3/signup1.dart';

class Splash2 extends StatelessWidget {
  const Splash2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF93AACF), // تغيير لون الخلفية
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // جعل العناصر تبدأ من الأعلى
          crossAxisAlignment: CrossAxisAlignment.center, // جعل العناصر تكون في المنتصف أفقياً
          children: [
            // زر "Skip" مع مسافة من الأعلى
            Padding(
              padding: const EdgeInsets.only(top: 40), // مسافة من الأعلى
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    // الانتقال إلى صفحة Signup1 عند الضغط على الزر
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
            // الصورة
            const SizedBox(height: 20), // مسافة بين الزر والصورة
            Image.asset(
              'assets/img/Download_Book__Character__Glasses__Royalty-Free_Vector_Graphic-removebg-preview 1.png', // مسار الصورة
              width: 400, // عرض الصورة
              height: 400, // ارتفاع الصورة
            ),
            const SizedBox(height: 20), // مسافة بين الصورة والنص
            const Text(
              'Get Online Certificate',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10), // مسافة بين النص والنص التالي
            const Text(
              'Analyse your scores and Track your results',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40), // مسافة إضافية قبل السهم

            // زر "Get Started" مع السهم داخل دائرة سوداء وتحريكه لليمين
            Align(
              alignment: Alignment.centerRight, // تحريك الزر إلى اليمين
              child: Padding(
                padding: const EdgeInsets.only(right: 30), // إضافة مسافة من الجهة اليمنى
                child: TextButton(
                  onPressed: () {
                    // الانتقال إلى الصفحة التالية عند الضغط على الزر
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Signup1()), // قم بتغيير الصفحة هنا
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255), // لون الخلفية للزر
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30), // الحواف والمسافة داخل الزر
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min, // لتقليص المسافة بين النص والسهم
                    children: [
                      Text(
                        'Get Started', // النص داخل الزر
                        style: TextStyle(
                          color: Colors.black, // لون النص
                          fontSize: 16, // حجم النص
                        ),
                      ),
                      SizedBox(width: 10), // مسافة بين النص والأيقونة
                      // دائرة سوداء بداخلها سهم أبيض
                      CircleAvatar(
                        radius: 20, // حجم الدائرة
                        backgroundColor: Color.fromARGB(255, 0, 0, 0), // لون الخلفية (دائرة بيضاء)
                        child: Icon(
                          Icons.arrow_forward, // أيقونة السهم
                          color: Color.fromARGB(255, 255, 255, 255), // لون السهم
                          size: 20, // حجم السهم
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
