import 'package:flutter/material.dart';
import 'package:flutter_application_3/features/on_boarding/presentation/splash/splash2.dart';

class Splash1 extends StatelessWidget {
  const Splash1({super.key});

  @override
  Widget build(BuildContext context) {
    var align = Align(
              alignment: Alignment.centerRight, // تحريك السهم إلى اليمين
              child: Padding(
                padding: const EdgeInsets.only(right: 30), // إضافة مسافة من الجهة اليمنى
                child: GestureDetector(
                  onTap: () {
                    // الانتقال إلى الصفحة التالية عند الضغط على السهم
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Splash2()), // قم بتغيير الصفحة هنا
                    );
                  },
                  child: const CircleAvatar(
                    radius: 30, // حجم الدائرة
                    backgroundColor: Colors.black, // لون الخلفية (دائرة سوداء)
                    child: Icon(
                      Icons.arrow_forward, // أيقونة السهم
                      color: Colors.white, // لون السهم
                      size: 30, // حجم السهم
                    ),
                  ),
                ),
              ),
            );
    return Scaffold(
      backgroundColor: const Color(0xFF93AACF), // لون خلفية مشابه
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
                    // الانتقال إلى الصفحة التالية عند الضغط على الزر
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Splash2()),
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
            const SizedBox(height: 10), // تقليل المسافة بين الزر والصورة
            Image.asset(
              'assets/img/cute-little-penguin--cartoon-animal-.png', // مسار الصورة
              width: 400, // عرض الصورة
              height: 400, // ارتفاع الصورة
            ),
            const SizedBox(height: 0), // إزالة المسافة بين الصورة والنص
            const Text(
              'Learn at Anytime',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10), // مسافة بين النص والنص التالي
            const Text(
              'Booked or save the Lectures for Future',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 40), // مسافة إضافية قبل السهم

            // زر السهم داخل دائرة سوداء وتحريكها لليمين
        align,
          ],
        ),
      ),
    );
  }
}




